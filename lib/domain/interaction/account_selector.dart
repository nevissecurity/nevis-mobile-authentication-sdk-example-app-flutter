// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/error/error_handler.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/error/error.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/user_interaction_operation_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/validation/account_validator.dart';

@Injectable(as: AccountSelector)
class AccountSelectorImpl implements AccountSelector {
  final DomainBloc _domainBloc;
  final ErrorHandler _errorHandler;
  final StateRepository<UserInteractionOperationState>
      _userInteractionOperationStateRepository;
  final AccountValidator _accountValidator;

  AccountSelectorImpl(
    this._domainBloc,
    this._errorHandler,
    this._userInteractionOperationStateRepository,
    this._accountValidator,
  );

  @override
  void selectAccount(
    AccountSelectionContext context,
    AccountSelectionHandler handler,
  ) async {
    try {
      _userInteractionOperationStateRepository.save(
        UserInteractionOperationState(
          accountSelectionHandler: handler,
        ),
      );

      final validAccounts = await _validateAccounts(context);
      if (validAccounts.isNotEmpty) {
        _domainBloc.add(
          SelectAccountEvent(
            // `unknown` operation type is used, because it can be in-band or out-of-band
            operationType: OperationType.unknown,
            accounts: validAccounts,
            transactionConfirmationData: context.transactionConfirmationData,
          ),
        );
      }
    } catch (error) {
      _errorHandler.handle(error);
    }
  }

  Future<Set<Account>> _validateAccounts(
      AccountSelectionContext context) async {
    final validAccounts = await _accountValidator.validate(context);
    if (validAccounts.length > 1) {
      return Future.value(validAccounts);
    }

    final state = _userInteractionOperationStateRepository.state;
    if (state == null) {
      throw BusinessException.invalidState();
    }

    final handler = state.accountSelectionHandler;
    if (validAccounts.isEmpty) {
      // No username is compliant with the policy.
      // Provide a random username that will generate an error in the SDK.
      await handler?.username('');
    } else if (validAccounts.length == 1) {
      final account = validAccounts.first;
      if (context.transactionConfirmationData != null) {
        // Display transaction confirmation
        _domainBloc.add(
          TransactionConfirmationEvent(
            transactionData: context.transactionConfirmationData!,
            selectedAccount: account,
          ),
        );
        return Future.value({});
      } else {
        // Typical case: authentication with username provided, just use it.
        await handler?.username(account.username);
      }
    }

    _userInteractionOperationStateRepository.save(state.copyWith(
      accountSelectionHandler: null,
      authenticatorSelectionHandler: null,
    ));
    return Future.value({});
  }
}
