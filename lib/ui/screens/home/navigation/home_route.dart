// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/home/home_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/home/home_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/home/home_screen.dart';

class HomeRoute {
  static const home = '/';

  Map<String, WidgetBuilder> get routes => {
        home: (context) => BlocProvider<HomeBloc>(
              create: (_) => GetIt.I.get<HomeBloc>()..add(HomeCreatedEvent()),
              child: const HomeScreen(),
            ),
      };
}
