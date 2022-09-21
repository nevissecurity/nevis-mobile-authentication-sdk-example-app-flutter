// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/batch_call/batch_call.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/client_provider/client_provider.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

abstract class DeregisterUseCase {
  Future<void> execute({
    required String username,
    required Set<Authenticator> authenticators,
    required AuthorizationProvider authorizationProvider,
  });
}

@Injectable(as: DeregisterUseCase)
class DeregisterUseCaseImpl implements DeregisterUseCase {
  final ClientProvider _clientProvider;
  final StateRepository<OperationType> _operationTypeRepository;

  DeregisterUseCaseImpl(
    this._clientProvider,
    this._operationTypeRepository,
  );

  @override
  Future<void> execute({
    required String username,
    required Set<Authenticator> authenticators,
    required AuthorizationProvider authorizationProvider,
  }) async {
    final batchCall = GetIt.I.get<BatchCall>();
    final List<SdkCall> batchCalls = [];

    _operationTypeRepository.save(OperationType.deregistration);

    for (var authenticator in authenticators) {
      batchCalls.add(() async {
        await _clientProvider.client.operations.deregistration
            .username(username)
            .aaid(authenticator.aaid)
            .authorizationProvider(authorizationProvider)
            .onSuccess(() {
          debugPrint('Deregistration succeeded.');
          batchCall.onOperationFinished();
        }).onError((error) {
          debugPrint('Deregistration failed: ${error.runtimeType}');
          batchCall.onOperationFinished(error: error);
        }).execute();
      });
    }

    return batchCall.call(
      batchLength: batchCalls.length,
      batchCalls: batchCalls,
      operationType: OperationType.deregistration,
    );
  }
}
