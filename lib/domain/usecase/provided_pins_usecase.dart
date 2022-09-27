// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/error/error_handler.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/error/error.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/pin_change_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

abstract class ProvidedPinsUseCase {
  Future<void> execute({
    required String oldPin,
    required String newPin,
  });
}

@Injectable(as: ProvidedPinsUseCase)
class ProvidedPinsUseCaseImpl implements ProvidedPinsUseCase {
  final StateRepository<PinChangeState> _stateRepository;
  final ErrorHandler _errorHandler;

  ProvidedPinsUseCaseImpl(
    this._stateRepository,
    this._errorHandler,
  );

  @override
  Future<void> execute({required String oldPin, required String newPin}) async {
    final state = _stateRepository.state;
    if (state == null) {
      _errorHandler.handle(BusinessException.invalidState());
      return;
    }
    state.handler.pins(oldPin, newPin);
  }
}
