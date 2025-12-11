// Copyright © 2024 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/confirmation/navigation/confirmation_parameter.dart';

abstract class ConfirmationEvent {}

class ConfirmationCreatedEvent extends ConfirmationEvent {
  final ConfirmationParameter parameter;

  ConfirmationCreatedEvent(this.parameter);
}

class ConfirmationUserAcceptedEvent extends ConfirmationEvent {}

class ConfirmationUserCancelledEvent extends ConfirmationEvent {}

class ConfirmationBiometricEvent extends ConfirmationEvent {
  final String title;
  final String description;
  final String cancelButtonText;
  final String fallbackButtonText;

  ConfirmationBiometricEvent({
    required this.title,
    required this.description,
    required this.cancelButtonText,
    required this.fallbackButtonText,
  });
}

class ConfirmationFingerprintEvent extends ConfirmationEvent {
  final String description;
  final String cancelButtonText;
  final String fallbackButtonText;

  ConfirmationFingerprintEvent({
    required this.description,
    required this.cancelButtonText,
    required this.fallbackButtonText,
  });
}

class ConfirmationDevicePasscodeEvent extends ConfirmationEvent {
  final String title;
  final String description;

  ConfirmationDevicePasscodeEvent({
    required this.title,
    required this.description,
  });
}

class ConfirmationPauseListeningEvent extends ConfirmationEvent {}

class ConfirmationResumeListeningEvent extends ConfirmationEvent {}
