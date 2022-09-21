// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_account/navigation/select_account_parameter.dart';

abstract class SelectAccountEvent {}

class SelectAccountCreatedEvent extends SelectAccountEvent {
  final SelectAccountParameter parameter;

  SelectAccountCreatedEvent(this.parameter);
}

class AccountSelectedEvent extends SelectAccountEvent {
  final Account account;

  AccountSelectedEvent(this.account);
}
