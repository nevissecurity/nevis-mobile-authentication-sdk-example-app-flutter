// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/error/error_message_types.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/app_state/operation_result_type.dart';

@immutable
abstract class ResultState {}

class ResultInitialState extends ResultState {}

class ResultLoadedState extends ResultState {
  final OperationType operationType;
  final OperationResultType type;
  final BusinessErrorType? errorType;
  final String? description;

  ResultLoadedState({
    required this.operationType,
    required this.type,
    this.errorType,
    this.description,
  });
}
