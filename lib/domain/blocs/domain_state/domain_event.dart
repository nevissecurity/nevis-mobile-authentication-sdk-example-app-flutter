// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/authenticator/authenticator_item.dart';
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

abstract class PinEvent extends DomainEvent {
  final PinAuthenticatorProtectionStatus? protectionStatus;

  PinEvent({
    required this.protectionStatus,
  });
}

class PinEnrollmentEvent extends PinEvent {
  final PinEnrollmentError? lastRecoverableError;

  PinEnrollmentEvent({
    required super.protectionStatus,
    this.lastRecoverableError,
  });
}

class PinUserVerificationEvent extends PinEvent {
  final PinUserVerificationError? lastRecoverableError;

  PinUserVerificationEvent({
    required PinAuthenticatorProtectionStatus protectionStatus,
    this.lastRecoverableError,
  }) : super(protectionStatus: protectionStatus);
}

class PinChangeEvent extends PinEvent {
  final PinChangeRecoverableError? lastRecoverableError;

  PinChangeEvent({
    required PinAuthenticatorProtectionStatus protectionStatus,
    this.lastRecoverableError,
  }) : super(protectionStatus: protectionStatus);
}

class FingerPrintUserVerificationEvent extends DomainEvent {}

class BiometricUserVerificationEvent extends DomainEvent {}

class DevicePasscodeUserVerificationEvent extends DomainEvent {}
