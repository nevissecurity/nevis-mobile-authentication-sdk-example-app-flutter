// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign textAlign;
  final Color textColor;

  const AppText({
    super.key,
    required this.text,
    this.style = const TextStyle(fontSize: 17.0),
    this.textAlign = TextAlign.start,
    this.textColor = Colors.black,
  });

  const AppText.title(
    this.text, {
    super.key,
    this.textColor = Colors.black,
  })  : style = const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
        ),
        textAlign = TextAlign.center;

  const AppText.body(
    this.text, {
    super.key,
    this.textColor = Colors.black,
  })  : style = const TextStyle(fontSize: 17.0),
        textAlign = TextAlign.center;

  const AppText.footnote(
    this.text, {
    super.key,
    this.textColor = Colors.black,
  })  : style = const TextStyle(
          fontSize: 13.0,
          fontWeight: FontWeight.w400,
        ),
        textAlign = TextAlign.left;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.copyWith(color: textColor),
      textAlign: textAlign,
    );
  }
}
