// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';

@immutable
abstract class TransactionConfirmationState {}

class TransactionConfirmationInitialState extends TransactionConfirmationState {
  final String transactionData;

  TransactionConfirmationInitialState(this.transactionData);
}
