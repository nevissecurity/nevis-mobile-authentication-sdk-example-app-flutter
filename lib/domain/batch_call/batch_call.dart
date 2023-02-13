// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/error/error_handler.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';

typedef SdkCall = Future<dynamic> Function();

abstract class BatchCall {
  Future<void> call({
    required int batchLength,
    required List<SdkCall> batchCalls,
    required OperationType operationType,
  });

  Future<void> onOperationFinished({MobileAuthenticationClientError? error});
}

@Injectable(as: BatchCall)
class BatchCallImpl implements BatchCall {
  final DomainBloc _domainBloc;
  final ErrorHandler _errorHandler;
  int _batchLength = 0;
  int _finishedOperations = 0;
  List<SdkCall> _batchCalls = [];

  BatchCallImpl(this._domainBloc, this._errorHandler);

  @override
  Future<void> call({
    required int batchLength,
    required List<SdkCall> batchCalls,
    required OperationType operationType,
  }) async {
    _batchLength = batchLength;
    _batchCalls = batchCalls;
    await _batchCalls[_finishedOperations].call();
  }

  @override
  Future<void> onOperationFinished({
    MobileAuthenticationClientError? error,
  }) async {
    _finishedOperations++;
    final isSuccess = error == null;
    if (_finishedOperations == _batchLength && isSuccess) {
      _domainBloc.add(ResultEvent());
    } else if (_finishedOperations == _batchLength && !isSuccess) {
      _errorHandler.handle(error);
    } else {
      await _batchCalls[_finishedOperations].call();
    }
  }
}
