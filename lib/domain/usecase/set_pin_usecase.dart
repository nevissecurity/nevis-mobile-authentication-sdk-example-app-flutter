// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/error/error.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/pin_enrollment_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

abstract class SetPinUseCase {
  Future<void> execute(String firstCredentials);
}

@Injectable(as: SetPinUseCase)
class SetPinUseCaseImpl implements SetPinUseCase {
  final StateRepository<EnrollPinState> _pinEnrollmentStateRepository;

  SetPinUseCaseImpl(this._pinEnrollmentStateRepository);

  @override
  Future<void> execute(String firstCredentials) async {
    final currentState = _pinEnrollmentStateRepository.state;
    if (currentState is EnrollPinState) {
      await currentState.handler.pin(firstCredentials);
    } else {
      throw BusinessException.invalidState();
    }
  }
}
