// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final GestureTapCallback onPressed;

  const Button.outlined({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

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
            fontSize: 16.0,
            height: 1.25,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  ButtonStyle _buttonStyle(BuildContext context) {
    return OutlinedButton.styleFrom(
      side: const BorderSide(width: 1.0, color: Colors.black),
      minimumSize: Size(MediaQuery.of(context).size.width, 36),
      // minimumSize: const Size(64, 32),
    );
  }
}
