// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/transaction_confirmation/transaction_confirmation_screen.dart';

class TransactionConfirmationRoute {
  static const transactionConfirmation = "transaction_data";

  Map<String, WidgetBuilder> get routes => {
        transactionConfirmation: (context) =>
            const TransactionConfirmationScreen(),
      };
}
