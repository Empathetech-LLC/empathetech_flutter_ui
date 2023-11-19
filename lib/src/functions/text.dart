/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Returns whether the passed [text] follows a URL pattern
bool isUrl(String text) {
  return Uri.parse(text).host.isNotEmpty;
}

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

TextStyle? displayLarge(BuildContext context) {
  return Theme.of(context).textTheme.displayLarge;
}

TextStyle? displayMedium(BuildContext context) {
  return Theme.of(context).textTheme.displayMedium;
}

TextStyle? displaySmall(BuildContext context) {
  return Theme.of(context).textTheme.displaySmall;
}

TextStyle? headlineLarge(BuildContext context) {
  return Theme.of(context).textTheme.headlineLarge;
}

TextStyle? headlineMedium(BuildContext context) {
  return Theme.of(context).textTheme.headlineMedium;
}

TextStyle? headlineSmall(BuildContext context) {
  return Theme.of(context).textTheme.headlineSmall;
}

TextStyle? titleLarge(BuildContext context) {
  return Theme.of(context).textTheme.titleLarge;
}

TextStyle? titleMedium(BuildContext context) {
  return Theme.of(context).textTheme.titleMedium;
}

TextStyle? titleSmall(BuildContext context) {
  return Theme.of(context).textTheme.titleSmall;
}

TextStyle? labelLarge(BuildContext context) {
  return Theme.of(context).textTheme.labelLarge;
}

TextStyle? labelMedium(BuildContext context) {
  return Theme.of(context).textTheme.labelMedium;
}

TextStyle? labelSmall(BuildContext context) {
  return Theme.of(context).textTheme.labelSmall;
}

TextStyle? bodyLarge(BuildContext context) {
  return Theme.of(context).textTheme.bodyLarge;
}

TextStyle? bodyMedium(BuildContext context) {
  return Theme.of(context).textTheme.bodyMedium;
}

TextStyle? bodySmall(BuildContext context) {
  return Theme.of(context).textTheme.bodySmall;
}
