// Copyright © 2026 Nevis Security AG. All rights reserved.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/client_provider/client_provider.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

abstract class PendingOutOfBandOperationsUseCase {
  Future<OutOfBandPayload?> execute();
}

@Injectable(as: PendingOutOfBandOperationsUseCase)
class PendingOutOfBandOperationsUseCaseImpl
    implements PendingOutOfBandOperationsUseCase {
  final ClientProvider _clientProvider;
  final StateRepository<OperationType> _operationTypeRepository;

  PendingOutOfBandOperationsUseCaseImpl(
    this._clientProvider,
    this._operationTypeRepository,
  );

  @override
  Future<OutOfBandPayload?> execute() async {
    _operationTypeRepository.save(OperationType.pendingOutOfBandOperations);

    final Completer<OutOfBandPayload?> completer = Completer();
    await _clientProvider.client.operations.pendingOutOfBandOperations.onResult((
      result,
    ) {
      for (final error in result.errors) {
        debugPrint(
          'Pending out-of-band operations error: ${error.description}',
        );
      }

      // The operations are sorted by creation time, the last one is the latest.
      final pendingOperation = result.operations.isNotEmpty
          ? result.operations.last
          : null;
      if (!completer.isCompleted) {
        completer.complete(pendingOperation?.payload);
      }
    }).execute();

    return completer.future;
  }
}
