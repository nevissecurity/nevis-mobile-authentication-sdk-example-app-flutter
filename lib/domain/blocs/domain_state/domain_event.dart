// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/authenticator/authenticator_item.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/credential/credential_kind.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';

abstract class DomainEvent {}

class SelectAccountEvent extends DomainEvent {
  final OperationType operationType;
  final Set<Account> accounts;
  final String? transactionConfirmationData;

  SelectAccountEvent({
    required this.operationType,
    required this.accounts,
    this.transactionConfirmationData,
  });
}

class TransactionConfirmationEvent extends DomainEvent {
  final String transactionData;
  final Account? selectedAccount;

  TransactionConfirmationEvent({
    required this.transactionData,
    this.selectedAccount,
  });
}

class SelectAuthenticatorEvent extends DomainEvent {
  final Set<AuthenticatorItem> authenticatorItems;
  final OperationType? operationType;

  SelectAuthenticatorEvent({
    required this.authenticatorItems,
    this.operationType,
  });
}

class ResultEvent extends DomainEvent {
  final String? description;

  ResultEvent({
    this.description,
  });
}

class AuthenticationSucceededEvent extends DomainEvent {
  final OperationType operation;
  final AuthorizationProvider? authorizationProvider;
  final String? description;

  AuthenticationSucceededEvent({
    required this.operation,
    this.authorizationProvider,
    this.description,
  });
}

abstract class CredentialEvent extends DomainEvent {
  final String aaid;
  final CredentialKind kind;
  final PinAuthenticatorProtectionStatus? pinProtectionStatus;
  final PasswordAuthenticatorProtectionStatus? passwordProtectionStatus;
  final RecoverableError? lastRecoverableError;

  CredentialEvent({
    required this.aaid,
    this.pinProtectionStatus,
    this.passwordProtectionStatus,
    this.lastRecoverableError,
  }) : kind = aaid.isPin ? CredentialKind.pin : CredentialKind.password;
}

class CredentialEnrollmentEvent extends CredentialEvent {
  CredentialEnrollmentEvent({
    required super.aaid,
    super.pinProtectionStatus,
    super.passwordProtectionStatus,
    super.lastRecoverableError,
  });
}

class CredentialUserVerificationEvent extends CredentialEvent {
  CredentialUserVerificationEvent({
    required super.aaid,
    super.pinProtectionStatus,
    super.passwordProtectionStatus,
    super.lastRecoverableError,
  });
}

class CredentialChangeEvent extends CredentialEvent {
  CredentialChangeEvent({
    required super.aaid,
    super.pinProtectionStatus,
    super.passwordProtectionStatus,
    super.lastRecoverableError,
  });
}

class FingerPrintUserVerificationEvent extends DomainEvent {}

class BiometricUserVerificationEvent extends DomainEvent {}

class DevicePasscodeUserVerificationEvent extends DomainEvent {}
