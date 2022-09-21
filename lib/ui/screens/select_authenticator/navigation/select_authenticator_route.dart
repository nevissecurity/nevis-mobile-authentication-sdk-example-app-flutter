// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_authenticator/select_authenticator_screen.dart';

class SelectAuthenticatorRoute {
  static const selectAuthenticator = "select_authenticator";

  Map<String, WidgetBuilder> get routes => {selectAuthenticator: (context) => const SelectAuthenticatorScreen()};
}
