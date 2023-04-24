library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Default sizes taken from
// https://api.flutter.dev/flutter/material/TextTheme-class.html

TextStyle buildDisplayLarge(Color color) {
  return EzTextStyle(
    fontSize: 58 * EzConfig.fontScalar,
    color: color,
  );
}

TextStyle? displayLarge(BuildContext context) {
  return Theme.of(context).textTheme.displayLarge;
}

TextStyle buildDisplayMedium(Color color) {
  return EzTextStyle(
    fontSize: 46 * EzConfig.fontScalar,
    color: color,
  );
}

TextStyle? displayMedium(BuildContext context) {
  return Theme.of(context).textTheme.displayMedium;
}

TextStyle buildDisplaySmall(Color color) {
  return EzTextStyle(
    fontSize: 36 * EzConfig.fontScalar,
    color: color,
  );
}

TextStyle? displaySmall(BuildContext context) {
  return Theme.of(context).textTheme.displaySmall;
}

TextStyle buildHeadlineLarge(Color color) {
  return EzTextStyle(
    fontSize: 32 * EzConfig.fontScalar,
    color: color,
  );
}

TextStyle? headlineLarge(BuildContext context) {
  return Theme.of(context).textTheme.headlineLarge;
}

TextStyle buildHeadlineMedium(Color color) {
  return EzTextStyle(
    fontSize: 28 * EzConfig.fontScalar,
    color: color,
  );
}

TextStyle? headlineMedium(BuildContext context) {
  return Theme.of(context).textTheme.headlineMedium;
}

TextStyle buildHeadlineSmall(Color color) {
  return EzTextStyle(
    fontSize: 24 * EzConfig.fontScalar,
    color: color,
  );
}

TextStyle? headlineSmall(BuildContext context) {
  return Theme.of(context).textTheme.headlineSmall;
}

TextStyle buildTitleLarge(Color color) {
  return EzTextStyle(
    fontSize: 22 * EzConfig.fontScalar,
    color: color,
  );
}

TextStyle? titleLarge(BuildContext context) {
  return Theme.of(context).textTheme.titleLarge;
}

TextStyle buildTitleMedium(Color color) {
  return EzTextStyle(
    fontSize: 16 * EzConfig.fontScalar,
    color: color,
  );
}

TextStyle? titleMedium(BuildContext context) {
  return Theme.of(context).textTheme.titleMedium;
}

TextStyle buildTitleSmall(Color color) {
  return EzTextStyle(
    fontSize: 14 * EzConfig.fontScalar,
    color: color,
  );
}

TextStyle? titleSmall(BuildContext context) {
  return Theme.of(context).textTheme.titleSmall;
}

TextStyle buildLabelLarge(Color color) {
  return EzTextStyle(
    fontSize: 14 * EzConfig.fontScalar,
    color: color,
  );
}

TextStyle? labelLarge(BuildContext context) {
  return Theme.of(context).textTheme.labelLarge;
}

TextStyle buildLabelMedium(Color color) {
  return EzTextStyle(
    fontSize: 12 * EzConfig.fontScalar,
    color: color,
  );
}

TextStyle? labelMedium(BuildContext context) {
  return Theme.of(context).textTheme.labelMedium;
}

TextStyle buildLabelSmall(Color color) {
  return EzTextStyle(
    fontSize: 10 * EzConfig.fontScalar,
    color: color,
  );
}

TextStyle? labelSmall(BuildContext context) {
  return Theme.of(context).textTheme.labelSmall;
}

TextStyle buildBodyLarge(Color color) {
  return EzTextStyle(
    fontSize: 16 * EzConfig.fontScalar,
    color: color,
  );
}

TextStyle? bodyLarge(BuildContext context) {
  return Theme.of(context).textTheme.bodyLarge;
}

TextStyle buildBodyMedium(Color color) {
  return EzTextStyle(
    fontSize: 14 * EzConfig.fontScalar,
    color: color,
  );
}

TextStyle? bodyMedium(BuildContext context) {
  return Theme.of(context).textTheme.bodyMedium;
}

TextStyle buildBodySmall(Color color) {
  return EzTextStyle(
    fontSize: 12 * EzConfig.fontScalar,
    color: color,
  );
}

TextStyle? bodySmall(BuildContext context) {
  return Theme.of(context).textTheme.bodySmall;
}

/// Overrides defaults with [EzConfig]
TextTheme materialTextTheme(Color color) {
  return TextTheme(
    displayLarge: buildDisplayLarge(color),
    displayMedium: buildDisplayMedium(color),
    displaySmall: buildDisplaySmall(color),
    headlineLarge: buildHeadlineLarge(color),
    headlineMedium: buildHeadlineMedium(color),
    headlineSmall: buildHeadlineSmall(color),
    titleLarge: buildTitleLarge(color),
    titleMedium: buildTitleMedium(color),
    titleSmall: buildTitleSmall(color),
    labelLarge: buildLabelLarge(color),
    labelMedium: buildLabelMedium(color),
    labelSmall: buildLabelSmall(color),
    bodyLarge: buildBodyLarge(color),
    bodyMedium: buildBodyMedium(color),
    bodySmall: buildBodySmall(color),
  );
}

/// Overrides defaults with [EzConfig]
CupertinoTextThemeData cupertinoTextTheme(Color color) {
  return CupertinoTextThemeData(
    primaryColor: color,
    textStyle: buildBodyLarge(color),
    actionTextStyle: buildLabelLarge(color),
    tabLabelTextStyle: buildLabelLarge(color),
    navTitleTextStyle: buildTitleMedium(color),
    navLargeTitleTextStyle: buildTitleLarge(color),
    navActionTextStyle: buildLabelLarge(color),
    pickerTextStyle: buildBodyLarge(color),
    dateTimePickerTextStyle: buildBodyLarge(color),
  );
}
