// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';

class SelectAccountParameter {
  final OperationType operationType;
  final Set<Account> accounts;
  final String? transactionConfirmationData;

  SelectAccountParameter({
    required this.operationType,
    required this.accounts,
    this.transactionConfirmationData,
  });
}
