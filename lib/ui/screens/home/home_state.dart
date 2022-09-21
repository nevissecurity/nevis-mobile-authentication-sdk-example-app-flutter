// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/cupertino.dart';

@immutable
abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadedState extends HomeState {
  final int registeredAccounts;

  HomeLoadedState.empty() : registeredAccounts = 0;

  HomeLoadedState(this.registeredAccounts);
}
