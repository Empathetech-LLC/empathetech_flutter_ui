library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Overrides defaults with [EzConfig]
TextTheme materialTextTheme(Color color) {
  double fontScalar = EzConfig.prefs[fontScalarKey];

  return TextTheme(
    // Displays
    displayLarge: EzTextStyle(
      fontSize: 58 * fontScalar,
      color: color,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: EzTextStyle(
      fontSize: 46 * fontScalar,
      color: color,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: EzTextStyle(
      fontSize: 36 * fontScalar,
      color: color,
      fontWeight: FontWeight.bold,
    ),

    // Headlines
    headlineLarge: EzTextStyle(
      fontSize: 32,
      color: color,
      decoration: TextDecoration.underline,
    ),
    headlineMedium: EzTextStyle(
      fontSize: 28,
      color: color,
      decoration: TextDecoration.underline,
    ),
    headlineSmall: EzTextStyle(
      fontSize: 24,
      color: color,
      decoration: TextDecoration.underline,
    ),

    // Titles
    titleLarge: EzTextStyle(
      fontSize: 22,
      color: color,
    ),
    titleMedium: EzTextStyle(
      fontSize: 16,
      color: color,
    ),
    titleSmall: EzTextStyle(
      fontSize: 14,
      color: color,
    ),

    // Labels
    labelLarge: EzTextStyle(
      fontSize: 14,
      color: color,
      decoration: TextDecoration.underline,
    ),
    labelMedium: EzTextStyle(
      fontSize: 12,
      color: color,
      decoration: TextDecoration.underline,
    ),
    labelSmall: EzTextStyle(
      fontSize: 10,
      color: color,
      decoration: TextDecoration.underline,
    ),

    // Body
    bodyLarge: EzTextStyle(
      fontSize: 16,
      color: color,
    ),
    bodyMedium: EzTextStyle(
      fontSize: 14,
      color: color,
    ),
    bodySmall: EzTextStyle(
      fontSize: 12,
      color: color,
    ),
  );
}

/// Overrides defaults with [EzConfig]
CupertinoTextThemeData cupertinoTextTheme(Color primaryColor) {
  return CupertinoTextThemeData(
    primaryColor: primaryColor,

    // bodyLarge
    textStyle: EzTextStyle(
      fontSize: 16,
      color: primaryColor,
    ),

    // labelLarge
    actionTextStyle: EzTextStyle(
      fontSize: 14,
      color: primaryColor,
      decoration: TextDecoration.underline,
    ),

    // labelLarge
    tabLabelTextStyle: EzTextStyle(
      fontSize: 14,
      color: primaryColor,
      decoration: TextDecoration.underline,
    ),

    // titleMedium
    navTitleTextStyle: EzTextStyle(
      fontSize: 16,
      color: primaryColor,
    ),

    // titleLarge
    navLargeTitleTextStyle: EzTextStyle(
      fontSize: 22,
      color: primaryColor,
    ),

    // labelLarge
    navActionTextStyle: EzTextStyle(
      fontSize: 14,
      color: primaryColor,
      decoration: TextDecoration.underline,
    ),

    // bodyLarge
    pickerTextStyle: EzTextStyle(
      fontSize: 16,
      color: primaryColor,
    ),

    // bodyLarge
    dateTimePickerTextStyle: EzTextStyle(
      fontSize: 16,
      color: primaryColor,
    ),
  );
}
