// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/credential/credential_kind.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/error/error.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/password_enrollment_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/pin_enrollment_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

abstract class EnrollCredentialUseCase {
  Future<void> execute(
    CredentialKind kind,
    String credential,
  );
}

@Injectable(as: EnrollCredentialUseCase)
class EnrollCredentialUseCaseImpl implements EnrollCredentialUseCase {
  final StateRepository<PinEnrollmentState> _pinEnrollmentStateRepository;
  final StateRepository<PasswordEnrollmentState>
      _passwordEnrollmentStateRepository;

  EnrollCredentialUseCaseImpl(
    this._pinEnrollmentStateRepository,
    this._passwordEnrollmentStateRepository,
  );

  @override
  Future<void> execute(
    CredentialKind kind,
    String credential,
  ) async {
    switch (kind) {
      case CredentialKind.pin:
        final currentState = _pinEnrollmentStateRepository.state;
        if (currentState is PinEnrollmentState) {
          await currentState.handler.pin(credential);
        } else {
          throw BusinessException.invalidState();
        }
      case CredentialKind.password:
        final currentState = _passwordEnrollmentStateRepository.state;
        if (currentState is PasswordEnrollmentState) {
          await currentState.handler.password(credential);
        } else {
          throw BusinessException.invalidState();
        }
    }
  }
}
