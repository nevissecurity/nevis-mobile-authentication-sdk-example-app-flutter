// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/pin/pin_mode.dart';

@immutable
abstract class PinState {}

@immutable
class PinCreatedState extends PinState {}

@immutable
class PinUpdatedState extends PinState {
  final PinMode mode;
  final RecoverableError? lastRecoverableError;
  final PinAuthenticatorProtectionStatus? protectionStatus;
  final PinMode? previousMode;

  PinUpdatedState.enrollment({
    this.protectionStatus,
    this.lastRecoverableError,
    this.previousMode,
  }) : mode = PinMode.enrollment;

  PinUpdatedState.verification({
    this.protectionStatus,
    this.lastRecoverableError,
    this.previousMode,
  }) : mode = PinMode.verification;

  PinUpdatedState.pinChange({
    this.protectionStatus,
    this.lastRecoverableError,
    this.previousMode,
  }) : mode = PinMode.credentialChange;
}
