/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Helpers //

/// Returns the soon-to-be rendered size of [text] via a [TextPainter]
Size measureText(
  String text, {
  required BuildContext context,
  required TextStyle? style,
}) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: 1,
    textScaler: MediaQuery.textScalerOf(context),
    textDirection: TextDirection.ltr,
  )..layout();

  return textPainter.size;
}

/// Returns the soon-to-be rendered size of an [icon] via a [TextPainter]
Size measureIcon(
  IconData icon, {
  required BuildContext context,
  required TextStyle? style,
}) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: String.fromCharCode(icon.codePoint), style: style),
    maxLines: 1,
    textScaler: MediaQuery.textScalerOf(context),
    textDirection: TextDirection.ltr,
  )..layout();

  return textPainter.size;
}

/// For web apps, set the tab's title
void setPageTitle(String title, Color primaryColor) {
  SystemChrome.setApplicationSwitcherDescription(
    ApplicationSwitcherDescription(
      label: title,
      primaryColor: primaryColor.value,
    ),
  );
}

/// Returns whether the passed [text] follows a URL pattern
bool isUrl(String text) {
  return Uri.parse(text).host.isNotEmpty;
}

/// Splits the string on '_' and/or ' ' and returns the first word
String firstWord(String text) {
  return text.split(RegExp(r'[_\s]+')).first;
}

// Setters //

