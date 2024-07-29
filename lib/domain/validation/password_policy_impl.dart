// Copyright © 2024 Nevis Security AG. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';

@Injectable(as: PasswordPolicy)
class PasswordPolicyImpl implements PasswordPolicy {
  final _errorMessage = 'The password must not be password.';
  final _cause = 'The password is password';

  @override
  void validatePasswordForEnrollment({
    required String password,
    required Function onSuccess,
    required Function(PasswordEnrollmentCustomValidationError) onError,
  }) {
    debugPrint('Received password for enrollment is $password');
    _isValid(password)
        ? onSuccess.call()
        : onError.call(PasswordEnrollmentCustomValidationError.create(
            _errorMessage,
            _cause,
          ));
  }

  @override
  void validatePasswordForPasswordChange({
    required String password,
    required Function onSuccess,
    required Function(PasswordChangeRecoverableCustomValidationError) onError,
  }) {
    debugPrint('Received password for change is $password');
    _isValid(password)
        ? onSuccess.call()
        : onError.call(PasswordChangeRecoverableCustomValidationError.create(
            _errorMessage,
            _cause,
          ));
  }

  bool _isValid(String password) {
    return password.trim() != 'password';
  }
}
