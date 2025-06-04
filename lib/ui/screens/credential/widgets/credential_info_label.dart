// Copyright © 2024 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/l10n/app_localizations.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';

class CredentialInfoLabel extends StatelessWidget {
  final PinAuthenticatorProtectionStatus? pinProtectionStatus;
  final PasswordAuthenticatorProtectionStatus? passwordProtectionStatus;

  const CredentialInfoLabel({
    super.key,
    this.pinProtectionStatus,
    this.passwordProtectionStatus,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          _info(localization),
          style: const TextStyle(color: Colors.black),
        ),
      ],
    );
  }

  String _info(AppLocalizations localization) {
    if (pinProtectionStatus is PinProtectionStatusLockedOut ||
        passwordProtectionStatus is PasswordProtectionStatusLockedOut) {
      return localization.authenticatorProtectionStatusLocked;
    }

    int? remainingRetries;
    int? coolDownTime;
    if (pinProtectionStatus is PinProtectionStatusLastAttemptFailed) {
      final status =
          pinProtectionStatus as PinProtectionStatusLastAttemptFailed;
      remainingRetries = status.remainingRetries;
      coolDownTime = status.coolDownTime.inSeconds;
    } else if (passwordProtectionStatus
        is PasswordProtectionStatusLastAttemptFailed) {
      final status =
          passwordProtectionStatus as PasswordProtectionStatusLastAttemptFailed;
      remainingRetries = status.remainingRetries;
      coolDownTime = status.coolDownTime.inSeconds;
    }

    if (remainingRetries != null && coolDownTime != null) {
      // NOTE: if coolDownTime is not zero, a countdown timer should be started.
      return localization.authenticatorProtectionStatusLastAttemptFailed(
        remainingRetries,
        coolDownTime,
      );
    }

    return '';
  }
}
