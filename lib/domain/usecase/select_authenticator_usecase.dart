// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/error/error.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/user_interaction_operation_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

abstract class SelectAuthenticatorUseCase {
  Future<void> execute(String aaid, Function(String username) onNotEnrolled);
}

@Injectable(as: SelectAuthenticatorUseCase)
class SelectAuthenticatorUseCaseImpl implements SelectAuthenticatorUseCase {
  final StateRepository<UserInteractionOperationState>
      _userInteractionOperationStateRepository;

  SelectAuthenticatorUseCaseImpl(this._userInteractionOperationStateRepository);

  @override
  Future<void> execute(
    String aaid,
    Function(String username) onNotEnrolled,
  ) async {
    final state = _userInteractionOperationStateRepository.state;
    if (state == null) {
      throw BusinessException.invalidState();
    }
    final authenticatorSelectionContext = state.authenticatorSelectionContext;
    if (authenticatorSelectionContext == null) {
      throw BusinessException.invalidState();
    }

    if (aaid.isPin && !_isPinEnrolled(authenticatorSelectionContext)) {
      onNotEnrolled.call(authenticatorSelectionContext.account.username);
    }
    final authenticatorSelectionHandler = state.authenticatorSelectionHandler;
    if (authenticatorSelectionHandler == null) {
      throw BusinessException.invalidState();
    }
    await authenticatorSelectionHandler.aaid(aaid);
    _userInteractionOperationStateRepository.save(
      state.copyWith(
        authenticatorSelectionHandler: null,
        accountSelectionHandler: null,
      ),
    );
  }

  bool _isPinEnrolled(AuthenticatorSelectionContext context) {
    var filteredAuthenticators =
        context.authenticators.where((e) => e.aaid.isPin);
    if (filteredAuthenticators.isNotEmpty) {
      return filteredAuthenticators.first.userEnrollment
          .isEnrolled(context.account.username);
    }

    return false;
  }
}
