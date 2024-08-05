// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/client_provider/client_provider.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/error/error_handler.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

abstract class AuthenticateUseCase {
  Future<void> execute({
    required String username,
    required SessionProvider? sessionProvider,
    required OperationType operationType,
  });
}

@Injectable(as: AuthenticateUseCase)
class AuthenticateUseCaseImpl implements AuthenticateUseCase {
  final ClientProvider _clientProvider;
  final AuthenticatorSelector _authenticatorSelector;
  final PinUserVerifier _pinUserVerifier;
  final PasswordUserVerifier _passwordUserVerifier;
  final BiometricUserVerifier _biometricUserVerifier;
  final DevicePasscodeUserVerifier _devicePasscodeUserVerifier;
  final FingerprintUserVerifier _fingerprintUserVerifier;
  final DomainBloc _domainBloc;
  final StateRepository<OperationType> _operationTypeRepository;
  final ErrorHandler _errorHandler;

  AuthenticateUseCaseImpl(
    this._clientProvider,
    @Named("auth_selector_auth") this._authenticatorSelector,
    this._pinUserVerifier,
    this._passwordUserVerifier,
    this._biometricUserVerifier,
    this._devicePasscodeUserVerifier,
    this._fingerprintUserVerifier,
    this._domainBloc,
    this._operationTypeRepository,
    this._errorHandler,
  );

  @override
  Future<void> execute({
    required String username,
    required SessionProvider? sessionProvider,
    required OperationType operationType,
  }) async {
    _operationTypeRepository.save(operationType);
    var authentication = _clientProvider.client.operations.authentication
        .username(username)
        .authenticatorSelector(_authenticatorSelector)
        .pinUserVerifier(_pinUserVerifier)
        .passwordUserVerifier(_passwordUserVerifier)
        .biometricUserVerifier(_biometricUserVerifier)
        .devicePasscodeUserVerifier(_devicePasscodeUserVerifier)
        .fingerprintUserVerifier(_fingerprintUserVerifier)
        .onSuccess((AuthorizationProvider? authorizationProvider) {
      debugPrint('In-band authentication succeeded.');
      _printAuthorizationInfo(authorizationProvider);
      _domainBloc.add(AuthenticationSucceededEvent(
        operation: operationType,
        authorizationProvider: authorizationProvider,
      ));
    }).onError((error) {
      debugPrint('In-band authentication failed: ${error.runtimeType}');
      _printSessionInfo(error.sessionProvider);
      _errorHandler.handle(error);
    });

    if (sessionProvider != null) {
      authentication.sessionProvider(sessionProvider);
    }

    return await authentication.execute();
  }

  void _printAuthorizationInfo(AuthorizationProvider? authorizationProvider) {
    if (authorizationProvider is CookieAuthorizationProvider) {
      for (final container in authorizationProvider.cookieContainers) {
        debugPrint("Received cookie: ${container.cookie.toString()}");
      }
    } else if (authorizationProvider is JwtAuthorizationProvider) {
      debugPrint("Received JWT is ${authorizationProvider.jwt}");
    }
  }

  void _printSessionInfo(SessionProvider? sessionProvider) {
    if (sessionProvider is CookieSessionProvider) {
      for (final container in sessionProvider.cookieContainers) {
        debugPrint("Received cookie: ${container.cookie.toString()}");
      }
    } else if (sessionProvider is JwtSessionProvider) {
      debugPrint("Received JWT is ${sessionProvider.jwt}");
    }
  }
}
