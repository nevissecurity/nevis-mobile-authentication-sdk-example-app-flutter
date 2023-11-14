// Copyright © 2023 Nevis Security AG. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/batch_call/batch_call.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/client_provider/client_provider.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

abstract class DeleteAuthenticatorsUseCase {
  Future<void> execute({required Set<Account> accounts});
}

@Injectable(as: DeleteAuthenticatorsUseCase)
class DeleteAuthenticatorsUseCaseImpl implements DeleteAuthenticatorsUseCase {
  final ClientProvider _clientProvider;
  final StateRepository<OperationType> _operationTypeRepository;

  DeleteAuthenticatorsUseCaseImpl(
    this._clientProvider,
    this._operationTypeRepository,
  );

  @override
  Future<void> execute({
    required Set<Account> accounts,
  }) {
    final batchCall = GetIt.I.get<BatchCall>();
    final List<SdkCall> batchCalls = [];

    _operationTypeRepository.save(OperationType.localData);

    for (var account in accounts) {
      batchCalls.add(() async {
        await _clientProvider.client.localData
            .deleteAuthenticator(username: account.username);
        debugPrint(
            'Deleting authenticators for ${account.username} succeeded.');
        batchCall.onOperationFinished();
      });
    }

    return batchCall.call(
      batchLength: batchCalls.length,
      batchCalls: batchCalls,
      operationType: OperationType.localData,
    );
  }
}
