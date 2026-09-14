// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign textAlign;

  /// Overrides the color of the text.
  ///
  /// When `null` the color is inherited from the ambient theme, which makes
  /// the text adapt to light and dark mode automatically.
  final Color? textColor;

  const AppText({
    super.key,
    required this.text,
    this.style = const TextStyle(fontSize: 17.0),
    this.textAlign = TextAlign.start,
    this.textColor,
  });

  const AppText.title(this.text, {super.key, this.textColor})
    : style = const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
      textAlign = TextAlign.center;

  const AppText.body(this.text, {super.key, this.textColor})
    : style = const TextStyle(fontSize: 17.0),
      textAlign = TextAlign.center;

  const AppText.footnote(this.text, {super.key, this.textColor})
    : style = const TextStyle(fontSize: 13.0, fontWeight: FontWeight.w400),
      textAlign = TextAlign.left;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textColor != null ? style.copyWith(color: textColor) : style,
      textAlign: textAlign,
    );
  }
}
