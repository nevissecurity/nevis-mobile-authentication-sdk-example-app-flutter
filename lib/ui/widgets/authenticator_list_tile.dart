// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/authenticator/authenticator_item.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/l10n/app_localizations.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/util/localization_utils.dart';

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
    final localizations = AppLocalizations.of(context)!;

    return ListTile(
      title: Text(item.aaid.resolve(localizations)),
      subtitle: Text(item.resolveDetails(localizations)),
      onTap: onTap,
    );
  }
}
