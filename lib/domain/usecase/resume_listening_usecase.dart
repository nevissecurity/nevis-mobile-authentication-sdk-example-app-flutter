// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/user_interaction_operation_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

abstract class ResumeListeningUseCase {
  Future<void> execute();
}

@Injectable(as: ResumeListeningUseCase)
class ResumeListeningUseCaseImpl extends ResumeListeningUseCase {
  final StateRepository<UserInteractionOperationState>
      _userInteractionOperationStateRepository;

  ResumeListeningUseCaseImpl(this._userInteractionOperationStateRepository);

  @override
  Future<void> execute() async {
    final osAuthenticationListenHandler =
        _userInteractionOperationStateRepository
            .state?.osAuthenticationListenHandler;
    await osAuthenticationListenHandler?.resumeListening();
    debugPrint("Listening resumed.");
  }
}
