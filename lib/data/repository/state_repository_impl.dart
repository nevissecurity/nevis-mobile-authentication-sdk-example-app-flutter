// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/data/cache/cache.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/password_enrollment_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/password_change_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/pin_change_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/pin_enrollment_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/user_interaction_operation_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

abstract class StateRepositoryImpl<T> implements StateRepository<T> {
  final Cache<T> _cache;

  StateRepositoryImpl(this._cache);

  @override
  void save(T state) {
    _cache.put(state);
  }

  @override
  T? get state => _cache.item;

  @override
  void reset() {
    _cache.clear();
  }
}

@Injectable(as: StateRepository<UserInteractionOperationState>)
class UserInteractionOperationStateRepositoryImpl
    extends StateRepositoryImpl<UserInteractionOperationState> {
  UserInteractionOperationStateRepositoryImpl(
      super.userInteractionOperationStateCache);
}

@Injectable(as: StateRepository<PinEnrollmentState>)
class PinEnrollmentStateRepositoryImpl
    extends StateRepositoryImpl<PinEnrollmentState> {
  PinEnrollmentStateRepositoryImpl(super.pinEnrollmentStateCache);
}

@Injectable(as: StateRepository<PinChangeState>)
class PinChangeStateRepositoryImpl extends StateRepositoryImpl<PinChangeState> {
  PinChangeStateRepositoryImpl(super.pinChangeStateCache);
}

@Injectable(as: StateRepository<PasswordEnrollmentState>)
class PasswordEnrollmentStateRepositoryImpl
    extends StateRepositoryImpl<PasswordEnrollmentState> {
  PasswordEnrollmentStateRepositoryImpl(super.passwordEnrollmentStateCache);
}

@Injectable(as: StateRepository<PasswordChangeState>)
class PasswordChangeStateRepositoryImpl
    extends StateRepositoryImpl<PasswordChangeState> {
  PasswordChangeStateRepositoryImpl(super.passwordChangeStateCache);
}

@Injectable(as: StateRepository<OperationType>)
class OperationTypeRepositoryImpl extends StateRepositoryImpl<OperationType> {
  OperationTypeRepositoryImpl(super.operationTypeCache);
}
