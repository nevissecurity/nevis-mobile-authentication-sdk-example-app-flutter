// Copyright © 2024 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/confirmation/confirmation_screen.dart';

class ConfirmationRoute {
  static const confirmation = "confirmation";

  Map<String, WidgetBuilder> get routes =>
      {confirmation: (context) => const ConfirmationScreen()};
}
