// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'dart:async';
import 'dart:io';

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
      debugPrint('Client initialization failed: ${error.description}.');

      // The SDK removes all the data when a rooted device or tampering
      // is detected
      if (Platform.isAndroid && _isNonRootedDeviceTamperingError(error)) {
        // On Android the application must be closed when a generic device
        // protection error is received (i.e. it is a checksum, debugger,
        // emulator or instrumentation guard error)
        exit(-1);
      }

      _errorHandler.handle(error);
    }).execute();
  }

  bool _isNonRootedDeviceTamperingError(
    InitializationError initializationError,
  ) {
    // Return true if this is a tampering error different than rooted device
    // error occurred (i.e. this is a checksum, debugger, emulator or
    // instrumentation guard error).
    return initializationError is InitializationDeviceProtectionError &&
        initializationError is! InitializationRootedError &&
        initializationError is! InitializationHardwareError &&
        initializationError is! InitializationNoDeviceLockError &&
        initializationError is! InitializationLockScreenHasChangedError;
  }
}
