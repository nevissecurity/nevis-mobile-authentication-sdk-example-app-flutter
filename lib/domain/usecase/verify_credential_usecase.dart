// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/credential/credential_kind.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/error/error.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/user_interaction_operation_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

abstract class VerifyCredentialUseCase {
  Future<void> execute(
    CredentialKind kind,
    String credential,
  );
}

@Injectable(as: VerifyCredentialUseCase)
class VerifyCredentialUseCaseImpl extends VerifyCredentialUseCase {
  final StateRepository<UserInteractionOperationState>
      _userInteractionOperationStateRepository;

  VerifyCredentialUseCaseImpl(
    this._userInteractionOperationStateRepository,
  );

  @override
  Future<void> execute(
    CredentialKind kind,
    String credential,
  ) async {
    final handler =
        _userInteractionOperationStateRepository.state?.userVerificationHandler;
    if (handler == null) throw BusinessException.invalidState();

    switch (kind) {
      case CredentialKind.pin:
        if (handler is! PinUserVerificationHandler) {
          throw BusinessException.invalidState();
        }

        await handler.verifyPin(credential);
      case CredentialKind.password:
        if (handler is! PasswordUserVerificationHandler) {
          throw BusinessException.invalidState();
        }

        await handler.verifyPassword(credential);
    }
  }
}
