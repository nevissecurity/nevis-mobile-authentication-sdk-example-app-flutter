// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/user_interaction_operation_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

abstract class CancelUserInteractionOperationUseCase {
  Future<void> execute();
}

@Injectable(as: CancelUserInteractionOperationUseCase)
class CancelUserInteractionOperationUseCaseImpl
    extends CancelUserInteractionOperationUseCase {
  final StateRepository<UserInteractionOperationState>
      _userInteractionOperationStateRepository;

  CancelUserInteractionOperationUseCaseImpl(
    this._userInteractionOperationStateRepository,
  );

  @override
  Future<void> execute() async {
    final state = _userInteractionOperationStateRepository.state;
    if (state == null) {
      return;
    }

    await state.accountSelectionHandler?.cancel();
    await state.authenticatorSelectionHandler?.cancel();
    await state.userVerificationHandler?.cancel();
    await state.osAuthenticationListenHandler?.cancelAuthentication();

    _userInteractionOperationStateRepository.save(state.copyWith(
      accountSelectionHandler: null,
      authenticatorSelectionHandler: null,
      userVerificationHandler: null,
      osAuthenticationListenHandler: null,
    ));
  }
}
