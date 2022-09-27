// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';

class AuthenticatorListTile extends StatelessWidget {
  final Authenticator authenticator;
  final GestureTapCallback? onTap;

  const AuthenticatorListTile({Key? key, required this.authenticator, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _localization = AppLocalizations.of(context)!;
    final _titles = {
      Aaid.pin.rawValue: _localization.authenticatorTitlePin,
    };

    if (Platform.isAndroid) {
      _titles.addAll({
        Aaid.fingerprint.rawValue: _localization.authenticatorTitleFingerprint,
        Aaid.biometric.rawValue: _localization.authenticatorTitleBiometric,
      });
    } else if (Platform.isIOS) {
      _titles.addAll({
        Aaid.fingerprint.rawValue: _localization.authenticatorTitleTouchID,
        Aaid.biometric.rawValue: _localization.authenticatorTitleFaceID,
      });
    }

    final _descriptions = {
      Aaid.pin.rawValue: _localization.authenticatorDescriptionPin,
    };

    if (Platform.isAndroid) {
      _descriptions.addAll({
        Aaid.fingerprint.rawValue: _localization.authenticatorDescriptionFingerprint,
        Aaid.biometric.rawValue: _localization.authenticatorDescriptionBiometric,
      });
    } else if (Platform.isIOS) {
      _descriptions.addAll({
        Aaid.fingerprint.rawValue: _localization.authenticatorDescriptionTouchID,
        Aaid.biometric.rawValue: _localization.authenticatorDescriptionFaceID,
      });
    }

    return ListTile(
      title: Text(_titles[authenticator.aaid] ?? 'Unknown AAID: ${authenticator.aaid}'),
      subtitle: Text(_descriptions[authenticator.aaid] ?? 'N/A'),
      onTap: onTap,
    );
  }
}
