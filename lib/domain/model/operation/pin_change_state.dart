// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/simple_base_state.dart';

class PinChangeState
    implements SimpleBaseState<PinChangeContext, PinChangeHandler> {
  final PinChangeContext _context;
  final PinChangeHandler _handler;

  PinChangeState(this._context, this._handler);

  @override
  PinChangeContext get context => _context;

  @override
  PinChangeHandler get handler => _handler;

  @override
  Future<void> cancel() async {
    await handler.cancel();
  }
}
