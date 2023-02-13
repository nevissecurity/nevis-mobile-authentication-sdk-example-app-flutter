// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/error/error.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/user_interaction_operation_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

abstract class BiometricListenForOsCredentialsUseCase {
  Future<void> execute(BiometricPromptOptions options);
}

@Injectable(as: BiometricListenForOsCredentialsUseCase)
class BiometricListenForOsCredentialsUseCaseImpl
    extends BiometricListenForOsCredentialsUseCase {
  final StateRepository<UserInteractionOperationState>
      _userInteractionOperationStateRepository;

  BiometricListenForOsCredentialsUseCaseImpl(
    this._userInteractionOperationStateRepository,
  );

  @override
  Future<void> execute(BiometricPromptOptions options) async {
    final state = _userInteractionOperationStateRepository.state;
    if (state == null) throw BusinessException.invalidState();
    final handler = state.userVerificationHandler;
    if (handler == null) throw BusinessException.invalidState();
    if (handler is! BiometricUserVerificationHandler) {
      throw BusinessException.invalidState();
    }
    _userInteractionOperationStateRepository.save(
      state.copyWith(
        accountSelectionHandler: null,
        authenticatorSelectionHandler: null,
        osAuthenticationListenHandler:
            await handler.listenForOsCredentials(options),
      ),
    );
  }
}
