// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/error/error_handler.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/authenticate_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/change_pin_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/select_account_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/navigation/global_navigation_manager.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/pin/navigation/pin_parameter.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_account/navigation/select_account_parameter.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_account/select_account_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_account/select_account_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/transaction_confirmation/navigation/transaction_confirmation_parameter.dart';

@injectable
class SelectAccountBloc extends Bloc<SelectAccountEvent, SelectAccountState> {
  late SelectAccountParameter _parameter;
  final AuthenticateUseCase _authenticateUseCase;
  final SelectAccountUseCase _selectAccountUseCase;
  final ChangePinUseCase _changePinUseCase;
  final ErrorHandler _errorHandler;
  final GlobalNavigationManager _globalNavigationManager;

  SelectAccountBloc(
    this._authenticateUseCase,
    this._selectAccountUseCase,
    this._changePinUseCase,
    this._errorHandler,
    this._globalNavigationManager,
  ) : super(SelectAccountInitialState(accounts: const {})) {
    on<SelectAccountCreatedEvent>(_handleAccountScreenCreated);
    on<AccountSelectedEvent>(_handleAccountSelected);
  }

  void _handleAccountScreenCreated(
    SelectAccountCreatedEvent event,
    Emitter<SelectAccountState> emit,
  ) {
    _parameter = event.parameter;
    emit(
      SelectAccountInitialState(
        accounts: _parameter.accounts,
      ),
    );
  }

  void _handleAccountSelected(
    AccountSelectedEvent event,
    Emitter<SelectAccountState> emit,
  ) async {
    // first check the existence of transaction confirmation data that can be received during an OOB auth
    if (_parameter.transactionConfirmationData != null) {
      _globalNavigationManager.pushTransactionData(
        TransactionConfirmationParameter(
          transactionData: _parameter.transactionConfirmationData!,
          selectedAccount: event.account,
        ),
      );
    } else if (_parameter.operationType == OperationType.authentication ||
        _parameter.operationType == OperationType.deregistration) {
      // in-band authentication or deregistration (in Identity Suite env) is in progress
      // (arriving from the Home screen)
      await _authenticateUseCase
          .execute(
        username: event.account.username,
        sessionProvider: null,
        operationType: _parameter.operationType,
      )
          .catchError((error) {
        _errorHandler.handle(error);
      });
    } else if (_parameter.operationType == OperationType.pinChange) {
      final parameter = PinParameter.credentialChange(
        username: event.account.username,
      );
      _changePinUseCase.execute(username: event.account.username);
      _globalNavigationManager.pushPin(parameter);
    } else {
      // simple account selection (e.g. during usernameless oob auth)
      await _selectAccountUseCase
          .execute(event.account.username)
          .catchError((error) {
        _errorHandler.handle(error);
      });
    }
  }
}
