// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';

class Credentials {
  final String username;
  final AuthorizationProvider? authorizationProvider;

  Credentials({
    required this.username,
    required this.authorizationProvider,
  });

  Credentials.empty()
      : username = "",
        authorizationProvider = null;
}
