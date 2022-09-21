// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/app_state/operation_result_type.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/result/navigation/result_parameter.dart';

abstract class ResultEvent {}

class ResultCreatedEvent extends ResultEvent {
  final ResultParameter parameter;

  ResultCreatedEvent(this.parameter);
}

class NavigateToHomeEvent extends ResultEvent {
  final OperationResultType resultType;
  final OperationType operationType;

  NavigateToHomeEvent({
    required this.resultType,
    required this.operationType,
  });
}
