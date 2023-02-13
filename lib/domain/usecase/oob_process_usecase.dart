// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/client_provider/client_provider.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/error/error_handler.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/error/error.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/user_interaction_operation_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/create_device_information_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/oob_payload_decode_usecase.dart';

abstract class OobProcessUseCase {
  Future<void> execute(String? json);
}

@Injectable(as: OobProcessUseCase)
class OobProcessUseCaseImpl implements OobProcessUseCase {
  final ClientProvider _clientProvider;
  final CreateDeviceInformationUseCase _createDeviceInformationUseCase;
  final OobPayloadDecodeUseCase _oobPayloadDecodeUseCase;
  final AccountSelector _accountSelector;
  final AuthenticatorSelector _authenticatorSelector;
  final PinEnroller _pinEnroller;
  final BiometricUserVerifier _biometricUserVerifier;
  final PinUserVerifier _pinUserVerifier;
  final FingerprintUserVerifier _fingerprintUserVerifier;
  final DomainBloc _domainBloc;
  final StateRepository<UserInteractionOperationState>
      _userInteractionOperationStateRepository;
  final StateRepository<OperationType> _operationTypeRepository;
  final ErrorHandler _errorHandler;

  OobProcessUseCaseImpl(
    this._clientProvider,
    this._createDeviceInformationUseCase,
    this._oobPayloadDecodeUseCase,
    this._accountSelector,
    this._authenticatorSelector,
    this._pinEnroller,
    this._biometricUserVerifier,
    this._pinUserVerifier,
    this._fingerprintUserVerifier,
    this._domainBloc,
    this._userInteractionOperationStateRepository,
    this._operationTypeRepository,
    this._errorHandler,
  );

  @override
  Future<void> execute(String? json) async {
    if (json == null) {
      throw BusinessException.missingDispatchTokenResponse();
    }
    final deviceInformation = await _createDeviceInformationUseCase.execute();
    await _oobPayloadDecodeUseCase.execute(
      json: json,
      onSuccess: (payload) async {
        _operationTypeRepository.save(OperationType.registration);
        await handleOutOfBandPayload(
          outOfBandPayload: payload,
          deviceInformation: deviceInformation,
        ).catchError((error) {
          _errorHandler.handle(error);
        });
      },
    );
  }

  Future<void> handleOutOfBandPayload({
    required OutOfBandPayload outOfBandPayload,
    required DeviceInformation deviceInformation,
  }) async {
    await _clientProvider.client.operations.outOfBandOperation //
        .payload(outOfBandPayload)
        .onRegistration((registration) async {
      await handleRegistration(
        registration: registration,
        deviceInformation: deviceInformation,
      ).catchError((error) {
        _errorHandler.handle(error);
      });
    }).onAuthentication((authentication) async {
      await handleAuthentication(authentication: authentication)
          .catchError((error) {
        _errorHandler.handle(error);
      });
    }).onError((error) {
      debugPrint('Out of band operation failed: ${error.runtimeType}');
      _errorHandler.handle(error);
      _userInteractionOperationStateRepository.reset();
    }).execute();
  }

  Future<void> handleRegistration({
    required OutOfBandRegistration registration,
    required DeviceInformation deviceInformation,
  }) async {
    return await registration
        .deviceInformation(deviceInformation)
        .authenticatorSelector(_authenticatorSelector)
        .pinEnroller(_pinEnroller)
        .biometricUserVerifier(_biometricUserVerifier)
        .fingerprintUserVerifier(_fingerprintUserVerifier)
        .onSuccess(() {
      debugPrint('Out of band registration succeeded.');
      _operationTypeRepository.save(OperationType.registration);
      _domainBloc.add(ResultEvent());
      _userInteractionOperationStateRepository.reset();
    }).onError((error) {
      debugPrint('Out of band registration failed: ${error.runtimeType}');
      _operationTypeRepository.save(OperationType.registration);
      _errorHandler.handle(error);
      _userInteractionOperationStateRepository.reset();
    }).execute();
  }

  Future<void> handleAuthentication({
    required OutOfBandAuthentication authentication,
  }) async {
    return await authentication
        .accountSelector(_accountSelector)
        .authenticatorSelector(_authenticatorSelector)
        .pinUserVerifier(_pinUserVerifier)
        .fingerprintUserVerifier(_fingerprintUserVerifier)
        .biometricUserVerifier(_biometricUserVerifier)
        .onSuccess((authorizationProvider) {
      debugPrint('Out of band authentication succeeded.');
      _operationTypeRepository.save(OperationType.authentication);
      _domainBloc.add(ResultEvent());
      _userInteractionOperationStateRepository.reset();
    }).onError((error) {
      debugPrint('Out of band authentication failed: ${error.runtimeType}');
      _operationTypeRepository.save(OperationType.authentication);
      _errorHandler.handle(error);
      _userInteractionOperationStateRepository.reset();
    }).execute();
  }
}
