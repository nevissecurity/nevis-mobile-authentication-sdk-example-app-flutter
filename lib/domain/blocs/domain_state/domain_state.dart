// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/authenticator/authenticator_item.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/credential/credential_kind.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/credential/credential_mode.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';

@immutable
abstract class DomainState {}

class DomainInitialState extends DomainState {}

@immutable
abstract class DomainVerifyState extends DomainState {
  final String aaid;

  DomainVerifyState({
    required this.aaid,
  });
}

class DomainCredentialState extends DomainVerifyState {
  final CredentialMode mode;
  final CredentialKind kind;
  final PinAuthenticatorProtectionStatus? pinProtectionStatus;
  final PasswordAuthenticatorProtectionStatus? passwordProtectionStatus;
  final RecoverableError? lastRecoverableError;

  DomainCredentialState.enrollment({
    required super.aaid,
    required this.kind,
    this.pinProtectionStatus,
    this.passwordProtectionStatus,
    this.lastRecoverableError,
  }) : mode = CredentialMode.enrollment;

  DomainCredentialState.verification({
    required super.aaid,
    required this.kind,
    this.pinProtectionStatus,
    this.passwordProtectionStatus,
    this.lastRecoverableError,
  }) : mode = CredentialMode.verification;

  DomainCredentialState.change({
    required super.aaid,
    required this.kind,
    this.pinProtectionStatus,
    this.passwordProtectionStatus,
    this.lastRecoverableError,
  }) : mode = CredentialMode.change;
}

class DomainVerifyFingerPrintState extends DomainVerifyState {
  DomainVerifyFingerPrintState() : super(aaid: Aaid.fingerprint.rawValue);
}

class DomainVerifyBiometricState extends DomainVerifyState {
  DomainVerifyBiometricState() : super(aaid: Aaid.biometric.rawValue);
}

class DomainVerifyDevicePasscodeState extends DomainVerifyState {
  DomainVerifyDevicePasscodeState() : super(aaid: Aaid.devicePasscode.rawValue);
}

class DomainSelectAuthenticatorState extends DomainState {
  final OperationType? operationType;
  final Set<AuthenticatorItem> authenticatorItems;

  DomainSelectAuthenticatorState({
    required this.authenticatorItems,
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

  DomainTransactionConfirmationState({
    required this.transactionData,
    this.selectedAccount,
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
