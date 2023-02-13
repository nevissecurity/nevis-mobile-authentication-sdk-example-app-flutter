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
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/user_interaction_operation_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/create_device_information_usecase.dart';

abstract class AuthCloudApiRegisterUseCase {
  Future<void> execute({
    required String? enrollResponse,
    required String? appLinkUri,
  });
}

@Injectable(as: AuthCloudApiRegisterUseCase)
class AuthCloudApiRegisterUseCaseImpl implements AuthCloudApiRegisterUseCase {
  final ClientProvider _clientProvider;
  final CreateDeviceInformationUseCase _createDeviceInformationUseCase;
  final AuthenticatorSelector _authenticatorSelector;
  final PinEnroller _pinEnroller;
  final BiometricUserVerifier _biometricUserVerifier;
  final FingerprintUserVerifier _fingerprintUserVerifier;
  final DomainBloc _domainBloc;
  final StateRepository<UserInteractionOperationState>
      _userInteractionOperationStateRepository;
  final StateRepository<OperationType> _operationTypeRepository;
  final ErrorHandler _errorHandler;

  AuthCloudApiRegisterUseCaseImpl(
      this._clientProvider,
      this._createDeviceInformationUseCase,
      this._authenticatorSelector,
      this._pinEnroller,
      this._biometricUserVerifier,
      this._fingerprintUserVerifier,
      this._domainBloc,
      this._userInteractionOperationStateRepository,
      this._operationTypeRepository,
      this._errorHandler);

  @override
  Future<void> execute({
    required String? enrollResponse,
    required String? appLinkUri,
  }) async {
    final deviceInformation = await _createDeviceInformationUseCase.execute();
    _operationTypeRepository.save(OperationType.authCloudApiRegistration);
    var authCloudApiRegistration = _clientProvider
        .client.operations.authCloudApiRegistration
        .deviceInformation(deviceInformation)
        .authenticatorSelector(_authenticatorSelector)
        .pinEnroller(_pinEnroller)
        .biometricUserVerifier(_biometricUserVerifier)
        .fingerprintUserVerifier(_fingerprintUserVerifier)
        .onSuccess(() {
      debugPrint('Auth Cloud API registration succeeded.');
      _domainBloc.add(ResultEvent());
      _userInteractionOperationStateRepository.reset();
    }).onError((error) {
      debugPrint('Auth Cloud API registration failed: ${error.runtimeType}');
      _errorHandler.handle(error);
      _userInteractionOperationStateRepository.reset();
    });

    if (enrollResponse != null) {
      authCloudApiRegistration.enrollResponse(enrollResponse);
    }

    if (appLinkUri != null) {
      authCloudApiRegistration.appLinkUri(appLinkUri);
    }

    return await authCloudApiRegistration.execute();
  }
}
