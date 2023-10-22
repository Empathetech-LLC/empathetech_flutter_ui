/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Returns the soon-to-be rendered size of text via a [TextPainter]
/// [scalar] should be the value from MediaQuery.of(context).textScaleFactor
Size measureText(
  text, {
  required double scalar,
  required TextStyle? style,
}) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: 1,
    textScaleFactor: scalar,
    textDirection: TextDirection.ltr,
  )..layout();

  return textPainter.size;
}

/// For web apps, set the tab's title
void setPageTitle(
  BuildContext context,
  String title,
) {
  SystemChrome.setApplicationSwitcherDescription(
    ApplicationSwitcherDescription(label: title),
  );
}

TextTheme ezTextTheme(Color color) {
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

// Build && getter functions
// Sizes taken from https://api.flutter.dev/flutter/material/TextTheme-class.html

TextStyle buildDisplayLarge(Color color) {
  return EzTextStyle(
    fontSize: 56,
    color: color,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

TextStyle? displayLarge(BuildContext context) {
  return Theme.of(context).textTheme.displayLarge;
}

TextStyle buildDisplayMedium(Color color) {
  return EzTextStyle(
    fontSize: 46,
    color: color,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

TextStyle? displayMedium(BuildContext context) {
  return Theme.of(context).textTheme.displayMedium;
}

TextStyle buildDisplaySmall(Color color) {
  return EzTextStyle(
    fontSize: 36,
    color: color,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

TextStyle? displaySmall(BuildContext context) {
  return Theme.of(context).textTheme.displaySmall;
}

TextStyle buildHeadlineLarge(Color color) {
  return EzTextStyle(
    fontSize: 32,
    color: color,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

TextStyle? headlineLarge(BuildContext context) {
  return Theme.of(context).textTheme.headlineLarge;
}

TextStyle buildHeadlineMedium(Color color) {
  return EzTextStyle(
    fontSize: 28,
    color: color,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

TextStyle? headlineMedium(BuildContext context) {
  return Theme.of(context).textTheme.headlineMedium;
}

TextStyle buildHeadlineSmall(Color color) {
  return EzTextStyle(
    fontSize: 24,
    color: color,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

TextStyle? headlineSmall(BuildContext context) {
  return Theme.of(context).textTheme.headlineSmall;
}

TextStyle buildTitleLarge(Color color) {
  return EzTextStyle(
    fontSize: 22,
    color: color,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

TextStyle? titleLarge(BuildContext context) {
  return Theme.of(context).textTheme.titleLarge;
}

TextStyle buildTitleMedium(Color color) {
  return EzTextStyle(
    fontSize: 18,
    color: color,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

TextStyle? titleMedium(BuildContext context) {
  return Theme.of(context).textTheme.titleMedium;
}

TextStyle buildTitleSmall(Color color) {
  return EzTextStyle(
    fontSize: 14,
    color: color,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

TextStyle? titleSmall(BuildContext context) {
  return Theme.of(context).textTheme.titleSmall;
}

TextStyle buildLabelLarge(Color color) {
  return EzTextStyle(
    fontSize: 14,
    color: color,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

TextStyle? labelLarge(BuildContext context) {
  return Theme.of(context).textTheme.labelLarge;
}

TextStyle buildLabelMedium(Color color) {
  return EzTextStyle(
    fontSize: 12,
    color: color,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

TextStyle? labelMedium(BuildContext context) {
  return Theme.of(context).textTheme.labelMedium;
}

TextStyle buildLabelSmall(Color color) {
  return EzTextStyle(
    fontSize: 10,
    color: color,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

TextStyle? labelSmall(BuildContext context) {
  return Theme.of(context).textTheme.labelSmall;
}

TextStyle buildBodyLarge(Color color) {
  return EzTextStyle(
    fontSize: 16,
    color: color,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

TextStyle? bodyLarge(BuildContext context) {
  return Theme.of(context).textTheme.bodyLarge;
}

TextStyle buildBodyMedium(Color color) {
  return EzTextStyle(
    fontSize: 14,
    color: color,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

TextStyle? bodyMedium(BuildContext context) {
  return Theme.of(context).textTheme.bodyMedium;
}

TextStyle buildBodySmall(Color color) {
  return EzTextStyle(
    fontSize: 12,
    color: color,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

TextStyle? bodySmall(BuildContext context) {
  return Theme.of(context).textTheme.bodySmall;
}
