// Copyright © 2024 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/credential/credential_kind.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/credential/credential_mode.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/credential/credential_verification_data.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/credential/model/credentials.dart';

abstract class CredentialEvent {}

class CredentialCreatedEvent extends CredentialEvent {
  final CredentialMode mode;
  final CredentialKind kind;
  final String? username;
  final CredentialVerificationData? verificationData;

  CredentialCreatedEvent({
    required this.mode,
    required this.kind,
    this.username,
    this.verificationData,
  });
}

class CredentialEnterEvent extends CredentialEvent {
  final CredentialMode mode;
  final CredentialKind kind;
  final Credentials credentials;

  CredentialEnterEvent({
    required this.mode,
    required this.kind,
    required this.credentials,
  });
}

abstract class CredentialDomainEvent extends CredentialEvent {
  final String aaid;
  final CredentialKind kind;
  final PinAuthenticatorProtectionStatus? pinProtectionStatus;
  final PasswordAuthenticatorProtectionStatus? passwordProtectionStatus;
  final RecoverableError? lastRecoverableError;

  CredentialDomainEvent({
    required this.aaid,
    this.pinProtectionStatus,
    this.passwordProtectionStatus,
    this.lastRecoverableError,
  }) : kind = aaid.isPin ? CredentialKind.pin : CredentialKind.password;
}

class CredentialEnrollmentEvent extends CredentialDomainEvent {
  CredentialEnrollmentEvent({
    required super.aaid,
    super.pinProtectionStatus,
    super.passwordProtectionStatus,
    super.lastRecoverableError,
  });
}

class CredentialUserVerificationEvent extends CredentialDomainEvent {
  CredentialUserVerificationEvent({
    required super.aaid,
    super.pinProtectionStatus,
    super.passwordProtectionStatus,
    super.lastRecoverableError,
  });
}

class CredentialChangeEvent extends CredentialDomainEvent {
  CredentialChangeEvent({
    required super.aaid,
    super.pinProtectionStatus,
    super.passwordProtectionStatus,
    super.lastRecoverableError,
  });
}

class UserCancelledEvent extends CredentialEvent {
  final CredentialMode mode;

  UserCancelledEvent(this.mode);
}
