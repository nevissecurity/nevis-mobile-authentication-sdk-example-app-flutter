// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/auth_cloud_api_registration/auth_cloud_api_registration_screen.dart';

class AuthCloudApiRegistrationRoute {
  static const authCloudApiRegistration = "auth_cloud_api_registration";

  Map<String, WidgetBuilder> get routes => {
        authCloudApiRegistration: (context) =>
            const AuthCloudApiRegistrationScreen()
      };
}
