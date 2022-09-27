// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/local_data/local_data_state.dart';

abstract class HomeEvent {}

class HomeCreatedEvent extends HomeEvent {}

class ClientInitializedEvent extends HomeEvent {}

class OOBRedirectArrivedEvent extends HomeEvent {
  final String redirectUri;

  OOBRedirectArrivedEvent(this.redirectUri);
}

class ReadQrCodeEvent extends HomeEvent {}

class DeregisterEvent extends HomeEvent {}

class InBandAuthenticationEvent extends HomeEvent {}

class InBandRegisterEvent extends HomeEvent {}

class PinChangeEvent extends HomeEvent {}

class ChangeDeviceInformationEvent extends HomeEvent {}

class AuthCloudApiRegistrationEvent extends HomeEvent {}

class LocalDataEvent extends HomeEvent {
  final LocalDataState state;

  LocalDataEvent(this.state);
}
