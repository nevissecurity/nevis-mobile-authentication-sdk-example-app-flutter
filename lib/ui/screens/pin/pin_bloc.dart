// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/error/error_handler.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/error/error.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/pin/pin_mode.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/cancel_pin_operation_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/cancel_user_interaction_operation_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/provided_pins_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/set_pin_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/verify_pin_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/pin/pin_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/pin/pin_state.dart';

@injectable
class PinBloc extends Bloc<PinEvent, PinState> {
  final DomainBloc _domainBloc;
  final CancelPinOperationUseCase _cancelPinOperationUseCase;
  final ProvidedPinsUseCase _providedPinUseCase;
  final CancelUserInteractionOperationUseCase
      _cancelUserInteractionOperationUseCase;
  final SetPinUseCase _setPinUseCase;
  final VerifyPinUseCase _verifyPinUseCase;
  final ErrorHandler _errorHandler;
  late StreamSubscription _domainSubscription;

  PinBloc(
    this._domainBloc,
    this._cancelPinOperationUseCase,
    this._providedPinUseCase,
    this._cancelUserInteractionOperationUseCase,
    this._setPinUseCase,
    this._verifyPinUseCase,
    this._errorHandler,
  ) : super(PinCreatedState()) {
    on<PinCreatedEvent>(_handlePinCreatedEvent);
    on<PinEnterEvent>(_handlePinEnterEvent);
    on<UserCancelledEvent>(_handleCancelledEvent);
    on<PinDomainEvent>(_handlePinDomainEvent);

    _domainSubscription = _domainBloc.listen((DomainState state) {
      if (state is DomainPinState) {
        _handleDomainPinState(state);
      }
    });
  }

  Future<void> _handlePinCreatedEvent(
    PinCreatedEvent event,
    Emitter<PinState> emit,
  ) async {
    try {
      if (event.mode == PinMode.verification) {
        final pinVerificationData = event.pinVerificationData;
        if (pinVerificationData == null) {
          throw BusinessException.invalidState();
        }

        final state = PinUpdatedState.verification(
          protectionStatus: pinVerificationData.protectionStatus,
          lastRecoverableError: pinVerificationData.lastRecoverableError,
        );
        emit(state);
      } else {
        final username = event.username;
        if (username == null) {
          throw BusinessException.invalidState();
        }
      }
    } on Exception catch (error) {
      _errorHandler.handle(error);
    }
  }

  Future<void> _handlePinEnterEvent(
    PinEnterEvent event,
    Emitter<PinState> emit,
  ) async {
    final credentials = event.credentials;
    switch (event.mode) {
      case PinMode.enrollment:
        await _setPinUseCase.execute(credentials.pinValue).catchError((error) {
          _errorHandler.handle(error);
        });
        break;
      case PinMode.verification:
        await _verifyPinUseCase
            .execute(credentials.pinValue)
            .catchError((error) {
          _errorHandler.handle(error);
        });
        break;
      case PinMode.credentialChange:
        if (credentials.oldValue == null) {
          debugPrint('Old credentials value is null during pin change!');
          _errorHandler.handle(BusinessException.invalidState());
        }
        await _providedPinUseCase
            .execute(
          oldPin: credentials.oldValue!,
          newPin: credentials.pinValue,
        )
            .catchError((error) {
          _errorHandler.handle(error);
        });
        break;
    }
  }

  Future<void> _handleCancelledEvent(
    UserCancelledEvent event,
    Emitter<PinState> emit,
  ) async {
    switch (event.mode) {
      case PinMode.enrollment:
      case PinMode.credentialChange:
        await _cancelPinOperationUseCase.execute().catchError((error) {
          _errorHandler.handle(error);
        });
        break;
      case PinMode.verification:
        await _cancelUserInteractionOperationUseCase
            .execute()
            .catchError((error) {
          _errorHandler.handle(error);
        });
        break;
    }
  }

  Future<void> _handlePinDomainEvent(
    PinDomainEvent event,
    Emitter<PinState> emit,
  ) async {
    final previousMode =
        state is PinUpdatedState ? (state as PinUpdatedState).mode : null;
    if (event is PinEnrollmentEvent) {
      final state = PinUpdatedState.enrollment(
        protectionStatus: event.protectionStatus,
        lastRecoverableError: event.lastRecoverableError,
        previousMode: previousMode,
      );
      emit(state);
    } else if (event is PinChangeEvent) {
      final state = PinUpdatedState.pinChange(
        protectionStatus: event.protectionStatus,
        lastRecoverableError: event.lastRecoverableError,
        previousMode: previousMode,
      );
      emit(state);
    } else if (event is PinUserVerificationEvent) {
      final state = PinUpdatedState.verification(
        protectionStatus: event.protectionStatus,
        lastRecoverableError: event.lastRecoverableError,
        previousMode: previousMode,
      );
      emit(state);
    }
  }

  void _handleDomainPinState(DomainPinState state) {
    switch (state.mode) {
      case PinMode.enrollment:
        _handlePinEnrollmentState(state);
        break;
      case PinMode.verification:
        _handlePinVerificationState(state);
        break;
      case PinMode.credentialChange:
        _handlePinChangeState(state);
        break;
    }
  }

  Future<void> _handlePinEnrollmentState(DomainPinState domainState) async {
    final event = PinEnrollmentEvent(
      lastRecoverableError: domainState.lastRecoverableError,
      protectionStatus: domainState.protectionStatus,
    );

    add(event);
  }

  Future<void> _handlePinVerificationState(DomainPinState domainState) async {
    final event = PinUserVerificationEvent(
      lastRecoverableError: domainState.lastRecoverableError,
      protectionStatus: domainState.protectionStatus,
    );

    add(event);
  }

  Future<void> _handlePinChangeState(DomainPinState domainState) async {
    final event = PinChangeEvent(
      lastRecoverableError: domainState.lastRecoverableError,
      protectionStatus: domainState.protectionStatus,
    );

    add(event);
  }

  @override
  Future<void> close() {
    _domainSubscription.cancel();
    return super.close();
  }
}
