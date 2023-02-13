// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/pin/pin_mode.dart';

@immutable
abstract class DomainState {}

class DomainInitialState extends DomainState {}

@immutable
abstract class DomainVerifyState extends DomainState {}

class DomainPinState extends DomainVerifyState {
  final PinMode mode;
  final RecoverableError? lastRecoverableError;
  final PinAuthenticatorProtectionStatus? protectionStatus;

  DomainPinState.enrollment({
    required this.protectionStatus,
    this.lastRecoverableError,
  }) : mode = PinMode.enrollment;

  DomainPinState.verification({
    required this.protectionStatus,
    this.lastRecoverableError,
  }) : mode = PinMode.verification;

  DomainPinState.pinChange({
    required this.protectionStatus,
    this.lastRecoverableError,
  }) : mode = PinMode.credentialChange;
}

class DomainVerifyFingerPrintState extends DomainVerifyState {}

class DomainVerifyBiometricState extends DomainVerifyState {}

class DomainSelectAuthenticatorState extends DomainState {
  final OperationType? operationType;
  final Set<Authenticator> authenticators;

  DomainSelectAuthenticatorState({
    required this.authenticators,
    required this.operationType,
  });
}

class DomainResultState extends DomainState {
  final String? description;

  DomainResultState({
    this.description,
  });
}

class DomainSelectAccountState extends DomainState {
  final OperationType operationType;
  final Set<Account> accounts;
  final String? transactionConfirmationData;

  DomainSelectAccountState({
    required this.operationType,
    required this.accounts,
    this.transactionConfirmationData,
  });
}

class DomainTransactionConfirmationState extends DomainState {
  final String transactionData;
  final Account? selectedAccount;
  final Set<Authenticator>? authenticators;

  DomainTransactionConfirmationState({
    required this.transactionData,
    this.selectedAccount,
    this.authenticators,
  });
}

class DomainAuthenticationSucceededState extends DomainState {
  final OperationType operationType;
  final String? username;
  final AuthorizationProvider? authorizationProvider;

  DomainAuthenticationSucceededState({
    required this.operationType,
    required this.username,
    required this.authorizationProvider,
  });
}