/// Creates a [TextTheme] with sizes from...
/// https://m3.material.io/styles/typography/type-scale-tokens
/// Each variant triplet (large, medium, small) are the same size: large
TextTheme ezTextTheme(Color? color) {
  final TextStyle display = buildDisplay(color);
  final TextStyle headline = buildHeadline(color);
  final TextStyle title = buildTitle(color);
  final TextStyle body = buildBody(color);
  final TextStyle label = buildLabel(color);

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
TextStyle buildDisplay(Color? color) {
  final TextStyle starter = TextStyle(
    fontSize: EzConfig.get(displayFontSizeKey),
    fontWeight: EzConfig.get(displayBoldKey) == true
        ? FontWeight.bold
        : FontWeight.normal,
    fontStyle:
        EzConfig.get(displayItalicsKey) == true ? FontStyle.italic : null,
    decoration: EzConfig.get(displayUnderlinedKey) == true
        ? TextDecoration.underline
        : null,
    color: color,
    height: EzConfig.get(displayFontHeightKey),
    leadingDistribution: TextLeadingDistribution.even,
    letterSpacing: EzConfig.get(displayLetterSpacingKey),
    wordSpacing: EzConfig.get(displayWordSpacingKey),
  );

  return fuseWithGFont(
    starter: starter,
    gFont: EzConfig.get(displayFontFamilyKey),
  );
}

/// Builds [TextTheme.displayLarge] w/ values from [EzConfig.defaults]
TextStyle buildDisplayFromDefaults(Color? color) {
  final TextStyle starter = TextStyle(
    fontSize: EzConfig.getDefault(displayFontSizeKey),
    fontWeight: EzConfig.getDefault(displayBoldKey) == true
        ? FontWeight.bold
        : FontWeight.normal,
    fontStyle: EzConfig.getDefault(displayItalicsKey) == true
        ? FontStyle.italic
        : null,
    decoration: EzConfig.getDefault(displayUnderlinedKey) == true
        ? TextDecoration.underline
        : null,
    color: color,
    height: EzConfig.getDefault(displayFontHeightKey),
    leadingDistribution: TextLeadingDistribution.even,
    letterSpacing: EzConfig.getDefault(displayLetterSpacingKey),
    wordSpacing: EzConfig.getDefault(displayWordSpacingKey),
  );

  return fuseWithGFont(
    starter: starter,
    gFont: EzConfig.getDefault(displayFontFamilyKey),
  );
}

/// Builds [TextTheme.headlineLarge] w/ values from [EzConfig]
TextStyle buildHeadline(Color? color) {
  final TextStyle starter = TextStyle(
    fontSize: EzConfig.get(headlineFontSizeKey),
    fontWeight: EzConfig.get(headlineBoldKey) == true
        ? FontWeight.bold
        : FontWeight.normal,
    fontStyle:
        EzConfig.get(headlineItalicsKey) == true ? FontStyle.italic : null,
    decoration: EzConfig.get(headlineUnderlinedKey) == true
        ? TextDecoration.underline
        : null,
    color: color,
    height: EzConfig.get(headlineFontHeightKey),
    leadingDistribution: TextLeadingDistribution.even,
    letterSpacing: EzConfig.get(headlineLetterSpacingKey),
    wordSpacing: EzConfig.get(headlineWordSpacingKey),
  );

  return fuseWithGFont(
    starter: starter,
    gFont: EzConfig.get(headlineFontFamilyKey),
  );
}

/// Builds [TextTheme.headlineLarge] w/ values from [EzConfig.defaults]
TextStyle buildHeadlineFromDefaults(Color? color) {
  final TextStyle starter = TextStyle(
    fontSize: EzConfig.getDefault(headlineFontSizeKey),
    fontWeight: EzConfig.getDefault(headlineBoldKey) == true
        ? FontWeight.bold
        : FontWeight.normal,
    fontStyle: EzConfig.getDefault(headlineItalicsKey) == true
        ? FontStyle.italic
        : null,
    decoration: EzConfig.getDefault(headlineUnderlinedKey) == true
        ? TextDecoration.underline
        : null,
    color: color,
    height: EzConfig.getDefault(headlineFontHeightKey),
    leadingDistribution: TextLeadingDistribution.even,
    letterSpacing: EzConfig.getDefault(headlineLetterSpacingKey),
    wordSpacing: EzConfig.getDefault(headlineWordSpacingKey),
  );

  return fuseWithGFont(
    starter: starter,
    gFont: EzConfig.getDefault(headlineFontFamilyKey),
  );
}

/// Builds [TextTheme.titleLarge] w/ values from [EzConfig]
TextStyle buildTitle(Color? color) {
  final TextStyle starter = TextStyle(
    fontSize: EzConfig.get(titleFontSizeKey),
    fontWeight: EzConfig.get(titleBoldKey) == true
        ? FontWeight.bold
        : FontWeight.normal,
    fontStyle: EzConfig.get(titleItalicsKey) == true ? FontStyle.italic : null,
    decoration: EzConfig.get(titleUnderlinedKey) == true
        ? TextDecoration.underline
        : null,
    color: color,
    height: EzConfig.get(titleFontHeightKey),
    leadingDistribution: TextLeadingDistribution.even,
    letterSpacing: EzConfig.get(titleLetterSpacingKey),
    wordSpacing: EzConfig.get(titleWordSpacingKey),
  );

  return fuseWithGFont(
    starter: starter,
    gFont: EzConfig.get(titleFontFamilyKey),
  );
}

/// Builds [TextTheme.titleLarge] w/ values from [EzConfig.defaults]
TextStyle buildTitleFromDefaults(Color? color) {
  final TextStyle starter = TextStyle(
    fontSize: EzConfig.getDefault(titleFontSizeKey),
    fontWeight: EzConfig.getDefault(titleBoldKey) == true
        ? FontWeight.bold
        : FontWeight.normal,
    fontStyle:
        EzConfig.getDefault(titleItalicsKey) == true ? FontStyle.italic : null,
    decoration: EzConfig.getDefault(titleUnderlinedKey) == true
        ? TextDecoration.underline
        : null,
    color: color,
    height: EzConfig.getDefault(titleFontHeightKey),
    leadingDistribution: TextLeadingDistribution.even,
    letterSpacing: EzConfig.getDefault(titleLetterSpacingKey),
    wordSpacing: EzConfig.getDefault(titleWordSpacingKey),
  );

  return fuseWithGFont(
    starter: starter,
    gFont: EzConfig.getDefault(titleFontFamilyKey),
  );
}

/// Builds [TextTheme.bodyLarge] w/ values from [EzConfig]
TextStyle buildBody(Color? color) {
  final TextStyle starter = TextStyle(
    fontSize: EzConfig.get(bodyFontSizeKey),
    fontWeight:
        EzConfig.get(bodyBoldKey) == true ? FontWeight.bold : FontWeight.normal,
    fontStyle: EzConfig.get(bodyItalicsKey) == true ? FontStyle.italic : null,
    decoration: EzConfig.get(bodyUnderlinedKey) == true
        ? TextDecoration.underline
        : null,
    color: color,
    height: EzConfig.get(bodyFontHeightKey),
    leadingDistribution: TextLeadingDistribution.even,
    letterSpacing: EzConfig.get(bodyLetterSpacingKey),
    wordSpacing: EzConfig.get(bodyWordSpacingKey),
  );

  return fuseWithGFont(
    starter: starter,
    gFont: EzConfig.get(bodyFontFamilyKey),
  );
}

/// Builds [TextTheme.bodyLarge] w/ values from [EzConfig.defaults]
TextStyle buildBodyFromDefaults(Color? color) {
  final TextStyle starter = TextStyle(
    fontSize: EzConfig.getDefault(bodyFontSizeKey),
    fontWeight: EzConfig.getDefault(bodyBoldKey) == true
        ? FontWeight.bold
        : FontWeight.normal,
    fontStyle:
        EzConfig.getDefault(bodyItalicsKey) == true ? FontStyle.italic : null,
    decoration: EzConfig.getDefault(bodyUnderlinedKey) == true
        ? TextDecoration.underline
        : null,
    color: color,
    height: EzConfig.getDefault(bodyFontHeightKey),
    leadingDistribution: TextLeadingDistribution.even,
    letterSpacing: EzConfig.getDefault(bodyLetterSpacingKey),
    wordSpacing: EzConfig.getDefault(bodyWordSpacingKey),
  );

  return fuseWithGFont(
    starter: starter,
    gFont: EzConfig.getDefault(bodyFontFamilyKey),
  );
}

/// Builds [TextTheme.labelLarge] w/ values from [EzConfig]
TextStyle buildLabel(Color? color) {
  final TextStyle starter = TextStyle(
    fontSize: EzConfig.get(labelFontSizeKey),
    fontWeight: EzConfig.get(labelBoldKey) == true
        ? FontWeight.bold
        : FontWeight.normal,
    fontStyle: EzConfig.get(labelItalicsKey) == true ? FontStyle.italic : null,
    decoration: EzConfig.get(labelUnderlinedKey) == true
        ? TextDecoration.underline
        : null,
    color: color,
    height: EzConfig.get(labelFontHeightKey),
    leadingDistribution: TextLeadingDistribution.even,
    letterSpacing: EzConfig.get(labelLetterSpacingKey),
    wordSpacing: EzConfig.get(labelWordSpacingKey),
  );

  return fuseWithGFont(
    starter: starter,
    gFont: EzConfig.get(labelFontFamilyKey),
  );
}

/// Builds [TextTheme.labelLarge] w/ values from [EzConfig.defaults]
TextStyle buildLabelFromDefaults(Color? color) {
  final TextStyle starter = TextStyle(
    fontSize: EzConfig.getDefault(labelFontSizeKey),
    fontWeight: EzConfig.getDefault(labelBoldKey) == true
        ? FontWeight.bold
        : FontWeight.normal,
    fontStyle:
        EzConfig.getDefault(labelItalicsKey) == true ? FontStyle.italic : null,
    decoration: EzConfig.getDefault(labelUnderlinedKey) == true
        ? TextDecoration.underline
        : null,
    color: color,
    height: EzConfig.getDefault(labelFontHeightKey),
    leadingDistribution: TextLeadingDistribution.even,
    letterSpacing: EzConfig.getDefault(labelLetterSpacingKey),
    wordSpacing: EzConfig.getDefault(labelWordSpacingKey),
  );

  return fuseWithGFont(
    starter: starter,
    gFont: EzConfig.getDefault(labelFontFamilyKey),
  );
}
