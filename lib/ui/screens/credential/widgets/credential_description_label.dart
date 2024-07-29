// Copyright © 2024 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/credential/credential_kind.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/credential/credential_mode.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/app_text.dart';

class CredentialDescriptionLabel extends StatelessWidget {
  final CredentialMode mode;
  final CredentialKind kind;

  const CredentialDescriptionLabel({
    super.key,
    required this.mode,
    required this.kind,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return AppText(text: _description(localization, mode, kind));
  }

  String _description(
    AppLocalizations localization,
    CredentialMode mode,
    CredentialKind kind,
  ) {
    switch (mode) {
      case CredentialMode.enrollment:
        switch (kind) {
          case CredentialKind.pin:
            return localization.credentialScreenDescriptionPinEnrollment;
          case CredentialKind.password:
            return localization.credentialScreenDescriptionPasswordEnrollment;
        }
      case CredentialMode.verification:
        switch (kind) {
          case CredentialKind.pin:
            return localization.credentialScreenDescriptionPinVerification;
          case CredentialKind.password:
            return localization.credentialScreenDescriptionPasswordVerification;
        }
      case CredentialMode.change:
        switch (kind) {
          case CredentialKind.pin:
            return localization.credentialScreenDescriptionPinChange;
          case CredentialKind.password:
            return localization.credentialScreenDescriptionPasswordChange;
        }
    }
  }
}
