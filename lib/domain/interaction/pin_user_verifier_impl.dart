// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/error/error_handler.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/error/error.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/user_interaction_operation_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

@Injectable(as: PinUserVerifier)
class PinUserVerifierImpl implements PinUserVerifier {
  final DomainBloc _domainBloc;
  final ErrorHandler _errorHandler;
  final StateRepository<UserInteractionOperationState>
      _userInteractionOperationStateRepository;

  PinUserVerifierImpl(
    this._domainBloc,
    this._errorHandler,
    this._userInteractionOperationStateRepository,
  );

  @override
  void verifyPin(
    PinUserVerificationContext context,
    PinUserVerificationHandler handler,
  ) {
    final status = context.authenticatorProtectionStatus;
    if (status is PinProtectionStatusUnlocked) {
      debugPrint('Please start PIN user verification.');
    } else if (status is PinProtectionStatusLastAttemptFailed &&
        status.remainingRetries > 0) {
      debugPrint(
          'Last PIN user verification attempt failed. Please try again.');
    } else {
      debugPrint('Last PIN user verification attempt failed.');
    }

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
      aaid: Aaid.pin.rawValue,
      pinProtectionStatus: context.authenticatorProtectionStatus,
    );
    _domainBloc.add(event);
  }

  @override
  void onValidCredentialsProvided() {
    debugPrint('Valid PIN credentials provided.');
  }
}
