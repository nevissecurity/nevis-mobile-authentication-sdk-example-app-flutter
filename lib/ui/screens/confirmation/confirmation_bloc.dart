// Copyright © 2024 Nevis Security AG. All rights reserved.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/error/error_handler.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/biometric_listen_for_os_credentials_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/cancel_user_interaction_operation_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/device_passcode_listen_for_os_credentials_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/fingerprint_listen_for_os_credentials_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/pause_listening_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/resume_listening_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/confirmation/confirmation_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/confirmation/confirmation_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/confirmation/navigation/confirmation_parameter.dart';

@injectable
class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  final BiometricListenForOsCredentialsUseCase
      _biometricListenForOsCredentialsUseCase;
  final FingerPrintListenForOsCredentialsUseCase
      _fingerPrintListenForOsCredentialsUseCase;
  final DevicePasscodeListenForOsCredentialsUseCase
      _devicePasscodeListenForOsCredentialsUseCase;
  final CancelUserInteractionOperationUseCase
      _cancelUserInteractionOperationUseCase;
  final PauseListeningUseCase _pauseListeningUseCase;
  final ResumeListeningUseCase _resumeListeningUseCase;
  final ErrorHandler _errorHandler;
  late ConfirmationParameter _parameter;

  ConfirmationBloc(
    this._biometricListenForOsCredentialsUseCase,
    this._fingerPrintListenForOsCredentialsUseCase,
    this._devicePasscodeListenForOsCredentialsUseCase,
    this._cancelUserInteractionOperationUseCase,
    this._pauseListeningUseCase,
    this._resumeListeningUseCase,
    this._errorHandler,
  ) : super(ConfirmationInitialState()) {
    on<ConfirmationCreatedEvent>(_handleCreated);
    on<ConfirmationUserAcceptedEvent>(_handleUserAccepted);
    on<ConfirmationUserCancelledEvent>(_handleUserCancelled);
    on<ConfirmationBiometricEvent>(_handleBiometric);
    on<ConfirmationFingerPrintEvent>(_handleFingerPrint);
    on<ConfirmationDevicePasscodeEvent>(_handleDevicePasscode);
    on<ConfirmationPauseListeningEvent>(_handlePauseListening);
    on<ConfirmationResumeListeningEvent>(_handleResumeListening);
  }

  void _handleCreated(
    ConfirmationCreatedEvent event,
    Emitter<ConfirmationState> emit,
  ) {
    _parameter = event.parameter;
    emit(
      ConfirmationLoadedState(
        aaid: event.parameter.aaid,
      ),
    );
  }

  Future<void> _handleUserAccepted(
    ConfirmationUserAcceptedEvent event,
    Emitter<ConfirmationState> emit,
  ) async {
    if (_parameter.aaid == Aaid.biometric.rawValue) {
      emit(ConfirmBiometricState());
    } else if (_parameter.aaid == Aaid.fingerprint.rawValue) {
      emit(ConfirmFingerPrintLoadedState(aaid: Aaid.fingerprint.rawValue));
      await _fingerPrintListenForOsCredentialsUseCase
          .execute()
          .catchError((error) {
        _errorHandler.handle(error);
      });
    } else if (_parameter.aaid == Aaid.devicePasscode.rawValue) {
      emit(ConfirmDevicePasscodeState());
    }
  }

  Future<void> _handleUserCancelled(
    ConfirmationUserCancelledEvent event,
    Emitter<ConfirmationState> emit,
  ) async {
    await _cancelUserInteractionOperationUseCase.execute().catchError((error) {
      _errorHandler.handle(error);
    });
  }

  Future<void> _handleBiometric(
    ConfirmationBiometricEvent event,
    Emitter<ConfirmationState> emit,
  ) async {
    await _biometricListenForOsCredentialsUseCase
        .execute(
      BiometricPromptOptions(
        title: event.title,
        description: event.description,
        cancelButtonText: event.cancelButtonText,
      ),
    )
        .catchError((error) {
      _errorHandler.handle(error);
    });
  }

  Future<void> _handleFingerPrint(
    ConfirmationFingerPrintEvent event,
    Emitter<ConfirmationState> emit,
  ) async {
    await _fingerPrintListenForOsCredentialsUseCase
        .execute()
        .catchError((error) {
      _errorHandler.handle(error);
    });
  }

  Future<void> _handleDevicePasscode(
    ConfirmationDevicePasscodeEvent event,
    Emitter<ConfirmationState> emit,
  ) async {
    await _devicePasscodeListenForOsCredentialsUseCase
        .execute(
      DevicePasscodePromptOptions(
        title: event.title,
        description: event.description,
      ),
    )
        .catchError((error) {
      _errorHandler.handle(error);
    });
  }

  Future<void> _handlePauseListening(
    ConfirmationPauseListeningEvent event,
    Emitter<ConfirmationState> emit,
  ) async {
    await _pauseListeningUseCase.execute().catchError((error) {
      _errorHandler.handle(error);
    });
  }

  Future<void> _handleResumeListening(
    ConfirmationResumeListeningEvent event,
    Emitter<ConfirmationState> emit,
  ) async {
    await _resumeListeningUseCase.execute().catchError((error) {
      _errorHandler.handle(error);
    });
  }
}
