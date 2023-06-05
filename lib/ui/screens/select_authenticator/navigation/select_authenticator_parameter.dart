// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/authenticator/authenticator_item.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';

class SelectAuthenticatorParameter {
  final Set<AuthenticatorItem> authenticatorItems;
  final OperationType? operationType;
  final String? username;
  final AuthorizationProvider? authorizationProvider;

  SelectAuthenticatorParameter({
    required this.authenticatorItems,
    this.operationType,
    this.username,
    this.authorizationProvider,
  });
}
