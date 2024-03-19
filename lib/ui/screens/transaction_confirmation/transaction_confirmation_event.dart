// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/transaction_confirmation/navigation/transaction_confirmation_parameter.dart';

abstract class TransactionConfirmationEvent {}

class TransactionConfirmationCreatedEvent extends TransactionConfirmationEvent {
  final TransactionConfirmationParameter parameter;

  TransactionConfirmationCreatedEvent(this.parameter);
}

class TransactionConfirmationUserAcceptedEvent
    extends TransactionConfirmationEvent {}

class TransactionConfirmationUserCancelledEvent
    extends TransactionConfirmationEvent {}
