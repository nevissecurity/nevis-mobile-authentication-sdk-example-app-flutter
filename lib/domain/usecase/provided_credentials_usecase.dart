// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/credential/credential_kind.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/error/error.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/password_change_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/pin_change_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

abstract class ProvidedCredentialsUseCase {
  Future<void> execute({
    required CredentialKind kind,
    required String oldCredential,
    required String newCredential,
  });
}

@Injectable(as: ProvidedCredentialsUseCase)
class ProvidedCredentialsUseCaseImpl implements ProvidedCredentialsUseCase {
  final StateRepository<PinChangeState> _pinChangeStateRepository;
  final StateRepository<PasswordChangeState> _passwordChangeStateRepository;

  ProvidedCredentialsUseCaseImpl(
    this._pinChangeStateRepository,
    this._passwordChangeStateRepository,
  );

  @override
  Future<void> execute({
    required CredentialKind kind,
    required String oldCredential,
    required String newCredential,
  }) async {
    switch (kind) {
      case CredentialKind.pin:
        final state = _pinChangeStateRepository.state;
        if (state == null) {
          throw BusinessException.invalidState();
        }
        state.handler.pins(oldCredential, newCredential);
      case CredentialKind.password:
        final state = _passwordChangeStateRepository.state;
        if (state == null) {
          throw BusinessException.invalidState();
        }
        state.handler.passwords(oldCredential, newCredential);
    }
  }
}
