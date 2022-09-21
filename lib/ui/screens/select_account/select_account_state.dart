// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';

@immutable
abstract class SelectAccountState {}

class SelectAccountInitialState extends SelectAccountState {
  final Set<Account> accounts;

  SelectAccountInitialState({required this.accounts});
}
