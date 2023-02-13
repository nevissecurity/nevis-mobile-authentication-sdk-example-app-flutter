// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';

class AuthenticatorListTile extends StatelessWidget {
  final Authenticator authenticator;
  final GestureTapCallback? onTap;

  const AuthenticatorListTile(
      {Key? key, required this.authenticator, this.onTap})
      : super(key: key);

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

    final descriptions = {
      Aaid.pin.rawValue: localization.authenticatorDescriptionPin,
    };

    if (Platform.isAndroid) {
      descriptions.addAll({
        Aaid.fingerprint.rawValue:
            localization.authenticatorDescriptionFingerprint,
        Aaid.biometric.rawValue: localization.authenticatorDescriptionBiometric,
      });
    } else if (Platform.isIOS) {
      descriptions.addAll({
        Aaid.fingerprint.rawValue: localization.authenticatorDescriptionTouchID,
        Aaid.biometric.rawValue: localization.authenticatorDescriptionFaceID,
      });
    }

    return ListTile(
      title: Text(
          titles[authenticator.aaid] ?? 'Unknown AAID: ${authenticator.aaid}'),
      subtitle: Text(descriptions[authenticator.aaid] ?? 'N/A'),
      onTap: onTap,
    );
  }
}
