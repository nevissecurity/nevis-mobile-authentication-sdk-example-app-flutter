// Copyright © 2024 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';

class CredentialErrorLabel extends StatelessWidget {
  final String errorMessage;

  const CredentialErrorLabel({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        Text(
          errorMessage,
          style: const TextStyle(color: Colors.red),
        ),
      ],
    );
  }
}
