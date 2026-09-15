// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final GestureTapCallback onPressed;

  const Button.outlined({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      child: TextButton(
        onPressed: onPressed,
        style: _buttonStyle(context),
        child: Text(
          text,
          textAlign: TextAlign
              .center, // needed because longer texts where the text displayed in more lines
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: 17.0,
            height: 1.25,
          ),
        ),
      ),
    );
  }

  ButtonStyle _buttonStyle(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return OutlinedButton.styleFrom(
      foregroundColor: onSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(width: 1.0, color: onSurface),
      ),
      minimumSize: Size(MediaQuery.of(context).size.width, 36),
    );
  }
}
