// Copyright © 2025 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';

class SdkMetaData {
  final Version? sdkVersion;
  final String? facetId;
  final String? certificateFingerprint;

  SdkMetaData({
    this.sdkVersion,
    this.facetId,
    this.certificateFingerprint,
  });
}
