// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/credential/credential_kind.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/credential/credential_mode.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/credential/credential_verification_data.dart';

class CredentialParameter {
  final CredentialMode mode;
  final CredentialKind kind;
  final String? username;
  final CredentialVerificationData? verificationData;

  CredentialParameter.pinEnrollment({
    required this.username,
  })  : mode = CredentialMode.enrollment,
        kind = CredentialKind.pin,
        verificationData = null;

  CredentialParameter.pinVerification({
    required this.verificationData,
  })  : mode = CredentialMode.verification,
        kind = CredentialKind.pin,
        username = null;

  CredentialParameter.pinChange({
    required this.username,
  })  : mode = CredentialMode.change,
        kind = CredentialKind.pin,
        verificationData = null;

  CredentialParameter.passwordEnrollment({
    required this.username,
  })  : mode = CredentialMode.enrollment,
        kind = CredentialKind.password,
        verificationData = null;

  CredentialParameter.passwordVerification({
    required this.verificationData,
  })  : mode = CredentialMode.verification,
        kind = CredentialKind.password,
        username = null;

  CredentialParameter.passwordChange({
    required this.username,
  })  : mode = CredentialMode.change,
        kind = CredentialKind.password,
        verificationData = null;
}
