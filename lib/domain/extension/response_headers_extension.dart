// Copyright © 2026 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';

extension Utility on ResponseHeaders {
  String asString() {
    return values.entries
        .map((e) => '${e.key}: ${e.value.join(',')}')
        .join(',');
  }
}
