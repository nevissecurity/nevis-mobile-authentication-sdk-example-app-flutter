// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/client_provider/client_provider.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

abstract class DeregisterUseCase {
  Future<void> execute({
    required String username,
    required AuthorizationProvider authorizationProvider,
  });
}

@Injectable(as: DeregisterUseCase)
class DeregisterUseCaseImpl implements DeregisterUseCase {
  final ClientProvider _clientProvider;
  final DomainBloc _domainBloc;
  final StateRepository<OperationType> _operationTypeRepository;

  DeregisterUseCaseImpl(
    this._clientProvider,
    this._domainBloc,
    this._operationTypeRepository,
  );

  @override
  Future<void> execute({
    required String username,
    required AuthorizationProvider authorizationProvider,
  }) async {
    _operationTypeRepository.save(OperationType.deregistration);

    return await _clientProvider.client.operations.deregistration
        .username(username)
        .authorizationProvider(authorizationProvider)
        .onSuccess(() {
      debugPrint('Deregistration using authorization provider succeeded.');
      _domainBloc.add(ResultEvent());
    }).onError((error) {
      debugPrint(
          'Deregistration using authorization provider failed: ${error.runtimeType}');
    }).execute();
  }
}
