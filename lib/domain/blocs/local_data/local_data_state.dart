// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';

@immutable
abstract class LocalDataState {}

class LocalDataInitial extends LocalDataState {}

class LocalDataLoaded extends LocalDataState {
  final Set<Account> accounts;
  final DeviceInformation? deviceInformation;
  final Set<Authenticator> authenticators;

  LocalDataLoaded({
    required this.accounts,
    this.deviceInformation,
    required this.authenticators,
  });
}
