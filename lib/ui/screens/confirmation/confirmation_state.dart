// Copyright © 2024 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';

@immutable
abstract class ConfirmationState {
  bool get isListenable => false;
}

class ConfirmationInitialState extends ConfirmationState {}

class ConfirmationLoadedState extends ConfirmationState {
  final String aaid;

  ConfirmationLoadedState({
    required this.aaid,
  });
}

class ConfirmFingerPrintLoadedState extends ConfirmationLoadedState {
  ConfirmFingerPrintLoadedState({required super.aaid});
}

abstract class ConfirmUserAcceptedState extends ConfirmationState {
  @override
  bool get isListenable => true;
}

class ConfirmBiometricState extends ConfirmUserAcceptedState {}

class ConfirmDevicePasscodeState extends ConfirmUserAcceptedState {}
