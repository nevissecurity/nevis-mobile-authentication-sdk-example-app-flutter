// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/result/result_screen.dart';

class ResultRoute {
  static const result = "result";

  Map<String, WidgetBuilder> get routes => {result: (context) => const ResultScreen()};
}
