// Copyright © 2024 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/simple_base_state.dart';

class PasswordChangeState
    implements SimpleBaseState<PasswordChangeContext, PasswordChangeHandler> {
  final PasswordChangeContext _context;
  final PasswordChangeHandler _handler;

  PasswordChangeState(this._context, this._handler);

  @override
  PasswordChangeContext get context => _context;

  @override
  PasswordChangeHandler get handler => _handler;

  @override
  Future<void> cancel() async {
    await handler.cancel();
  }
}
