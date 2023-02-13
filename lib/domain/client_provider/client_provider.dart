// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/error/error_handler.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

abstract class ClientProvider {
  MobileAuthenticationClient get client;

  Future<void> init(
    Configuration configuration,
    Function onSuccess,
  );
}

@Injectable(as: ClientProvider)
class ClientProviderImpl implements ClientProvider {
  final StateRepository<OperationType> _operationTypeRepository;
  final ErrorHandler _errorHandler;

  ClientProviderImpl(
    this._operationTypeRepository,
    this._errorHandler,
  );

  @override
  MobileAuthenticationClient get client =>
      GetIt.I.get<MobileAuthenticationClient>();

  @override
  Future<void> init(
    Configuration configuration,
    Function onSuccess,
  ) async {
    _operationTypeRepository.save(OperationType.init);
    return await MobileAuthenticationClientInitializer.initializer() //
        .configuration(configuration)
        .onSuccess((client) {
      debugPrint('Client initialization succeeded.');
      GetIt.I.registerSingleton<MobileAuthenticationClient>(client);
      onSuccess.call();
      _operationTypeRepository.reset();
    }).onError((error) {
      debugPrint('Client initialization failed: ${error.runtimeType}.');
      _errorHandler.handle(error);
    }).execute();
  }
}
