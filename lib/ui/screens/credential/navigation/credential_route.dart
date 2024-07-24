// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/credential/credential_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/credential/credential_screen.dart';

class CredentialRoute {
  static const credential = "credentials";

  Map<String, WidgetBuilder> get routes => {
        credential: (context) => BlocProvider<CredentialBloc>(
              create: (_) => GetIt.I.get<CredentialBloc>(),
              child: const CredentialScreen(),
            )
      };
}
