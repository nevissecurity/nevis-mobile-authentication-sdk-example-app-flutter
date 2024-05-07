// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/error/error_message_types.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/app_state/operation_result_type.dart';

class ResultParameter {
  final OperationResultType type;
  final BusinessErrorType? errorType;
  final String? description;

  ResultParameter.success({
    this.errorType,
    this.description,
  }) : type = OperationResultType.success;

  ResultParameter.failure({
    this.errorType,
    this.description,
  }) : type = OperationResultType.failure;

  ResultParameter.fatal({
    this.errorType,
    this.description,
  }) : type = OperationResultType.fatal;
}
