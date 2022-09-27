// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/error/error.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/user_interaction_operation_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/navigation/global_navigation_manager.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/result/navigation/result_parameter.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/result/navigation/result_route.dart';

abstract class ErrorHandler {
  // Flutter might send back Error as well as Exception
  void handle(dynamic exception);
}

@Injectable(as: ErrorHandler)
class ErrorHandlerImpl extends ErrorHandler {
  // Here we cannot use AppBlock for navigation because AppBlock also injects an instance of ErrorHandler, that would lead to circular dependency.
  final GlobalNavigationManager _globalNavigationManager;
  final StateRepository<UserInteractionOperationState> _userInteractionOperationStateRepository;

  ErrorHandlerImpl(
    this._globalNavigationManager,
    this._userInteractionOperationStateRepository,
  );

  @override
  void handle(dynamic exception) {
    if (exception is MobileAuthenticationClientError) {
      _navigateToResultWith(_processMobileAuthenticationClientError(exception));
    } else if (exception is PlatformSdkException) {
      _navigateToResultWith(_processPlatformSdkException(exception));
    } else if (exception is BusinessException) {
      _navigateToResultWith(ResultParameter.failure(errorType: exception.type));
    } else {
      _navigateToResultWith(ResultParameter.failure(
        description: exception.toString(),
      ));
    }
  }

  void _navigateToResultWith(ResultParameter parameter) {
    final context = _globalNavigationManager.navigatorContext;
    _userInteractionOperationStateRepository.reset();
    if (context != null) {
      Navigator.pushNamed(context, ResultRoute.result, arguments: parameter);
    } else {
      debugPrint('Failed to navigate to result screen.');
    }
  }

  ResultParameter _processPlatformSdkException(PlatformSdkException exception) {
    MobileAuthenticationClientError error = exception.error;
    String errorDescription = error.description;
    if (exception is InitializationError) {
      return ResultParameter.failure(description: errorDescription);
    }
    if (error is OperationFidoError) {
      errorDescription = error.errorCode.description;
    }
    return ResultParameter.failure(description: errorDescription);
  }

  ResultParameter _processMobileAuthenticationClientError(MobileAuthenticationClientError error) {
    if (error is InitializationError) {
      return ResultParameter.failure(description: error.description);
    } else if (error is OperationFidoError) {
      return ResultParameter.failure(description: error.errorCode.description);
    }
    return ResultParameter.failure(description: error.description);
  }
}
