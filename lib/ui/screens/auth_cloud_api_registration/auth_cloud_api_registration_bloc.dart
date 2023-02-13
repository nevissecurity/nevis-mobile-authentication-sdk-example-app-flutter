// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/error/error_handler.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/auth_cloud_api_register_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/navigation/global_navigation_manager.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/auth_cloud_api_registration/auth_cloud_api_registration_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/auth_cloud_api_registration/auth_cloud_api_registration_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/util/string_utils.dart';

@injectable
class AuthCloudApiRegistrationBloc
    extends Bloc<AuthCloudApiRegistrationEvent, AuthCloudApiRegistrationState> {
  final GlobalNavigationManager _globalNavigationManager;
  final AuthCloudApiRegisterUseCase _authCloudApiRegisterUseCase;
  final ErrorHandler _errorHandler;

  AuthCloudApiRegistrationBloc(
    this._globalNavigationManager,
    this._authCloudApiRegisterUseCase,
    this._errorHandler,
  ) : super(AuthCloudApiRegistrationInitialState()) {
    on<RegistrationConfirmedEvent>(_handleConfirm);
    on<RegistrationCancelledEvent>(_handleCancel);
  }

  void _handleConfirm(
    RegistrationConfirmedEvent event,
    Emitter<AuthCloudApiRegistrationState> emit,
  ) async {
    String? enrollResponse =
        event.enrollResponse.isNullOrEmpty ? null : event.enrollResponse;
    String? appLinkUri =
        event.appLinkUri.isNullOrEmpty ? null : event.appLinkUri;
    await _authCloudApiRegisterUseCase
        .execute(
      enrollResponse: enrollResponse,
      appLinkUri: appLinkUri,
    )
        .catchError((e) {
      _errorHandler.handle(e);
    });
  }

  void _handleCancel(
    RegistrationCancelledEvent event,
    Emitter<AuthCloudApiRegistrationState> emit,
  ) {
    _globalNavigationManager.popUntilHome();
  }
}
