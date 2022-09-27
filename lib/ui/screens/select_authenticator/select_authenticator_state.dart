// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_authenticator/navigation/select_authenticator_parameter.dart';

@immutable
abstract class SelectAuthenticatorState {}

class SelectAuthenticatorInitialState extends SelectAuthenticatorState {}

class SelectAuthenticatorLoadedState extends SelectAuthenticatorState {
  final SelectAuthenticatorParameter parameter;

  SelectAuthenticatorLoadedState(this.parameter);
}
