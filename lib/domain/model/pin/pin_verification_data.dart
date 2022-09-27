// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';

class PinVerificationData {
  final PinAuthenticatorProtectionStatus? protectionStatus;
  final RecoverableError? lastRecoverableError;

  PinVerificationData({this.protectionStatus, this.lastRecoverableError});
}
