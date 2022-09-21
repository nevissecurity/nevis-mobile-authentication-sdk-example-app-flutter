// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/configuration/configuration_loader.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/error/error_handler.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/login/credentials.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/login/login_request.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/login_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/registration_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/legacy_login/legacy_login_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/legacy_login/legacy_login_state.dart';

@injectable
class LegacyLoginBloc extends Bloc<LegacyLoginEvent, LegacyLoginState> {
  final ConfigurationLoader _configurationLoader;
  final LoginUseCase _loginUseCase;
  final RegistrationUseCase _registrationUseCase;
  final ErrorHandler _errorHandler;

  LegacyLoginBloc(
    this._configurationLoader,
    this._loginUseCase,
    this._registrationUseCase,
    this._errorHandler,
  ) : super(LegacyLoginInitialState()) {
    on<ConfirmEvent>(_handleConfirmEvent);
  }

  Future<void> _handleConfirmEvent(ConfirmEvent event, Emitter<LegacyLoginState> emit) async {
    final configuration = await _configurationLoader.load();
    final uri = Uri.parse(configuration.loginConfiguration.loginRequestURL);
    final loginRequest = LoginRequest(username: event.username, password: event.password);
    final credentials = await _loginUseCase.execute(uri: uri, loginRequest: loginRequest).catchError((e) {
      _errorHandler.handle(e);
      return Credentials.empty();
    });

    await _registrationUseCase
        .execute(username: credentials.username, authorizationProvider: credentials.authorizationProvider)
        .catchError((e) {
      _errorHandler.handle(e);
    });
  }
}
