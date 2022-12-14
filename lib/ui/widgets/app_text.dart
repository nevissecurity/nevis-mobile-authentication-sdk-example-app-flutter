// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign textAlign;
  final Color textColor;

  const AppText({
    Key? key,
    required this.text,
    this.style = const TextStyle(),
    this.textAlign = TextAlign.start,
    this.textColor = Colors.black,
  }) : super(key: key);

  const AppText.title(
    this.text, {
    Key? key,
    this.textColor = Colors.black,
  })  : style = const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
        textAlign = TextAlign.center,
        super(key: key);

  const AppText.body(
    this.text, {
    Key? key,
    this.textColor = Colors.black,
  })  : style = const TextStyle(
          fontSize: 14.0,
        ),
        textAlign = TextAlign.center,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.copyWith(color: textColor),
      textAlign: textAlign,
    );
  }
}
