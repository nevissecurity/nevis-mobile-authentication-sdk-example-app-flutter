// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';

class CredentialVerificationData {
  final PinAuthenticatorProtectionStatus? pinProtectionStatus;
  final PasswordAuthenticatorProtectionStatus? passwordProtectionStatus;
  final RecoverableError? lastRecoverableError;

  CredentialVerificationData({
    this.pinProtectionStatus,
    this.passwordProtectionStatus,
    this.lastRecoverableError,
  });
}
