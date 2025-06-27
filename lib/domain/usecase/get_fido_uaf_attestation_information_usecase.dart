// Copyright © 2025 Nevis Security AG. All rights reserved.

import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/client_provider/client_provider.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/attestation/sdk_attestation_information.dart';

abstract class GetFidoUafAttestationInformationUseCase {
  Future<SdkAttestationInformation?> execute();
}

@Injectable(as: GetFidoUafAttestationInformationUseCase)
class GetFidoUafAttestationInformationUseCaseImpl
    implements GetFidoUafAttestationInformationUseCase {
  final ClientProvider _clientProvider;

  GetFidoUafAttestationInformationUseCaseImpl(this._clientProvider);

  @override
  Future<SdkAttestationInformation?> execute() async {
    if (!Platform.isAndroid) {
      debugPrint('Getting FIDO UAF attestation information is not supported.');
      return null;
    }

    final Completer<SdkAttestationInformation?> completer = Completer();
    await _clientProvider.client.deviceCapabilities.androidDeviceCapabilities
        .fidoUafAttestationInformationGetter
        .onSuccess((FidoUafAttestationInformation? information) {
      debugPrint('Getting FIDO UAF attestation information succeeded.');
      SdkAttestationInformation? sdkAttestationInformation;
      if (information == null) {
        debugPrint('No attestation information received.');
        return completer.complete(sdkAttestationInformation);
      }

      if (information is OnlySurrogateBasicSupported) {
        debugPrint('Only surrogate basic supported.');
        if (information.cause != null) {
          debugPrint('Cause: ${information.cause}');
        }
        sdkAttestationInformation =
            SdkAttestationInformation.onlySurrogateBasic();
      } else if (information is OnlyDefaultMode) {
        debugPrint('Full basic default mode supported.');
        if (information.cause != null) {
          debugPrint('Cause: ${information.cause}');
        }
        sdkAttestationInformation = SdkAttestationInformation.onlyDefault();
      } else if (information is StrictMode) {
        debugPrint('Full basic strict mode supported.');
        sdkAttestationInformation = SdkAttestationInformation.strict();
      } else {
        debugPrint(
            'Unknown FIDO UAF attestation information type: ${information.runtimeType}');
      }
      if (!completer.isCompleted) {
        completer.complete(sdkAttestationInformation);
      }
    }).onError((error) {
      debugPrint(
          'Getting FIDO UAF attestation information failed. Error: ${error.runtimeType}');
      return completer.complete(null);
    }).execute();

    return completer.future;
  }
}
