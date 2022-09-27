// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_authenticator/navigation/select_authenticator_parameter.dart';

abstract class SelectAuthenticatorEvent {}

class SelectAuthenticatorCreatedEvent extends SelectAuthenticatorEvent {
  final SelectAuthenticatorParameter parameter;

  SelectAuthenticatorCreatedEvent(this.parameter);
}

class AuthenticatorSelectedEvent extends SelectAuthenticatorEvent {
  final Authenticator authenticator;

  AuthenticatorSelectedEvent(this.authenticator);
}
