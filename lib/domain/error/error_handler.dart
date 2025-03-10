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
  // Here we cannot use AppBlock for navigation because AppBlock also injects an
  // instance of ErrorHandler, that would lead to circular dependency.
  final GlobalNavigationManager _globalNavigationManager;
  final StateRepository<UserInteractionOperationState>
      _userInteractionOperationStateRepository;

  ErrorHandlerImpl(
    this._globalNavigationManager,
    this._userInteractionOperationStateRepository,
  );

  @override
  void handle(dynamic exception) {
    if (exception is MobileAuthenticationClientError) {
      _navigateToResultWith(
        _processMobileAuthenticationClientError(exception),
      );
    } else if (exception is PlatformSdkException) {
      _navigateToResultWith(
        _processMobileAuthenticationClientError(exception.error),
      );
    } else if (exception is BusinessException) {
      _navigateToResultWith(
        ResultParameter.failure(errorType: exception.type),
      );
    } else {
      _navigateToResultWith(
        ResultParameter.failure(description: exception.toString()),
      );
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

  ResultParameter _processMobileAuthenticationClientError(
    MobileAuthenticationClientError error,
  ) {
    // As this is an example app, we are directly showing the technical error occurring.
    // Be aware that this is not to be considered best practice. Your own production
    // app should handle the errors in a more appropriate manner  such as providing
    // translations for all your supported languages as well as simplifying the
    // error message presented to the end-user in a way non-technical adverse
    // people can understand and act upon them.
    String errorDescription = error.description;
    if (error is InitializationError) {
      return ResultParameter.fatal(description: errorDescription);
    }
    if (error is OperationFidoError) {
      errorDescription = error.errorCode.description;
    } else if (error is AuthCloudApiFidoError) {
      errorDescription = error.errorCode.description;
    } else if (error is AuthenticationFidoError) {
      errorDescription = error.errorCode.description;
    }
    return ResultParameter.failure(description: errorDescription);
  }
}
