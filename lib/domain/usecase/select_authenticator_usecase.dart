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
    final context = state.authenticatorSelectionContext;
    if (context == null) {
      throw BusinessException.invalidState();
    }

    final isPinSelectedButNotEnrolled =
        aaid.isPin && !_isEnrolled(context, Aaid.pin.rawValue);
    final isPasswordSelectedButNotEnrolled =
        aaid.isPassword && !_isEnrolled(context, Aaid.password.rawValue);
    if (isPinSelectedButNotEnrolled || isPasswordSelectedButNotEnrolled) {
      onNotEnrolled.call(context.account.username);
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

  bool _isEnrolled(AuthenticatorSelectionContext context, String aaid) {
    var filteredAuthenticators = context.authenticators.where(
      (e) => e.aaid == aaid,
    );
    if (filteredAuthenticators.isNotEmpty) {
      return filteredAuthenticators.first.userEnrollment
          .isEnrolled(context.account.username);
    }

    return false;
  }
}
