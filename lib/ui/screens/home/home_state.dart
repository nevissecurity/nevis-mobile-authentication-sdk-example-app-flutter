// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/cupertino.dart';

@immutable
abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadedState extends HomeState {
  final int registeredAccounts;
  final String? sdkVersion;
  final String? additionalInfo;

  HomeLoadedState.empty()
      : registeredAccounts = 0,
        sdkVersion = "",
        additionalInfo = "";

  HomeLoadedState(
    this.registeredAccounts,
    this.sdkVersion,
    this.additionalInfo,
  );
}
