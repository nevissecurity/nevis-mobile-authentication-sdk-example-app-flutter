// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/pin/pin_mode.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/pin/pin_verification_data.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/pin/model/pin_credentials.dart';

abstract class PinEvent {}

class PinCreatedEvent extends PinEvent {
  final PinMode mode;
  final String? username;
  final PinVerificationData? pinVerificationData;

  PinCreatedEvent({
    required this.mode,
    this.username,
    this.pinVerificationData,
  });
}

class PinEnterEvent extends PinEvent {
  final PinMode mode;
  final PinCredentials credentials;

  PinEnterEvent({required this.mode, required this.credentials});
}

class UserCancelledEvent extends PinEvent {
  final PinMode mode;

  UserCancelledEvent(this.mode);
}

abstract class PinDomainEvent extends PinEvent {
  final PinAuthenticatorProtectionStatus? protectionStatus;

  PinDomainEvent({
    required this.protectionStatus,
  });
}

class PinEnrollmentEvent extends PinDomainEvent {
  final RecoverableError? lastRecoverableError;

  PinEnrollmentEvent({
    super.protectionStatus,
    this.lastRecoverableError,
  });
}

class PinUserVerificationEvent extends PinDomainEvent {
  final RecoverableError? lastRecoverableError;

  PinUserVerificationEvent({
    super.protectionStatus,
    this.lastRecoverableError,
  });
}

class PinChangeEvent extends PinDomainEvent {
  final RecoverableError? lastRecoverableError;

  PinChangeEvent({
    super.protectionStatus,
    this.lastRecoverableError,
  });
}
