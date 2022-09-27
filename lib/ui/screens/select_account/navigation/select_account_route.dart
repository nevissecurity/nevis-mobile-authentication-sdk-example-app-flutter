// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_account/select_account_screen.dart';

class SelectAccountRoute {
  static const selectAccount = "select_account";

  Map<String, WidgetBuilder> get routes => {
        selectAccount: (context) => const SelectAccountScreen(),
      };
}
