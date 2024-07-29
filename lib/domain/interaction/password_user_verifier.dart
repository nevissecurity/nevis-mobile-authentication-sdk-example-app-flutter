// Copyright © 2024 Nevis Security AG. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/error/error_handler.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/error/error.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/user_interaction_operation_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

@Injectable(as: PasswordUserVerifier)
class PasswordUserVerifierImpl implements PasswordUserVerifier {
  final DomainBloc _domainBloc;
  final ErrorHandler _errorHandler;
  final StateRepository<UserInteractionOperationState>
      _userInteractionOperationStateRepository;

  PasswordUserVerifierImpl(
    this._domainBloc,
    this._errorHandler,
    this._userInteractionOperationStateRepository,
  );

  @override
  void verifyPassword(
    PasswordUserVerificationContext context,
    PasswordUserVerificationHandler handler,
  ) {
    debugPrint(context.lastRecoverableError != null
        ? 'Password user verification failed. Please try again. Error: ${context.lastRecoverableError?.description}'
        : 'Please start password user verification.');

    final state = _userInteractionOperationStateRepository.state;
    if (state == null) {
      _errorHandler.handle(BusinessException.invalidState());
      return;
    }
    _userInteractionOperationStateRepository.save(
      state.copyWith(
        accountSelectionHandler: null,
        authenticatorSelectionHandler: null,
        userVerificationHandler: handler,
      ),
    );
    final event = CredentialUserVerificationEvent(
      aaid: Aaid.password.rawValue,
      passwordProtectionStatus: context.authenticatorProtectionStatus,
      lastRecoverableError: context.lastRecoverableError,
    );
    _domainBloc.add(event);
  }

  @override
  void onValidCredentialsProvided() {
    debugPrint('Valid password credentials provided.');
  }
}
