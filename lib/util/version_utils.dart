// Copyright © 2025 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';

extension VersionExtension on Version {
  String formatted() {
    return "$major.$minor.$patch.$buildNumber";
  }
}
