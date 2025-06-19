// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/home/model/sdk_attestation_information.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/home/model/sdk_meta_data.dart';

@immutable
abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadedState extends HomeState {
  final int registeredAccounts;
  final SdkMetaData? metaData;
  final SdkAttestationInformation? attestationInformation;

  HomeLoadedState(
    this.registeredAccounts,
    this.metaData,
    this.attestationInformation,
  );
}
