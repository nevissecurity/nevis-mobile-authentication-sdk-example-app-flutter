// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/pin/pin_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/pin/pin_screen.dart';

class PinRoute {
  static const pin = "pin";

  Map<String, WidgetBuilder> get routes => {
        pin: (context) => BlocProvider<PinBloc>(
              create: (_) => GetIt.I.get<PinBloc>(),
              child: const PinScreen(),
            )
      };
}
