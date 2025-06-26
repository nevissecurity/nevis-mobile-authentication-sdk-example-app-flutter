// Copyright © 2025 Nevis Security AG. All rights reserved.

import 'dart:io' show Platform;

import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/meta_data/sdk_meta_data.dart';

abstract class MetaDataUseCase {
  Future<SdkMetaData?> execute();
}

@Injectable(as: MetaDataUseCase)
class MetaDataUseCaseImpl implements MetaDataUseCase {
  @override
  Future<SdkMetaData?> execute() async {
    SdkMetaData? sdkMetaData;
    if (Platform.isIOS) {
      final iosMetaData = await MetaData.iosMetaData;
      sdkMetaData = SdkMetaData(
        sdkVersion: iosMetaData?.mobileAuthenticationVersion,
        facetId: iosMetaData?.applicationFacetId,
      );
    } else if (Platform.isAndroid) {
      final androidMetaData = await MetaData.androidMetaData;
      sdkMetaData = SdkMetaData(
        sdkVersion: androidMetaData?.mobileAuthenticationVersion,
        facetId: androidMetaData?.applicationFacetId,
        certificateFingerprint: androidMetaData?.signingCertificateSha256,
      );
    }

    return sdkMetaData;
  }
}
