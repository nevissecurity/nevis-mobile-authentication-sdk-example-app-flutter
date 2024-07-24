// Copyright © 2024 Nevis Security AG. All rights reserved.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/error/error_handler.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/credential/credential_mode.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/error/error.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/cancel_credential_operation_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/cancel_user_interaction_operation_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/provided_credentials_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/enroll_credential_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/verify_credential_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/credential/credential_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/credential/credential_state.dart';

@injectable
class CredentialBloc extends Bloc<CredentialEvent, CredentialState> {
  final DomainBloc _domainBloc;
  final CancelCredentialOperationUseCase _cancelCredentialOperationUseCase;
  final ProvidedCredentialsUseCase _providedCredentialsUseCase;
  final CancelUserInteractionOperationUseCase
      _cancelUserInteractionOperationUseCase;
  final EnrollCredentialUseCase _enrollCredentialUseCase;
  final VerifyCredentialUseCase _verifyCredentialUseCase;
  final ErrorHandler _errorHandler;
  late StreamSubscription _domainSubscription;

  CredentialBloc(
    this._domainBloc,
    this._cancelCredentialOperationUseCase,
    this._providedCredentialsUseCase,
    this._cancelUserInteractionOperationUseCase,
    this._enrollCredentialUseCase,
    this._verifyCredentialUseCase,
    this._errorHandler,
  ) : super(CredentialCreatedState()) {
    on<CredentialCreatedEvent>(_handleCredentialsCreatedEvent);
    on<CredentialEnterEvent>(_handleCredentialsEnterEvent);
    on<UserCancelledEvent>(_handleCancelledEvent);
    on<CredentialDomainEvent>(_handleCredentialsDomainEvent);

    _domainSubscription = _domainBloc.listen((DomainState state) {
      if (state is DomainCredentialState) {
        _handleDomainCredentialsState(state);
      }
    });
  }

  Future<void> _handleCredentialsCreatedEvent(
    CredentialCreatedEvent event,
    Emitter<CredentialState> emit,
  ) async {
    try {
      switch (event.mode) {
        case CredentialMode.enrollment:
        case CredentialMode.change:
          if (event.username == null) {
            throw BusinessException.invalidState();
          }
          break;
        case CredentialMode.verification:
          final verificationData = event.verificationData;
          if (verificationData == null) {
            throw BusinessException.invalidState();
          }

          final state = CredentialUpdatedState.verification(
            kind: event.kind,
            pinProtectionStatus: verificationData.pinProtectionStatus,
            passwordProtectionStatus: verificationData.passwordProtectionStatus,
            lastRecoverableError: verificationData.lastRecoverableError,
          );
          emit(state);
          break;
      }
    } on Exception catch (error) {
      _errorHandler.handle(error);
    }
  }

  Future<void> _handleCredentialsEnterEvent(
    CredentialEnterEvent event,
    Emitter<CredentialState> emit,
  ) async {
    final credentials = event.credentials;
    switch (event.mode) {
      case CredentialMode.enrollment:
        await _enrollCredentialUseCase
            .execute(event.kind, credentials.value)
            .catchError((error) {
          _errorHandler.handle(error);
        });
        break;
      case CredentialMode.verification:
        await _verifyCredentialUseCase
            .execute(event.kind, credentials.value)
            .catchError((error) {
          _errorHandler.handle(error);
        });
        break;
      case CredentialMode.change:
        if (credentials.oldValue == null) {
          debugPrint(
              'Old credentials value is null during credentials change!');
          _errorHandler.handle(BusinessException.invalidState());
        }
        await _providedCredentialsUseCase
            .execute(
          kind: event.kind,
          oldCredential: credentials.oldValue!,
          newCredential: credentials.value,
        )
            .catchError((error) {
          _errorHandler.handle(error);
        });
        break;
    }
  }

  Future<void> _handleCancelledEvent(
    UserCancelledEvent event,
    Emitter<CredentialState> emit,
  ) async {
    switch (event.mode) {
      case CredentialMode.enrollment:
      case CredentialMode.change:
        await _cancelCredentialOperationUseCase.execute().catchError((error) {
          _errorHandler.handle(error);
        });
        break;
      case CredentialMode.verification:
        await _cancelUserInteractionOperationUseCase
            .execute()
            .catchError((error) {
          _errorHandler.handle(error);
        });
        break;
    }
  }

  Future<void> _handleCredentialsDomainEvent(
    CredentialDomainEvent event,
    Emitter<CredentialState> emit,
  ) async {
    final previousMode = state is CredentialUpdatedState
        ? (state as CredentialUpdatedState).mode
        : null;
    if (event is CredentialEnrollmentEvent) {
      final state = CredentialUpdatedState.enrollment(
        kind: event.kind,
        pinProtectionStatus: event.pinProtectionStatus,
        passwordProtectionStatus: event.passwordProtectionStatus,
        lastRecoverableError: event.lastRecoverableError,
        previousMode: previousMode,
      );
      emit(state);
    } else if (event is CredentialChangeEvent) {
      final state = CredentialUpdatedState.change(
        kind: event.kind,
        pinProtectionStatus: event.pinProtectionStatus,
        passwordProtectionStatus: event.passwordProtectionStatus,
        lastRecoverableError: event.lastRecoverableError,
        previousMode: previousMode,
      );
      emit(state);
    } else if (event is CredentialUserVerificationEvent) {
      final state = CredentialUpdatedState.verification(
        kind: event.kind,
        pinProtectionStatus: event.pinProtectionStatus,
        passwordProtectionStatus: event.passwordProtectionStatus,
        lastRecoverableError: event.lastRecoverableError,
        previousMode: previousMode,
      );
      emit(state);
    }
  }

  void _handleDomainCredentialsState(DomainCredentialState state) {
    switch (state.mode) {
      case CredentialMode.enrollment:
        _handleCredentialsEnrollmentState(state);
        break;
      case CredentialMode.verification:
        _handleCredentialsVerificationState(state);
        break;
      case CredentialMode.change:
        _handleCredentialsChangeState(state);
        break;
    }
  }

  Future<void> _handleCredentialsEnrollmentState(
    DomainCredentialState domainState,
  ) async {
    final event = CredentialEnrollmentEvent(
      aaid: domainState.aaid,
      pinProtectionStatus: domainState.pinProtectionStatus,
      passwordProtectionStatus: domainState.passwordProtectionStatus,
      lastRecoverableError: domainState.lastRecoverableError,
    );

    add(event);
  }

  Future<void> _handleCredentialsVerificationState(
    DomainCredentialState domainState,
  ) async {
    final event = CredentialUserVerificationEvent(
      aaid: domainState.aaid,
      pinProtectionStatus: domainState.pinProtectionStatus,
      passwordProtectionStatus: domainState.passwordProtectionStatus,
      lastRecoverableError: domainState.lastRecoverableError,
    );

    add(event);
  }

  Future<void> _handleCredentialsChangeState(
    DomainCredentialState domainState,
  ) async {
    final event = CredentialChangeEvent(
      aaid: domainState.aaid,
      pinProtectionStatus: domainState.pinProtectionStatus,
      passwordProtectionStatus: domainState.passwordProtectionStatus,
      lastRecoverableError: domainState.lastRecoverableError,
    );

    add(event);
  }

  @override
  Future<void> close() {
    _domainSubscription.cancel();
    return super.close();
  }
}
