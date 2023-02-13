// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/change_device_information/change_device_information_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/change_device_information/change_device_information_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/change_device_information/change_device_information_screen.dart';

class ChangeDeviceInformationRoute {
  static const changeDeviceInformation = "change_device_information";

  Map<String, WidgetBuilder> get routes => {
        changeDeviceInformation: (context) => BlocProvider(
              create: (_) => GetIt.I.get<ChangeDeviceInformationBloc>()
                ..add(ChangeDeviceInformationScreenCreated()),
              child: const ChangeDeviceInformationScreen(),
            ),
      };
}
