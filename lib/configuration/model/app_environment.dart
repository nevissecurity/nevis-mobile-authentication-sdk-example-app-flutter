// Copyright © 2022 Nevis Security AG. All rights reserved.

enum AppEnvironment {
  cloud,
  onPremise,
}

extension AppEnvironmentExtension on AppEnvironment {
  String get configFileName {
    switch (this) {
      case AppEnvironment.cloud:
        return 'config_cloud.json';
      case AppEnvironment.onPremise:
        return 'config_on_premise.json';
    }
  }
}
