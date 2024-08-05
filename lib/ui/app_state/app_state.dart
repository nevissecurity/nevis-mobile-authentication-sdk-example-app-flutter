// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/credential/credential_kind.dart';

abstract class AppState {
  bool get isListenable => false;
}

class InitialState extends AppState {}

abstract class VerifyState extends AppState {
  @override
  bool get isListenable => true;
}

class VerifyCredentialState extends VerifyState {
  final CredentialKind kind;
  final PinAuthenticatorProtectionStatus? pinProtectionStatus;
  final PasswordAuthenticatorProtectionStatus? passwordProtectionStatus;
  final RecoverableError? lastRecoverableError;

  VerifyCredentialState({
    required this.kind,
    this.pinProtectionStatus,
    this.passwordProtectionStatus,
    this.lastRecoverableError,
  });
}
