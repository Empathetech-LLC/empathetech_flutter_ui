library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

// Default sizes taken from
// https://api.flutter.dev/flutter/material/TextTheme-class.html

TextStyle buildDisplayLarge(Color color) {
  return const EzTextStyle(fontSize: 58, color: color);
}

TextStyle? displayLarge(BuildContext context) {
  return Theme.of(context).textTheme.displayLarge;
}

TextStyle buildDisplayMedium(Color color) {
  return EzTextStyle(fontSize: 46, color: color);
}

TextStyle? displayMedium(BuildContext context) {
  return Theme.of(context).textTheme.displayMedium;
}

TextStyle buildDisplaySmall(Color color) {
  return EzTextStyle(fontSize: 36, color: color);
}

TextStyle? displaySmall(BuildContext context) {
  return Theme.of(context).textTheme.displaySmall;
}

TextStyle buildHeadlineLarge(Color color) {
  return EzTextStyle(fontSize: 32, color: color);
}

TextStyle? headlineLarge(BuildContext context) {
  return Theme.of(context).textTheme.headlineLarge;
}

TextStyle buildHeadlineMedium(Color color) {
  return EzTextStyle(fontSize: 28, color: color);
}

TextStyle? headlineMedium(BuildContext context) {
  return Theme.of(context).textTheme.headlineMedium;
}

TextStyle buildHeadlineSmall(Color color) {
  return EzTextStyle(fontSize: 24, color: color);
}

TextStyle? headlineSmall(BuildContext context) {
  return Theme.of(context).textTheme.headlineSmall;
}

TextStyle buildTitleLarge(Color color) {
  return EzTextStyle(fontSize: 22, color: color);
}

TextStyle? titleLarge(BuildContext context) {
  return Theme.of(context).textTheme.titleLarge;
}

TextStyle buildTitleMedium(Color color) {
  return EzTextStyle(fontSize: 16, color: color);
}

TextStyle? titleMedium(BuildContext context) {
  return Theme.of(context).textTheme.titleMedium;
}

TextStyle buildTitleSmall(Color color) {
  return EzTextStyle(fontSize: 14, color: color);
}

TextStyle? titleSmall(BuildContext context) {
  return Theme.of(context).textTheme.titleSmall;
}

TextStyle buildLabelLarge(Color color) {
  return EzTextStyle(fontSize: 14, color: color);
}

TextStyle? labelLarge(BuildContext context) {
  return Theme.of(context).textTheme.labelLarge;
}

TextStyle buildLabelMedium(Color color) {
  return EzTextStyle(fontSize: 12, color: color);
}

TextStyle? labelMedium(BuildContext context) {
  return Theme.of(context).textTheme.labelMedium;
}

TextStyle buildLabelSmall(Color color) {
  return EzTextStyle(fontSize: 10, color: color);
}

TextStyle? labelSmall(BuildContext context) {
  return Theme.of(context).textTheme.labelSmall;
}

TextStyle buildBodyLarge(Color color) {
  return EzTextStyle(fontSize: 16, color: color);
}

TextStyle? bodyLarge(BuildContext context) {
  return Theme.of(context).textTheme.bodyLarge;
}

TextStyle buildBodyMedium(Color color) {
  return EzTextStyle(fontSize: 14, color: color);
}

TextStyle? bodyMedium(BuildContext context) {
  return Theme.of(context).textTheme.bodyMedium;
}

TextStyle buildBodySmall(Color color) {
  return EzTextStyle(fontSize: 12, color: color);
}

TextStyle? bodySmall(BuildContext context) {
  return Theme.of(context).textTheme.bodySmall;
}
