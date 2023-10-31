// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/authenticator/authenticator_item.dart';

class AuthenticatorListTile extends StatelessWidget {
  final AuthenticatorItem item;
  final GestureTapCallback? onTap;

  const AuthenticatorListTile({
    super.key,
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final titles = {
      Aaid.pin.rawValue: localization.authenticatorTitlePin,
    };

    if (Platform.isAndroid) {
      titles.addAll({
        Aaid.fingerprint.rawValue: localization.authenticatorTitleFingerprint,
        Aaid.biometric.rawValue: localization.authenticatorTitleBiometric,
      });
    } else if (Platform.isIOS) {
      titles.addAll({
        Aaid.fingerprint.rawValue: localization.authenticatorTitleTouchID,
        Aaid.biometric.rawValue: localization.authenticatorTitleFaceID,
      });
    }

    titles[Aaid.devicePasscode.rawValue] =
        localization.authenticatorTitleDevicePasscode;

    String subTitle = "";
    if (!item.isEnabled()) {
      if (!item.isPolicyCompliant) {
        subTitle =
            localization.selectAuthenticatorAuthenticatorIsNotPolicyCompliant;
      } else if (!item.isUserEnrolled) {
        subTitle = localization.selectAuthenticatorAuthenticatorIsNotEnrolled;
      }
    }

    return ListTile(
      title: Text(titles[item.aaid] ?? 'Unknown AAID: ${item.aaid}'),
      subtitle: Text(subTitle),
      onTap: onTap,
    );
  }
}
