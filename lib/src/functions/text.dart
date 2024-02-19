/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../empathetech_flutter_ui.dart';

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

// Getters //

/// Returns the [FontWeight] from the passed [name]
/// [thinWeight], [normalWeight], && [boldWeight]
FontWeight weightFromName(String name) {
  switch (name) {
    case thinWeight:
      return FontWeight.w100;
    case boldWeight:
      return FontWeight.w700;
    case normalWeight:
    default:
      return FontWeight.w400;
  }
}

/// Returns the [FontStyle] from the passed [name]
/// [italicStyle] && [normalStyle]
FontStyle styleFromName(String name) {
  switch (name) {
    case italicStyle:
      return FontStyle.italic;
    case normalStyle:
    default:
      return FontStyle.normal;
  }
}

/// Returns the [TextDecoration] from the passed [name]
/// [underlineDecoration], && [noDecoration]
TextDecoration decorationFromName(String name) {
  switch (name) {
    case underlineDecoration:
      return TextDecoration.underline;
    case noDecoration:
    default:
      return TextDecoration.none;
  }
}

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

/// Creates a [TextTheme] with sizes from...
/// https://m3.material.io/styles/typography/type-scale-tokens
/// Each variant triplet (large, medium, small) are the same size: large
TextTheme ezTextTheme() {
  final TextStyle display = buildDisplay();
  final TextStyle headline = buildHeadline();
  final TextStyle title = buildTitle();
  final TextStyle body = buildBody();
  final TextStyle label = buildLabel();

  return TextTheme(
    displayLarge: display,
    displayMedium: display,
    displaySmall: display,
    headlineLarge: headline,
    headlineMedium: headline,
    headlineSmall: headline,
    titleLarge: title,
    titleMedium: title,
    titleSmall: title,
    bodyLarge: body,
    bodyMedium: body,
    bodySmall: body,
    labelLarge: label,
    labelMedium: label,
    labelSmall: label,
  );
}

/// Builds [TextTheme.displayLarge] w/ values from [EzConfig]
TextStyle buildDisplay() {
  final TextStyle starter = TextStyle(
    fontSize: EzConfig.get(displayFontSizeKey),
    fontWeight: weightFromName(EzConfig.get(displayFontWeightKey)),
    fontStyle: styleFromName(EzConfig.get(displayFontStyleKey)),
    letterSpacing: EzConfig.get(displayLetterSpacingKey),
    wordSpacing: EzConfig.get(displayWordSpacingKey),
    height: EzConfig.get(displayFontHeightKey),
    decoration: decorationFromName(EzConfig.get(displayFontDecorationKey)),
  );

  return fuseWithGFont(
    starter: starter,
    gFont: EzConfig.get(displayFontFamilyKey),
  );
}

/// Builds [TextTheme.headlineLarge] w/ values from [EzConfig]
TextStyle buildHeadline({Color? color}) {
  final TextStyle starter = TextStyle(
    fontSize: EzConfig.get(headlineFontSizeKey),
    fontWeight: weightFromName(EzConfig.get(headlineFontWeightKey)),
    fontStyle: styleFromName(EzConfig.get(headlineFontStyleKey)),
    letterSpacing: EzConfig.get(headlineLetterSpacingKey),
    wordSpacing: EzConfig.get(headlineWordSpacingKey),
    height: EzConfig.get(headlineFontHeightKey),
    decoration: decorationFromName(EzConfig.get(headlineFontDecorationKey)),
    color: color,
  );

  return fuseWithGFont(
    starter: starter,
    gFont: EzConfig.get(headlineFontFamilyKey),
  );
}

/// Builds [TextTheme.titleLarge] w/ values from [EzConfig]
TextStyle buildTitle({Color? color}) {
  final TextStyle starter = TextStyle(
    fontSize: EzConfig.get(titleFontSizeKey),
    fontWeight: weightFromName(EzConfig.get(titleFontWeightKey)),
    fontStyle: styleFromName(EzConfig.get(titleFontStyleKey)),
    letterSpacing: EzConfig.get(titleLetterSpacingKey),
    wordSpacing: EzConfig.get(titleWordSpacingKey),
    height: EzConfig.get(titleFontHeightKey),
    decoration: decorationFromName(EzConfig.get(titleFontDecorationKey)),
    color: color,
  );

  return fuseWithGFont(
    starter: starter,
    gFont: EzConfig.get(titleFontFamilyKey),
  );
}

/// Builds [TextTheme.bodyLarge] w/ values from [EzConfig]
TextStyle buildBody({Color? color}) {
  final TextStyle starter = TextStyle(
    fontSize: EzConfig.get(bodyFontSizeKey),
    fontWeight: weightFromName(EzConfig.get(bodyFontWeightKey)),
    fontStyle: styleFromName(EzConfig.get(bodyFontStyleKey)),
    letterSpacing: EzConfig.get(bodyLetterSpacingKey),
    wordSpacing: EzConfig.get(bodyWordSpacingKey),
    height: EzConfig.get(bodyFontHeightKey),
    decoration: decorationFromName(EzConfig.get(bodyFontDecorationKey)),
    color: color,
  );

  return fuseWithGFont(
    starter: starter,
    gFont: EzConfig.get(bodyFontFamilyKey),
  );
}

/// Builds [TextTheme.labelLarge] w/ values from [EzConfig]
TextStyle buildLabel({Color? color}) {
  final TextStyle starter = TextStyle(
    fontSize: EzConfig.get(labelFontSizeKey),
    fontWeight: weightFromName(EzConfig.get(labelFontWeightKey)),
    fontStyle: styleFromName(EzConfig.get(labelFontStyleKey)),
    letterSpacing: EzConfig.get(labelLetterSpacingKey),
    wordSpacing: EzConfig.get(labelWordSpacingKey),
    height: EzConfig.get(labelFontHeightKey),
    decoration: decorationFromName(EzConfig.get(labelFontDecorationKey)),
    color: color,
  );

  return fuseWithGFont(
    starter: starter,
    gFont: EzConfig.get(labelFontFamilyKey),
  );
}

/// For web apps, set the tab's title
void setPageTitle(String title) {
  SystemChrome.setApplicationSwitcherDescription(
    ApplicationSwitcherDescription(label: title),
  );
}
