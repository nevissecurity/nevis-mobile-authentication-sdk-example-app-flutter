// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/pin/pin_mode.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/pin/pin_verification_data.dart';

class PinParameter {
  final PinMode mode;
  final String? username;
  final PinVerificationData? pinVerificationData;

  PinParameter.enrollment({
    required this.username,
  })  : mode = PinMode.enrollment,
        pinVerificationData = null;

  PinParameter.verification({required this.pinVerificationData})
      : mode = PinMode.verification,
        username = null;

  PinParameter.credentialChange({
    required this.username,
  })  : mode = PinMode.credentialChange,
        pinVerificationData = null;
}
