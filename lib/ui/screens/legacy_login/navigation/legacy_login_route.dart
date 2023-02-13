// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/legacy_login/legacy_login_screen.dart';

class LegacyLoginRoute {
  static const legacyLogin = "legacy_login";

  Map<String, WidgetBuilder> get routes =>
      {legacyLogin: (context) => const LegacyLoginScreen()};
}
