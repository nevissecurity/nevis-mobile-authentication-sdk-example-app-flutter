// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';

class TransactionConfirmationParameter {
  final String transactionData;
  final Account? selectedAccount;
  final Set<Authenticator>? authenticators;

  TransactionConfirmationParameter({
    required this.transactionData,
    this.selectedAccount,
    this.authenticators,
  });
}
