// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/user_interaction_operation_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

abstract class PauseListeningUseCase {
  Future<void> execute();
}

@Injectable(as: PauseListeningUseCase)
class PauseListeningUseCaseImpl extends PauseListeningUseCase {
  final StateRepository<UserInteractionOperationState>
      _userInteractionOperationStateRepository;

  PauseListeningUseCaseImpl(
    this._userInteractionOperationStateRepository,
  );

  @override
  Future<void> execute() async {
    final state = _userInteractionOperationStateRepository.state;
    if (state == null) {
      debugPrint(
          "User interaction state is missing, no need for resuming the listen handler.");
      return;
    }

    final osAuthenticationListenHandler = state.osAuthenticationListenHandler;
    if (osAuthenticationListenHandler == null) {
      debugPrint(
          "OS authentication listen handler does not exist, no need for pausing.");
      return;
    }

    final handler = await osAuthenticationListenHandler.pauseListening();
    _userInteractionOperationStateRepository.save(
      state.copyWith(
        accountSelectionHandler: null,
        authenticatorSelectionHandler: null,
        osAuthenticationListenHandler: handler,
      ),
    );

    debugPrint("Listening paused.");
  }
}
