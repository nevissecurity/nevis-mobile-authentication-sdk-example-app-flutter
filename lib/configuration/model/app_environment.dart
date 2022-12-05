// Copyright © 2022 Nevis Security AG. All rights reserved.

enum AppEnvironment {
  authenticationCloud,
  identitySuite,
}

extension AppEnvironmentExtension on AppEnvironment {
  String get configFileName {
    switch (this) {
      case AppEnvironment.authenticationCloud:
        return 'config_authentication_cloud.json';
      case AppEnvironment.identitySuite:
        return 'config_identity_suite.json';
    }
  }
}
