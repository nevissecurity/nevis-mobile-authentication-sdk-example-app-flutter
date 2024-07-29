// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/error/error_handler.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/error/error.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/select_authenticator_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/navigation/global_navigation_manager.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/credential/navigation/credential_parameter.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_authenticator/navigation/select_authenticator_parameter.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_authenticator/select_authenticator_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_authenticator/select_authenticator_state.dart';

@injectable
class SelectAuthenticatorBloc
    extends Bloc<SelectAuthenticatorEvent, SelectAuthenticatorState> {
  final SelectAuthenticatorUseCase _selectAuthenticatorUseCase;
  final GlobalNavigationManager _globalNavigationManager;
  final ErrorHandler _errorHandler;
  late SelectAuthenticatorParameter _parameter;

  SelectAuthenticatorBloc(
    this._selectAuthenticatorUseCase,
    this._globalNavigationManager,
    this._errorHandler,
  ) : super(SelectAuthenticatorInitialState()) {
    on<SelectAuthenticatorCreatedEvent>(_handleSelectAuthenticatorCreated);
    on<AuthenticatorSelectedEvent>(_handleAuthenticatorSelectedEvent);
  }

  Future<void> _handleAuthenticatorSelectedEvent(
    AuthenticatorSelectedEvent event,
    Emitter<SelectAuthenticatorState> emit,
  ) async {
    debugPrint('Selected authenticator aaid: ${event.aaid}');
    await _selectAuthenticatorUseCase.execute(event.aaid, (String username) {
      final CredentialParameter parameter;
      if (event.aaid.isPin) {
        parameter = CredentialParameter.pinEnrollment(
          username: username,
        );
      } else if (event.aaid.isPassword) {
        parameter = CredentialParameter.passwordEnrollment(
          username: username,
        );
      } else {
        throw BusinessException.invalidState();
      }

      _globalNavigationManager.pushCredential(parameter);
    }).catchError((error) {
      _errorHandler.handle(error);
    });
  }

  Future<void> _handleSelectAuthenticatorCreated(
    SelectAuthenticatorCreatedEvent event,
    Emitter<SelectAuthenticatorState> emit,
  ) async {
    _parameter = event.parameter;
    emit(SelectAuthenticatorLoadedState(_parameter));
  }
}
