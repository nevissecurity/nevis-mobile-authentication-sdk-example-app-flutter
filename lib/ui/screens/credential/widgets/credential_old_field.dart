// Copyright © 2024 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/credential/credential_kind.dart';

class CredentialOldField extends StatelessWidget {
  final TextEditingController textEditingController;
  final CredentialKind kind;

  const CredentialOldField({
    super.key,
    required this.textEditingController,
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
          keyboardType: (kind == CredentialKind.pin)
              ? TextInputType.number
              : TextInputType.text,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: _label(localization),
            hintText: _hint(localization),
          ),
        ),
      ],
    );
  }

  String _label(AppLocalizations localization) {
    switch (kind) {
      case CredentialKind.pin:
        return localization.credentialOldPinTitle;
      case CredentialKind.password:
        return localization.credentialOldPasswordTitle;
    }
  }

  String _hint(AppLocalizations localization) {
    switch (kind) {
      case CredentialKind.pin:
        return localization.credentialOldPinPlaceholder;
      case CredentialKind.password:
        return localization.credentialOldPasswordPlaceholder;
    }
  }
}
