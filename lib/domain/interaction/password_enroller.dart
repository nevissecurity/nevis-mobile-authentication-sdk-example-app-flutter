// Copyright © 2024 Nevis Security AG. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/password_enrollment_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

@Injectable(as: PasswordEnroller)
class PasswordEnrollerImpl extends PasswordEnroller {
  final DomainBloc _domainBloc;
  final StateRepository<PasswordEnrollmentState> _stateRepository;
  final PasswordPolicy _passwordPolicy;

  PasswordEnrollerImpl(
    this._stateRepository,
    this._domainBloc,
    this._passwordPolicy,
  );

  @override
  void enrollPassword(
      PasswordEnrollmentContext context, PasswordEnrollmentHandler handler) {
    debugPrint(context.lastRecoverableError != null
        ? 'Password enrollment failed. Please try again. Error: ${context.lastRecoverableError?.description}'
        : 'Please start password enrollment.');

    _stateRepository.save(PasswordEnrollmentState(context, handler));
    final event = CredentialEnrollmentEvent(
      aaid: Aaid.password.rawValue,
      lastRecoverableError: context.lastRecoverableError,
    );
    _domainBloc.add(event);
  }

  @override
  void onValidCredentialsProvided() {
    debugPrint('Valid password credentials provided.');
  }

//  You can add custom password policy by overriding the `passwordPolicy` getter
  @override
  PasswordPolicy get passwordPolicy => _passwordPolicy;
}
