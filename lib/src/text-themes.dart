library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Overrides defaults with [EzConfig]
TextTheme materialTextTheme() {
  double fontScalar = EzConfig.prefs[fontScalarKey];

  return TextTheme(
    // Displays
    displayLarge: EzTextStyle(
      fontSize: 58 * fontScalar,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: EzTextStyle(
      fontSize: 46 * fontScalar,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: EzTextStyle(
      fontSize: 36 * fontScalar,
      fontWeight: FontWeight.bold,
    ),

    // Headlines
    headlineLarge: EzTextStyle(
      fontSize: 32,
      decoration: TextDecoration.underline,
    ),
    headlineMedium: EzTextStyle(
      fontSize: 28,
      decoration: TextDecoration.underline,
    ),
    headlineSmall: EzTextStyle(
      fontSize: 24,
      decoration: TextDecoration.underline,
    ),

    // Titles
    titleLarge: EzTextStyle(fontSize: 22),
    titleMedium: EzTextStyle(fontSize: 16),
    titleSmall: EzTextStyle(fontSize: 14),

    // Labels
    labelLarge: EzTextStyle(
      fontSize: 14,
      decoration: TextDecoration.underline,
    ),
    labelMedium: EzTextStyle(
      fontSize: 12,
      decoration: TextDecoration.underline,
    ),
    labelSmall: EzTextStyle(
      fontSize: 10,
      decoration: TextDecoration.underline,
    ),

    // Body
    bodyLarge: EzTextStyle(fontSize: 16),
    bodyMedium: EzTextStyle(fontSize: 14),
    bodySmall: EzTextStyle(fontSize: 12),
  );
}

/// Overrides defaults with [EzConfig]
CupertinoTextThemeData cupertinoTextTheme() {
  return CupertinoTextThemeData(
    primaryColor: Color(EzConfig.prefs[themeTextColorKey]),

    // bodyLarge
    textStyle: EzTextStyle(fontSize: 16),

    // labelLarge
    actionTextStyle: EzTextStyle(
      fontSize: 14,
      decoration: TextDecoration.underline,
    ),

    // labelLarge
    tabLabelTextStyle: EzTextStyle(
      fontSize: 14,
      decoration: TextDecoration.underline,
    ),

    // titleMedium
    navTitleTextStyle: EzTextStyle(fontSize: 16),

    // titleLarge
    navLargeTitleTextStyle: EzTextStyle(fontSize: 22),

    // labelLarge
    navActionTextStyle: EzTextStyle(
      fontSize: 14,
      decoration: TextDecoration.underline,
    ),

    // bodyLarge
    pickerTextStyle: EzTextStyle(fontSize: 16),

    // bodyLarge
    dateTimePickerTextStyle: EzTextStyle(fontSize: 16),
  );
}
