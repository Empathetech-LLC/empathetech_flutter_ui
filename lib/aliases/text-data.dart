library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

TextStyle displayLarge(Color color) {
  return EzTextStyle(
    fontSize: 58 * EzConfig.fontScalar,
    color: color,
  );
}

EzTextStyle displayMedium(Color color) {
  return EzTextStyle(
    fontSize: 46 * EzConfig.fontScalar,
    color: color,
  );
}

EzTextStyle displaySmall(Color color) {
  return EzTextStyle(
    fontSize: 36 * EzConfig.fontScalar,
    color: color,
  );
}

EzTextStyle headlineLarge(Color color) {
  return EzTextStyle(
    fontSize: 32 * EzConfig.fontScalar,
    color: color,
  );
}

EzTextStyle headlineMedium(Color color) {
  return EzTextStyle(
    fontSize: 28 * EzConfig.fontScalar,
    color: color,
  );
}

EzTextStyle headlineSmall(Color color) {
  return EzTextStyle(
    fontSize: 24 * EzConfig.fontScalar,
    color: color,
  );
}

EzTextStyle titleLarge(Color color) {
  return EzTextStyle(
    fontSize: 22 * EzConfig.fontScalar,
    color: color,
  );
}

EzTextStyle titleMedium(Color color) {
  return EzTextStyle(
    fontSize: 16 * EzConfig.fontScalar,
    color: color,
  );
}

EzTextStyle titleSmall(Color color) {
  return EzTextStyle(
    fontSize: 14 * EzConfig.fontScalar,
    color: color,
  );
}

EzTextStyle labelLarge(Color color) {
  return EzTextStyle(
    fontSize: 14 * EzConfig.fontScalar,
    color: color,
  );
}

EzTextStyle labelMedium(Color color) {
  return EzTextStyle(
    fontSize: 12 * EzConfig.fontScalar,
    color: color,
  );
}

EzTextStyle labelSmall(Color color) {
  return EzTextStyle(
    fontSize: 10 * EzConfig.fontScalar,
    color: color,
  );
}

EzTextStyle bodyLarge(Color color) {
  return EzTextStyle(
    fontSize: 16 * EzConfig.fontScalar,
    color: color,
  );
}

EzTextStyle bodyMedium(Color color) {
  return EzTextStyle(
    fontSize: 14 * EzConfig.fontScalar,
    color: color,
  );
}

EzTextStyle bodySmall(Color color) {
  return EzTextStyle(
    fontSize: 12 * EzConfig.fontScalar,
    color: color,
  );
}

/// Overrides defaults with [EzConfig]
TextTheme materialTextTheme(Color color) {
  return TextTheme(
    displayLarge: displayLarge(color),
    displayMedium: displayMedium(color),
    displaySmall: displaySmall(color),
    headlineLarge: headlineLarge(color),
    headlineMedium: headlineMedium(color),
    headlineSmall: headlineSmall(color),
    titleLarge: titleLarge(color),
    titleMedium: titleMedium(color),
    titleSmall: titleSmall(color),
    labelLarge: labelLarge(color),
    labelMedium: labelMedium(color),
    labelSmall: labelSmall(color),
    bodyLarge: bodyLarge(color),
    bodyMedium: bodyMedium(color),
    bodySmall: bodySmall(color),
  );
}

/// Overrides defaults with [EzConfig]
CupertinoTextThemeData cupertinoTextTheme(Color color) {
  return CupertinoTextThemeData(
    primaryColor: color,
    textStyle: bodyLarge(color),
    actionTextStyle: labelLarge(color),
    tabLabelTextStyle: labelLarge(color),
    navTitleTextStyle: titleMedium(color),
    navLargeTitleTextStyle: titleLarge(color),
    navActionTextStyle: labelLarge(color),
    pickerTextStyle: bodyLarge(color),
    dateTimePickerTextStyle: bodyLarge(color),
  );
}
