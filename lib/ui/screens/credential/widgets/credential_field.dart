// Copyright © 2024 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/credential/credential_kind.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/credential/credential_mode.dart';

class CredentialField extends StatelessWidget {
  final TextEditingController textEditingController;
  final CredentialMode mode;
  final CredentialKind kind;

  const CredentialField({
    super.key,
    required this.textEditingController,
    required this.mode,
    required this.kind,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Column(
      children: [
        const SizedBox(height: 16),
        TextFormField(
          obscureText: true,
          controller: textEditingController,
          keyboardType: _keyboardType(),
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            labelText: _label(localization),
            hintText: _hint(localization),
          ),
        ),
      ],
    );
  }

  TextInputType _keyboardType() {
    switch (kind) {
      case CredentialKind.pin:
        return TextInputType.number;
      case CredentialKind.password:
        return TextInputType.text;
    }
  }

  String _label(AppLocalizations localization) {
    switch (kind) {
      case CredentialKind.pin:
        switch (mode) {
          case CredentialMode.change:
            return localization.credentialNewPinTitle;
          default:
            return localization.credentialPinTitle;
        }
      case CredentialKind.password:
        switch (mode) {
          case CredentialMode.change:
            return localization.credentialNewPasswordTitle;
          default:
            return localization.credentialPasswordTitle;
        }
    }
  }

  String _hint(AppLocalizations localization) {
    switch (kind) {
      case CredentialKind.pin:
        switch (mode) {
          case CredentialMode.change:
            return localization.credentialNewPinPlaceholder;
          default:
            return localization.credentialPinPlaceholder;
        }
      case CredentialKind.password:
        switch (mode) {
          case CredentialMode.change:
            return localization.credentialNewPasswordPlaceholder;
          default:
            return localization.credentialPasswordPlaceholder;
        }
    }
  }
}
