// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/local_data/local_data_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/local_data/local_data_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/client_provider/client_provider.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/error/error_handler.dart';

@singleton
class LocalDataBloc extends Bloc<LocalDataEvent, LocalDataState> {
  final ClientProvider _clientProvider;
  final ErrorHandler _errorHandler;

  Set<Account> _registeredAccounts = {};
  DeviceInformation? _deviceInformation;
  Set<Authenticator> _authenticators = {};

  LocalDataBloc(
    this._clientProvider,
    this._errorHandler,
  ) : super(LocalDataInitial()) {
    on<LoadAccountsEvent>(_handleLoadAccounts);
  }

  Future<void> _handleLoadAccounts(
    LoadAccountsEvent event,
    Emitter<LocalDataState> emit,
  ) async {
    _registeredAccounts =
        await _clientProvider.client.localData.accounts.catchError((error) {
      _errorHandler.handle(error);
      return Set<Account>.identity();
    });

    _deviceInformation = await _clientProvider
        .client.localData.deviceInformation
        .catchError((error) {
      _errorHandler.handle(error);
      return null;
    });

    _authenticators = await _clientProvider.client.localData.authenticators
        .catchError((error) {
      _errorHandler.handle(error);
      return Set<Authenticator>.identity();
    });

    emit(
      LocalDataLoaded(
        accounts: _registeredAccounts,
        deviceInformation: _deviceInformation,
        authenticators: _authenticators,
      ),
    );
  }
}
