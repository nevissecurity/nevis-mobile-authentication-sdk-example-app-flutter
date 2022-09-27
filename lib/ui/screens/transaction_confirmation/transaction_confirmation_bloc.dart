// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/error/error_handler.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/cancel_user_interaction_operation_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/select_account_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/navigation/global_navigation_manager.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_authenticator/navigation/select_authenticator_parameter.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/transaction_confirmation/navigation/transaction_confirmation_parameter.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/transaction_confirmation/transaction_confirmation_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/transaction_confirmation/transaction_confirmation_state.dart';

@injectable
class TransactionConfirmationBloc extends Bloc<TransactionConfirmationEvent, TransactionConfirmationState> {
  final ErrorHandler _errorHandler;
  final SelectAccountUseCase _selectAccountUseCase;
  final CancelUserInteractionOperationUseCase _cancelUserInteractionOperationUseCase;
  final GlobalNavigationManager _globalNavigationManager;
  late TransactionConfirmationParameter _parameter;

  TransactionConfirmationBloc(
    this._errorHandler,
    this._selectAccountUseCase,
    this._cancelUserInteractionOperationUseCase,
    this._globalNavigationManager,
  ) : super(TransactionConfirmationInitialState("")) {
    on<TransactionConfirmationScreenCreatedEvent>(_handleScreenCreated);
    on<TransactionConfirmationUserAcceptedEvent>(_handleUserAccepted);
    on<TransactionConfirmationUserCancelledEvent>(_handleUserCancelled);
  }

  void _handleScreenCreated(
    TransactionConfirmationScreenCreatedEvent event,
    Emitter<TransactionConfirmationState> emit,
  ) {
    _parameter = event.parameter;
    emit(TransactionConfirmationInitialState(event.parameter.transactionData));
  }

  Future<void> _handleUserAccepted(
    TransactionConfirmationUserAcceptedEvent event,
    Emitter<TransactionConfirmationState> emit,
  ) async {
    final account = _parameter.selectedAccount;
    if (account != null) {
      _selectAccountUseCase.execute(account.username).catchError((error) {
        _errorHandler.handle(error);
      });
    } else {
      _globalNavigationManager.pushSelectAuthenticator(SelectAuthenticatorParameter(
        authenticators: _parameter.authenticators!,
        operationType: OperationType.authentication,
      ));
    }
  }

  Future<void> _handleUserCancelled(
    TransactionConfirmationUserCancelledEvent event,
    Emitter<TransactionConfirmationState> emit,
  ) async {
    await _cancelUserInteractionOperationUseCase.execute().catchError((error) {
      _errorHandler.handle(error);
    });
  }
}
