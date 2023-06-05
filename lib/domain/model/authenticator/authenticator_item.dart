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

  bool isEnabled() {
    return isPolicyCompliant && (aaid.isPin || isUserEnrolled);
  }
}
