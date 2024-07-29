// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/credential/credential_kind.dart';

abstract class AppEvent {}

class AppDomainEvent extends AppEvent {
  DomainState domainState;

  AppDomainEvent(this.domainState);
}

class VerifyUserCredentialEvent extends AppEvent {
  final CredentialKind kind;
  final PinAuthenticatorProtectionStatus? pinProtectionStatus;
  final PasswordAuthenticatorProtectionStatus? passwordProtectionStatus;
  final RecoverableError? lastRecoverableError;

  VerifyUserCredentialEvent({
    required this.kind,
    this.pinProtectionStatus,
    this.passwordProtectionStatus,
    this.lastRecoverableError,
  });
}
