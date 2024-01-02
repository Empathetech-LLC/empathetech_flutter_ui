/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../empathetech_flutter_ui.dart';

// Getters //

/// Returns the [TextTheme.displayLarge] of the current [context]
TextStyle? getDisplay(BuildContext context) {
  return Theme.of(context).textTheme.displayLarge;
}

/// Returns the [TextTheme.headlineLarge] of the current [context]
TextStyle? getHeadline(BuildContext context) {
  return Theme.of(context).textTheme.headlineLarge;
}

/// Returns the [TextTheme.titleLarge] of the current [context]
TextStyle? getTitle(BuildContext context) {
  return Theme.of(context).textTheme.titleLarge;
}

/// Returns the [TextTheme.bodyLarge] of the current [context]
TextStyle? getBody(BuildContext context) {
  return Theme.of(context).textTheme.bodyLarge;
}

/// Returns the [TextTheme.labelLarge] of the current [context]
TextStyle? getLabel(BuildContext context) {
  return Theme.of(context).textTheme.labelLarge;
}

// Setters //

/// Creates a "large" [TextTheme] with sizes from...
/// https://m3.material.io/styles/typography/type-scale-tokens
TextTheme ezTextTheme() {
  return TextTheme(
    displayLarge: buildDisplay(),
    headlineLarge: buildHeadline(),
    titleLarge: buildTitle(),
    labelLarge: buildLabel(),
    bodyLarge: buildBody(),
  );
}

/// Builds a [TextStyle] w/
/// [TextStyle.fontFamily] from [fontFamilyKey]
/// [TextStyle.fontSize] of 57
/// and [color]
TextStyle buildDisplay({Color? color}) {
  return EzTextStyle(
    fontFamily: EzConfig.get(fontFamilyKey),
    fontSize: 57,
    color: color,
  );
}

/// Builds a [TextStyle] w/
/// [TextStyle.fontFamily] from [fontFamilyKey]
/// [TextStyle.fontSize] of 32
/// and [color]
TextStyle buildHeadline({Color? color}) {
  return EzTextStyle(
    fontSize: 32,
    color: color,
    fontFamily: EzConfig.get(fontFamilyKey),
  );
}

/// Builds a [TextStyle] w/
/// [TextStyle.fontFamily] from [fontFamilyKey]
/// [TextStyle.fontSize] of 22
/// and [color]
TextStyle buildTitle({Color? color}) {
  return EzTextStyle(
    fontSize: 22,
    color: color,
    fontFamily: EzConfig.get(fontFamilyKey),
  );
}

/// For web apps, set the tab's title
void setPageTitle(String title) {
  SystemChrome.setApplicationSwitcherDescription(
    ApplicationSwitcherDescription(label: title),
  );
}

/// Builds a [TextStyle] w/
/// [TextStyle.fontFamily] from [fontFamilyKey]
/// [TextStyle.fontSize] of 16
/// and [color]
TextStyle buildBody({Color? color}) {
  return EzTextStyle(
    fontSize: 16,
    color: color,
    fontFamily: EzConfig.get(fontFamilyKey),
  );
}

/// Builds a [TextStyle] w/
/// [TextStyle.fontFamily] from [fontFamilyKey]
/// [TextStyle.fontSize] of 14
/// and [color]
TextStyle buildLabel({Color? color}) {
  return EzTextStyle(
    fontSize: 14,
    color: color,
    fontFamily: EzConfig.get(fontFamilyKey),
  );
}

// Helpers //

/// Returns whether the passed [text] follows a URL pattern
bool isUrl(String text) {
  return Uri.parse(text).host.isNotEmpty;
}

/// Returns the soon-to-be rendered size of text via a [TextPainter]
Size measureText(
  text, {
  required TextStyle? style,
  required BuildContext context,
}) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: 1,
    textScaler: MediaQuery.textScalerOf(context),
    textDirection: TextDirection.ltr,
  )..layout();

  return textPainter.size;
}
