// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/behaviour_subject_mixin.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/user_interaction_operation_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

@singleton
class DomainBloc extends Bloc<DomainEvent, DomainState>
    with BehaviorSubjectMixin<DomainEvent, DomainState> {
  final StateRepository<UserInteractionOperationState>
      _userInteractionOperationStateRepository;

  DomainBloc(
    this._userInteractionOperationStateRepository,
  ) : super(DomainInitialState()) {
    on<SelectAccountEvent>(_handleSelectAccount);
    on<SelectAuthenticatorEvent>(_handleSelectAuthenticator);
    on<TransactionConfirmationEvent>(_handleTransactionConfirmation);
    on<ResultEvent>(_handleResult);
    on<CredentialEnrollmentEvent>(_handleCredentialEnrollment);
    on<CredentialUserVerificationEvent>(_handleCredentialVerification);
    on<FingerPrintUserVerificationEvent>(_handleFingerPrintVerification);
    on<BiometricUserVerificationEvent>(_handleBiometricVerification);
    on<DevicePasscodeUserVerificationEvent>(_handleDevicePasscodeVerification);
    on<CredentialChangeEvent>(_handleCredentialChange);
    on<AuthenticationSucceededEvent>(_handleAuthenticationSucceeded);
  }

  Future<void> _handleSelectAccount(
    SelectAccountEvent event,
    Emitter<DomainState> emit,
  ) async {
    emit(
      DomainSelectAccountState(
        operationType: event.operationType,
        accounts: event.accounts,
        transactionConfirmationData: event.transactionConfirmationData,
      ),
    );
  }

  Future<void> _handleSelectAuthenticator(
    SelectAuthenticatorEvent event,
    Emitter<DomainState> emit,
  ) async {
    emit(
      DomainSelectAuthenticatorState(
        authenticatorItems: event.authenticatorItems,
        operationType: event.operationType,
      ),
    );
  }

  Future<void> _handleTransactionConfirmation(
    TransactionConfirmationEvent event,
    Emitter<DomainState> emit,
  ) async {
    emit(
      DomainTransactionConfirmationState(
        transactionData: event.transactionData,
        selectedAccount: event.selectedAccount,
      ),
    );
  }

  Future<void> _handleCredentialEnrollment(
    CredentialEnrollmentEvent event,
    Emitter<DomainState> emit,
  ) async {
    emit(
      DomainCredentialState.enrollment(
        aaid: event.aaid,
        kind: event.kind,
        pinProtectionStatus: event.pinProtectionStatus,
        passwordProtectionStatus: event.passwordProtectionStatus,
        lastRecoverableError: event.lastRecoverableError,
      ),
    );
  }

  Future<void> _handleCredentialVerification(
    CredentialUserVerificationEvent event,
    Emitter<DomainState> emit,
  ) async {
    emit(
      DomainCredentialState.verification(
        aaid: event.aaid,
        kind: event.kind,
        pinProtectionStatus: event.pinProtectionStatus,
        passwordProtectionStatus: event.passwordProtectionStatus,
        lastRecoverableError: null,
      ),
    );
  }

  Future<void> _handleFingerPrintVerification(
    FingerPrintUserVerificationEvent event,
    Emitter<DomainState> emit,
  ) async {
    emit(DomainVerifyFingerPrintState());
  }

  Future<void> _handleBiometricVerification(
    BiometricUserVerificationEvent event,
    Emitter<DomainState> emit,
  ) async {
    emit(DomainVerifyBiometricState());
  }

  Future<void> _handleDevicePasscodeVerification(
    DevicePasscodeUserVerificationEvent event,
    Emitter<DomainState> emit,
  ) async {
    emit(DomainVerifyDevicePasscodeState());
  }

  Future<void> _handleCredentialChange(
    CredentialChangeEvent event,
    Emitter<DomainState> emit,
  ) async {
    emit(
      DomainCredentialState.change(
        aaid: event.aaid,
        kind: event.kind,
        pinProtectionStatus: event.pinProtectionStatus,
        passwordProtectionStatus: event.passwordProtectionStatus,
        lastRecoverableError: event.lastRecoverableError,
      ),
    );
  }

  Future<void> _handleResult(
    ResultEvent event,
    Emitter<DomainState> emit,
  ) async {
    _userInteractionOperationStateRepository.reset();
    emit(DomainResultState(description: event.description));
  }

  Future<void> _handleAuthenticationSucceeded(
    AuthenticationSucceededEvent event,
    Emitter<DomainState> emit,
  ) async {
    if (event.operation == OperationType.deregistration) {
      final username = _userInteractionOperationStateRepository
          .state?.authenticatorSelectionContext?.account.username;
      emit(
        DomainAuthenticationSucceededState(
          operationType: event.operation,
          username: username,
          authorizationProvider: event.authorizationProvider,
        ),
      );
    } else {
      emit(DomainResultState(description: event.description));
    }
    _userInteractionOperationStateRepository.reset();
  }
}
