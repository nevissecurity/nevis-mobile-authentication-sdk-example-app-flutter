// Copyright © 2022 Nevis Security AG. All rights reserved.

abstract class AuthCloudApiRegistrationEvent {}

class RegistrationConfirmedEvent extends AuthCloudApiRegistrationEvent {
  final String? enrollResponse;
  final String? appLinkUri;

  RegistrationConfirmedEvent({
    required this.enrollResponse,
    required this.appLinkUri,
  });
}

class RegistrationCancelledEvent extends AuthCloudApiRegistrationEvent {}
