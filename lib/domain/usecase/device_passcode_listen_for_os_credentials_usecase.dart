// Copyright © 2023 Nevis Security AG. All rights reserved.

import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/error/error.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/user_interaction_operation_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

abstract class DevicePasscodeListenForOsCredentialsUseCase {
  Future<void> execute(DevicePasscodePromptOptions options);
}

@Injectable(as: DevicePasscodeListenForOsCredentialsUseCase)
class DevicePasscodeListenForOsCredentialsUseCaseImpl
    extends DevicePasscodeListenForOsCredentialsUseCase {
  final StateRepository<UserInteractionOperationState>
      _userInteractionOperationStateRepository;

  DevicePasscodeListenForOsCredentialsUseCaseImpl(
    this._userInteractionOperationStateRepository,
  );

  @override
  Future<void> execute(DevicePasscodePromptOptions options) async {
    final state = _userInteractionOperationStateRepository.state;
    if (state == null) throw BusinessException.invalidState();
    final handler = state.userVerificationHandler;
    if (handler == null) throw BusinessException.invalidState();
    if (handler is! DevicePasscodeUserVerificationHandler) {
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
