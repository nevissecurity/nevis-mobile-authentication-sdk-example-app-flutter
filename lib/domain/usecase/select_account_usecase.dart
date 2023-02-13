// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/error/error.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/user_interaction_operation_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

abstract class SelectAccountUseCase {
  Future<void> execute(String username);
}

@Injectable(as: SelectAccountUseCase)
class SelectAccountUseCaseImpl implements SelectAccountUseCase {
  final StateRepository<UserInteractionOperationState>
      _userInteractionOperationStateRepository;

  SelectAccountUseCaseImpl(this._userInteractionOperationStateRepository);

  @override
  Future<void> execute(String username) async {
    final state = _userInteractionOperationStateRepository.state;
    if (state == null) {
      throw BusinessException.invalidState();
    }
    final handler = state.accountSelectionHandler;
    if (handler == null) {
      throw BusinessException.invalidState();
    }
    await handler.username(username);
    _userInteractionOperationStateRepository.save(state.copyWith(
      accountSelectionHandler: null,
      authenticatorSelectionHandler: null,
    ));
  }
}
