// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/client_provider/client_provider.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/error/error_message_types.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

abstract class OobPayloadDecodeUseCase {
  Future<OutOfBandPayload> execute({required String json});
}

@Injectable(as: OobPayloadDecodeUseCase)
class OobPayloadDecodeUseCaseImpl implements OobPayloadDecodeUseCase {
  final ClientProvider _clientProvider;
  final StateRepository<OperationType> _operationTypeRepository;

  OobPayloadDecodeUseCaseImpl(
    this._clientProvider,
    this._operationTypeRepository,
  );

  @override
  Future<OutOfBandPayload> execute({required String json}) async {
    String fixedJson = json;
    if (json.length % 4 > 0) {
      fixedJson += '=' * (4 - json.length % 4);
    }
    final decodedJson = utf8.decode(base64.decode(fixedJson));
    _operationTypeRepository.save(OperationType.payloadDecode);

    final Completer<OutOfBandPayload> completer = Completer();
    await _clientProvider.client.operations.outOfBandPayloadDecode
        .json(decodedJson)
        .onSuccess((payload) {
          if (payload == null) {
            debugPrint('Out of band payload is null.');
            return completer.completeError(BusinessErrorType.invalidState);
          }

          debugPrint('Out of band payload decode succeeded.');
          if (!completer.isCompleted) {
            completer.complete(payload);
          }
        })
        .onError((error) {
          debugPrint(
            'Out of band payload decode failed: ${error.runtimeType}.',
          );
          completer.completeError(error);
        })
        .execute();

    return completer.future;
  }
}
