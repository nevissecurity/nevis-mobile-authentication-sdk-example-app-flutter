// Copyright © 2023 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';

class AuthenticatorItem {
  final String aaid;
  final bool isPolicyCompliant;
  final bool isUserEnrolled;

  AuthenticatorItem({
    required this.aaid,
    required this.isPolicyCompliant,
    required this.isUserEnrolled,
  });

  AuthenticatorItem.pin()
      : aaid = Aaid.pin.rawValue,
        isPolicyCompliant = true,
        isUserEnrolled = true;

  AuthenticatorItem.password()
      : aaid = Aaid.password.rawValue,
        isPolicyCompliant = true,
        isUserEnrolled = true;

  bool isEnabled() {
    return isPolicyCompliant &&
        ((aaid.isPin || aaid.isPassword) || isUserEnrolled);
  }
}
