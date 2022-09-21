// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';

abstract class DomainEvent {}

class SelectAccountEvent extends DomainEvent {
  final OperationType operationType;
  final Set<Account> accounts;
  final String? transactionConfirmationData;

  SelectAccountEvent({required this.operationType, required this.accounts, this.transactionConfirmationData});
}

class TransactionConfirmationEvent extends DomainEvent {
  final String transactionData;
  final Account? selectedAccount;
  final Set<Authenticator>? authenticators;

  TransactionConfirmationEvent({
    required this.transactionData,
    this.selectedAccount,
    this.authenticators,
  });
}

class SelectAuthenticatorEvent extends DomainEvent {
  final Set<Authenticator> authenticators;
  final OperationType? operationType;

  SelectAuthenticatorEvent({required this.authenticators, this.operationType});
}

class ResultEvent extends DomainEvent {
  final String? description;

  ResultEvent({this.description});
}

class AuthenticationSucceededEvent extends DomainEvent {
  final OperationType operation;
  final AuthorizationProvider? authorizationProvider;
  final String? description;

  AuthenticationSucceededEvent({required this.operation, this.authorizationProvider, this.description});
}

abstract class PinEvent extends DomainEvent {
  final PinAuthenticatorProtectionStatus? protectionStatus;

  PinEvent({
    required this.protectionStatus,
  });
}

class PinEnrollmentEvent extends PinEvent {
  final PinEnrollmentError? lastRecoverableError;

  PinEnrollmentEvent({
    required PinAuthenticatorProtectionStatus? protectionStatus,
    this.lastRecoverableError,
  }) : super(
          protectionStatus: protectionStatus,
        );
}

class PinUserVerificationEvent extends PinEvent {
  final PinUserVerificationError? lastRecoverableError;

  PinUserVerificationEvent({
    required PinAuthenticatorProtectionStatus protectionStatus,
    this.lastRecoverableError,
  }) : super(
          protectionStatus: protectionStatus,
        );
}

class PinChangeEvent extends PinEvent {
  final PinChangeRecoverableError? lastRecoverableError;

  PinChangeEvent({
    required PinAuthenticatorProtectionStatus protectionStatus,
    this.lastRecoverableError,
  }) : super(
          protectionStatus: protectionStatus,
        );
}

class FingerPrintUserVerificationEvent extends DomainEvent {}

class BiometricUserVerificationEvent extends DomainEvent {}
