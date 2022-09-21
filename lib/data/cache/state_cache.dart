// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/data/cache/cache.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/pin_change_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/pin_enrollment_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/user_interaction_operation_state.dart';

@Singleton(as: Cache<UserInteractionOperationState>)
class UserInteractionOperationStateCacheImpl extends CacheImpl<UserInteractionOperationState> {}

@Singleton(as: Cache<EnrollPinState>)
class EnrollPinStateCacheImpl extends CacheImpl<EnrollPinState> {}

@Singleton(as: Cache<PinChangeState>)
class ChangePinStateCacheImpl extends CacheImpl<PinChangeState> {}

@Singleton(as: Cache<OperationType>)
class OperationTypeCacheImpl extends CacheImpl<OperationType> {}
