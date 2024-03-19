// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';

abstract class AppState {
  bool get isListenable => false;
}

class InitialState extends AppState {}

abstract class VerifyState extends AppState {
  @override
  bool get isListenable => true;
}

class VerifyPinState extends VerifyState {
  final PinAuthenticatorProtectionStatus? protectionStatus;
  final RecoverableError? lastRecoverableError;

  VerifyPinState({
    required this.protectionStatus,
    this.lastRecoverableError,
  });
}
