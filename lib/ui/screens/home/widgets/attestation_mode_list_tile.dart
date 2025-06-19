// Copyright © 2025 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/app_text.dart';

class AttestationModeListTile extends StatelessWidget {
  final String title;
  final bool isSupported;

  const AttestationModeListTile({
    super.key,
    required this.title,
    required this.isSupported,
  });

  @override
  Widget build(BuildContext context) {
    final iconData = isSupported ? Icons.check : Icons.close;
    final color = isSupported ? Colors.green : Colors.red;

    return Row(
      children: <Widget>[
        Icon(iconData, color: color),
        AppText.footnote(title),
      ],
    );
  }
}
