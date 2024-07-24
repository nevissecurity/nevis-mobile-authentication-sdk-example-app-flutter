// Copyright © 2024 Nevis Security AG. All rights reserved.

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

abstract class ChangePasswordUseCase {
  Future<void> execute({
    required String username,
  });
}

@Injectable(as: ChangePasswordUseCase)
class ChangePasswordUseCaseImpl implements ChangePasswordUseCase {
  final ClientProvider _clientProvider;
  final PasswordChanger _passwordChanger;
  final DomainBloc _domainBloc;
  final StateRepository<OperationType> _operationTypeRepository;
  final StateRepository<PinChangeState> _pinChangeStateRepository;
  final ErrorHandler _errorHandler;

  ChangePasswordUseCaseImpl(
    this._clientProvider,
    this._passwordChanger,
    this._domainBloc,
    this._operationTypeRepository,
    this._pinChangeStateRepository,
    this._errorHandler,
  );

  @override
  Future<void> execute({
    required String username,
  }) async {
    _operationTypeRepository.save(OperationType.passwordChange);
    await _clientProvider.client.operations.passwordChange //
        .username(username)
        .passwordChanger(_passwordChanger)
        .onSuccess(() {
      debugPrint('Password change succeeded.');
      _domainBloc.add(ResultEvent());
      _pinChangeStateRepository.reset();
    }).onError((error) {
      debugPrint('Password change failed: ${error.description}');
      _errorHandler.handle(error);
      _pinChangeStateRepository.reset();
    }).execute();
  }
}
