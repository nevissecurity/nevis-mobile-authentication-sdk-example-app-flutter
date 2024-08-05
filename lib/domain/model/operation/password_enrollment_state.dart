// Copyright © 2024 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/simple_base_state.dart';

class PasswordEnrollmentState extends SimpleBaseState<PasswordEnrollmentContext,
    PasswordEnrollmentHandler> {
  final PasswordEnrollmentContext _context;
  final PasswordEnrollmentHandler _handler;

  PasswordEnrollmentState(this._context, this._handler);

  @override
  PasswordEnrollmentContext get context => _context;

  @override
  PasswordEnrollmentHandler get handler => _handler;

  @override
  Future<void> cancel() async {
    await handler.cancel();
  }
}
