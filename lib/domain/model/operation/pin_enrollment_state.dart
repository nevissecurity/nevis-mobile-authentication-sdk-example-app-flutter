// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/simple_base_state.dart';

class EnrollPinState
    extends SimpleBaseState<PinEnrollmentContext, PinEnrollmentHandler> {
  final PinEnrollmentContext _context;
  final PinEnrollmentHandler _handler;

  EnrollPinState(this._context, this._handler);

  @override
  PinEnrollmentContext get context => _context;

  @override
  PinEnrollmentHandler get handler => _handler;

  @override
  Future<void> cancel() async {
    await handler.cancel();
  }
}
