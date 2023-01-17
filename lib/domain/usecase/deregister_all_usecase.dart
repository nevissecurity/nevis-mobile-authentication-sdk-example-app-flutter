// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/batch_call/batch_call.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/client_provider/client_provider.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

abstract class DeregisterAllUseCase {
  Future<void> execute({
    required Set<Account> accounts,
    required AuthorizationProvider? authorizationProvider,
  });
}

@Injectable(as: DeregisterAllUseCase)
class DeregisterAllUseCaseImpl implements DeregisterAllUseCase {
  final ClientProvider _clientProvider;
  final StateRepository<OperationType> _operationTypeRepository;

  DeregisterAllUseCaseImpl(
    this._clientProvider,
    this._operationTypeRepository,
  );

  @override
  Future<void> execute({
    required Set<Account> accounts,
    required AuthorizationProvider? authorizationProvider,
  }) async {
    final batchCall = GetIt.I.get<BatchCall>();
    final List<SdkCall> batchCalls = [];

    _operationTypeRepository.save(OperationType.deregistration);

    for (var account in accounts) {
      batchCalls.add(() async {
        var deregistration = _clientProvider.client.operations.deregistration //
            .username(account.username)
            .onSuccess(() {
          debugPrint('Deregistration succeeded.');
          batchCall.onOperationFinished();
        }).onError((error) {
          debugPrint('Deregistration failed: ${error.runtimeType}');
          batchCall.onOperationFinished(error: error);
        });

        if (authorizationProvider != null) {
          deregistration.authorizationProvider(authorizationProvider);
        }

        await deregistration.execute();
      });
    }
    return batchCall.call(
      batchLength: batchCalls.length,
      batchCalls: batchCalls,
      operationType: OperationType.deregistration,
    );
  }
}
