// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/user_interaction_operation_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

abstract class ResetUserInteractionStateUseCase {
  void execute();
}

@Injectable(as: ResetUserInteractionStateUseCase)
class ResetUserInteractionStateUseCaseImpl extends ResetUserInteractionStateUseCase {
  final StateRepository<UserInteractionOperationState> _userInteractionOperationStateRepository;

  ResetUserInteractionStateUseCaseImpl(this._userInteractionOperationStateRepository);

  @override
  void execute() {
    _userInteractionOperationStateRepository.reset();
  }
}
