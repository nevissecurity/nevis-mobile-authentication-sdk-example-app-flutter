// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/error/error_handler.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/select_authenticator_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/navigation/global_navigation_manager.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/pin/navigation/pin_parameter.dart';
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
    debugPrint('Selected authenticator: ${event.authenticator.aaid}');
    await _selectAuthenticatorUseCase.execute(event.authenticator.aaid,
        (String username) {
      final parameter = PinParameter.enrollment(
        username: username,
      );

      _globalNavigationManager.pushPin(parameter);
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
