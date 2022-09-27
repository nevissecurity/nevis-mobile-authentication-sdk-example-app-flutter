// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/client_provider/client_provider.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/error/error_handler.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/error/error_message_types.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

abstract class OobPayloadDecodeUseCase {
  Future<void> execute({
    required String json,
    required Function(OutOfBandPayload) onSuccess,
  });
}

@Injectable(as: OobPayloadDecodeUseCase)
class OobPayloadDecodeUseCaseImpl implements OobPayloadDecodeUseCase {
  final ClientProvider _clientProvider;
  final StateRepository<OperationType> _operationTypeRepository;
  final ErrorHandler _errorHandler;

  OobPayloadDecodeUseCaseImpl(
    this._clientProvider,
    this._operationTypeRepository,
    this._errorHandler,
  );

  @override
  Future<void> execute({
    required String json,
    required Function(OutOfBandPayload) onSuccess,
  }) async {
    String fixedJson = json;
    if (json.length % 4 > 0) {
      fixedJson += '=' * (4 - json.length % 4);
    }
    final decodedJson = utf8.decode(base64.decode(fixedJson));
    _operationTypeRepository.save(OperationType.payloadDecode);
    await _clientProvider.client.operations.outOfBandPayloadDecode //
        .json(decodedJson)
        .onSuccess((payload) {
      if (payload == null) {
        debugPrint('Out of band payload is null.');
        _errorHandler.handle(BusinessErrorType.invalidState);
        return;
      }

      debugPrint('Out of band payload decode succeeded.');
      onSuccess.call(payload);
    }).onError((error) {
      debugPrint('Out of band payload decode failed: ${error.runtimeType}.');
      _errorHandler.handle(error);
    }).execute();
  }
}
