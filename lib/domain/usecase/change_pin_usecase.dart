// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/client_provider/client_provider.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/error/error_handler.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/pin_change_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

abstract class ChangePinUseCase {
  Future<void> execute({
    required String username,
  });
}

@Injectable(as: ChangePinUseCase)
class ChangePinUseCaseImpl implements ChangePinUseCase {
  final ClientProvider _clientProvider;
  final PinChanger _pinChanger;
  final DomainBloc _domainBloc;
  final StateRepository<OperationType> _operationTypeRepository;
  final StateRepository<PinChangeState> _pinChangeStateRepository;
  final ErrorHandler _errorHandler;

  ChangePinUseCaseImpl(
    this._clientProvider,
    this._pinChanger,
    this._domainBloc,
    this._operationTypeRepository,
    this._pinChangeStateRepository,
    this._errorHandler,
  );

  @override
  Future<void> execute({
    required String username,
  }) async {
    _operationTypeRepository.save(OperationType.pinChange);
    await _clientProvider.client.operations.pinChange //
        .username(username)
        .pinChanger(_pinChanger)
        .onSuccess(() {
      debugPrint('PIN change succeeded.');
      _domainBloc.add(ResultEvent());
      _pinChangeStateRepository.reset();
    }).onError((error) {
      debugPrint('PIN change failed: ${error.description}');
      _errorHandler.handle(error);
      _pinChangeStateRepository.reset();
    }).execute();
  }
}
