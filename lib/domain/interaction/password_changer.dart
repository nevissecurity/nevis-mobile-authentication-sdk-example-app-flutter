// Copyright © 2024 Nevis Security AG. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/password_change_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

@Injectable(as: PasswordChanger)
class PasswordChangerImpl extends PasswordChanger {
  final DomainBloc _domainBloc;
  final StateRepository<PasswordChangeState> _stateRepository;
  final PasswordPolicy _passwordPolicy;

  PasswordChangerImpl(
    this._domainBloc,
    this._stateRepository,
    this._passwordPolicy,
  );

  @override
  void changePassword(
      PasswordChangeContext context, PasswordChangeHandler handler) {
    debugPrint(context.lastRecoverableError != null
        ? 'Password change failed. Please try again. Error: ${context.lastRecoverableError?.description}'
        : 'Please start password change.');

    _stateRepository.save(PasswordChangeState(context, handler));
    final event = CredentialChangeEvent(
      aaid: Aaid.password.rawValue,
      passwordProtectionStatus: context.authenticatorProtectionStatus,
      lastRecoverableError: context.lastRecoverableError,
    );
    _domainBloc.add(event);
  }

//  You can add custom password policy by overriding the `passwordPolicy` getter
  @override
  PasswordPolicy get passwordPolicy => _passwordPolicy;
}
