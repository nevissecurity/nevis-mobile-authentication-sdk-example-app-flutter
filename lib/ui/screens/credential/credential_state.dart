// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/credential/credential_kind.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/credential/credential_mode.dart';

@immutable
abstract class CredentialState {}

@immutable
class CredentialCreatedState extends CredentialState {}

@immutable
class CredentialUpdatedState extends CredentialState {
  final CredentialMode mode;
  final CredentialKind kind;
  final RecoverableError? lastRecoverableError;
  final PinAuthenticatorProtectionStatus? pinProtectionStatus;
  final PasswordAuthenticatorProtectionStatus? passwordProtectionStatus;
  final CredentialMode? previousMode;

  CredentialUpdatedState.enrollment({
    required this.kind,
    this.pinProtectionStatus,
    this.passwordProtectionStatus,
    this.lastRecoverableError,
    this.previousMode,
  }) : mode = CredentialMode.enrollment;

  CredentialUpdatedState.verification({
    required this.kind,
    this.pinProtectionStatus,
    this.passwordProtectionStatus,
    this.lastRecoverableError,
    this.previousMode,
  }) : mode = CredentialMode.verification;

  CredentialUpdatedState.change({
    required this.kind,
    this.pinProtectionStatus,
    this.passwordProtectionStatus,
    this.lastRecoverableError,
    this.previousMode,
  }) : mode = CredentialMode.change;
}
