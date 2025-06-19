// Copyright © 2024 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/l10n/app_localizations.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/credential/credential_kind.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/credential/credential_mode.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/app_text.dart';

class CredentialTitleLabel extends StatelessWidget {
  final CredentialMode mode;
  final CredentialKind kind;

  const CredentialTitleLabel({
    super.key,
    required this.mode,
    required this.kind,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: AppText.title(_title(localization, mode, kind)),
      ),
    );
  }

  String _title(
    AppLocalizations localization,
    CredentialMode mode,
    CredentialKind kind,
  ) {
    switch (mode) {
      case CredentialMode.enrollment:
        switch (kind) {
          case CredentialKind.pin:
            return localization.credentialScreenTitlePinEnrollment;
          case CredentialKind.password:
            return localization.credentialScreenTitlePasswordEnrollment;
        }
      case CredentialMode.verification:
        switch (kind) {
          case CredentialKind.pin:
            return localization.credentialScreenTitlePinVerification;
          case CredentialKind.password:
            return localization.credentialScreenTitlePasswordVerification;
        }
      case CredentialMode.change:
        switch (kind) {
          case CredentialKind.pin:
            return localization.credentialScreenTitlePinChange;
          case CredentialKind.password:
            return localization.credentialScreenTitlePasswordChange;
        }
    }
  }
}
