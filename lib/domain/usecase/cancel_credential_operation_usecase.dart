// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/password_change_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/password_enrollment_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/pin_change_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/pin_enrollment_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

abstract class CancelCredentialOperationUseCase {
  Future<void> execute();
}

@Injectable(as: CancelCredentialOperationUseCase)
class CancelCredentialOperationUseCaseImpl
    implements CancelCredentialOperationUseCase {
  final StateRepository<PinEnrollmentState> _pinEnrollmentStateRepository;
  final StateRepository<PasswordEnrollmentState>
      _passwordEnrollmentStateRepository;
  final StateRepository<PinChangeState> _pinChangeStateRepository;
  final StateRepository<PasswordChangeState> _passwordChangeStateRepository;

  CancelCredentialOperationUseCaseImpl(
    this._pinEnrollmentStateRepository,
    this._passwordEnrollmentStateRepository,
    this._pinChangeStateRepository,
    this._passwordChangeStateRepository,
  );

  @override
  Future<void> execute() async {
    await _pinEnrollmentStateRepository.state?.cancel();
    await _passwordEnrollmentStateRepository.state?.cancel();
    await _pinChangeStateRepository.state?.cancel();
    await _passwordChangeStateRepository.state?.cancel();
  }
}
