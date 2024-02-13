/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
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

/// Builds [TextTheme.displayLarge] w/ values from [EzConfig]
TextStyle buildDisplay({Color? color}) {
  return EzTextStyle(
    fontFamily: EzConfig.get(displayFontFamilyKey),
    fontSize: EzConfig.get(displayFontSizeKey),
    fontWeight: EzConfig.get(displayFontWeightKey),
    fontStyle: EzConfig.get(displayFontStyleKey),
    letterSpacing: EzConfig.get(displayLetterSpacingKey),
    wordSpacing: EzConfig.get(displayWordSpacingKey),
    height: EzConfig.get(displayFontHeightKey),
    decoration: EzConfig.get(displayFontDecorationKey),
    color: color,
  );
}

/// Builds [TextTheme.headlineLarge] w/ values from [EzConfig]
TextStyle buildHeadline({Color? color}) {
  return EzTextStyle(
    fontFamily: EzConfig.get(headlineFontFamilyKey),
    fontSize: EzConfig.get(headlineFontSizeKey),
    fontWeight: EzConfig.get(headlineFontWeightKey),
    fontStyle: EzConfig.get(headlineFontStyleKey),
    letterSpacing: EzConfig.get(headlineLetterSpacingKey),
    wordSpacing: EzConfig.get(headlineWordSpacingKey),
    height: EzConfig.get(headlineFontHeightKey),
    decoration: EzConfig.get(headlineFontDecorationKey),
    color: color,
  );
}

/// Builds [TextTheme.titleLarge] w/ values from [EzConfig]
TextStyle buildTitle({Color? color}) {
  return EzTextStyle(
    fontFamily: EzConfig.get(titleFontFamilyKey),
    fontSize: EzConfig.get(titleFontSizeKey),
    fontWeight: EzConfig.get(titleFontWeightKey),
    fontStyle: EzConfig.get(titleFontStyleKey),
    letterSpacing: EzConfig.get(titleLetterSpacingKey),
    wordSpacing: EzConfig.get(titleWordSpacingKey),
    height: EzConfig.get(titleFontHeightKey),
    decoration: EzConfig.get(titleFontDecorationKey),
    color: color,
  );
}

/// Builds [TextTheme.bodyLarge] w/ values from [EzConfig]
TextStyle buildBody({Color? color}) {
  return EzTextStyle(
    fontFamily: EzConfig.get(bodyFontFamilyKey),
    fontSize: EzConfig.get(bodyFontSizeKey),
    fontWeight: EzConfig.get(bodyFontWeightKey),
    fontStyle: EzConfig.get(bodyFontStyleKey),
    letterSpacing: EzConfig.get(bodyLetterSpacingKey),
    wordSpacing: EzConfig.get(bodyWordSpacingKey),
    height: EzConfig.get(bodyFontHeightKey),
    decoration: EzConfig.get(bodyFontDecorationKey),
    color: color,
  );
}

/// Builds [TextTheme.labelLarge] w/ values from [EzConfig]
TextStyle buildLabel({Color? color}) {
  return EzTextStyle(
    fontFamily: EzConfig.get(labelFontFamilyKey),
    fontSize: EzConfig.get(labelFontSizeKey),
    fontWeight: EzConfig.get(labelFontWeightKey),
    fontStyle: EzConfig.get(labelFontStyleKey),
    letterSpacing: EzConfig.get(labelLetterSpacingKey),
    wordSpacing: EzConfig.get(labelWordSpacingKey),
    height: EzConfig.get(labelFontHeightKey),
    decoration: EzConfig.get(labelFontDecorationKey),
    color: color,
  );
}

/// For web apps, set the tab's title
void setPageTitle(String title) {
  SystemChrome.setApplicationSwitcherDescription(
    ApplicationSwitcherDescription(label: title),
  );
}

// Helpers //

/// Returns whether the passed [text] follows a URL pattern
bool isUrl(String text) {
  return Uri.parse(text).host.isNotEmpty;
}

/// Returns the soon-to-be rendered size of text via a [TextPainter]
Size measureText(
  String text, {
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
