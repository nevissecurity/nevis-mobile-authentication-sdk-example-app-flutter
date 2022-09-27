// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/error/error.dart';

abstract class AccountValidator {
  Future<Set<Account>> validate(AccountSelectionContext context);
}

@Injectable(as: AccountValidator)
class AccountValidatorImpl implements AccountValidator {
  @override
  Future<Set<Account>> validate(AccountSelectionContext context) async {
    final supportedAuthenticators = context.authenticators.where((i) => i.isSupportedByHardware).toList();
    if (supportedAuthenticators.isEmpty) {
      throw BusinessException.authenticatorNotFound();
    }

    Set<Account> accounts = {};
    for (var authenticator in supportedAuthenticators) {
      for (var account in authenticator.registration.registeredAccounts) {
        if (await context.isPolicyCompliant(authenticator.aaid, account.username)) {
          accounts.add(account);
        }
      }
    }

    return Future.value(accounts);
  }
}
