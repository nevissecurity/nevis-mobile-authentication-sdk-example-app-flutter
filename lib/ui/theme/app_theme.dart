// Copyright © 2026 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';

/// Light theme of the application.
///
/// Only the scaffold background is pinned, everything else is left on the
/// Material 3 baseline color scheme
final ThemeData lightAppTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
);

/// Dark theme of the application.
final ThemeData darkAppTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
);
