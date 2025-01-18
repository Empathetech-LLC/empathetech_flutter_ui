// ignore_for_file: deprecated_member_use
// Color.value was deprecated without replacement, .toARGB32() should be in next stable release

/* empathetech_flutter_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
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
  IconData icon,
  BuildContext context, {
  TextStyle? style,
  double? size,
}) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: (style ?? Theme.of(context).textTheme.titleLarge)
          ?.copyWith(fontSize: size ?? EzConfig.get(iconSizeKey)),
    ),
    maxLines: 1,
    textScaler: MediaQuery.textScalerOf(context),
    textDirection: TextDirection.ltr,
  )..layout();

  return textPainter.size;
}

/// For web apps, set the tab's title
void setPageTitle(String title, Color primaryColor) =>
    SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(
        label: title,
        primaryColor: primaryColor.value,
      ),
    );

/// Returns whether the passed [text] follows a URL pattern
bool isUrl(String text) => Uri.parse(text).host.isNotEmpty;

/// Splits the string on '_' and/or ' ' and returns the first word
String firstWord(String text) => text.split(RegExp(r'[_\s]+')).first;

// Converters //

/// snake_case -> camelCase
String ezSnakeToCamel(String name) => name.replaceAllMapped(
      RegExp(r'_(\w)'),
      (Match match) => match.group(1)!.toUpperCase(),
    );

// snake_case -> ClassCase
String ezSnakeToClass(String name) =>
    ezSnakeToCamel(name).replaceRange(0, 1, name[0].toUpperCase());

/// snake_case -> Title Case
String ezSnakeToTitle(String name) => name
    .replaceAllMapped(
      RegExp(r'_(\w)'),
      (Match match) => ' ${match.group(1)!.toUpperCase()}',
    )
    .replaceRange(0, 1, name[0].toUpperCase());

/// camelCase -> snake_case
String ezCamelToSnake(String name) => name.replaceAllMapped(
      RegExp(r'[A-Z]'),
      (Match match) => '_${match.group(0)!.toLowerCase()}',
    );

/// camelCase -> ClassCase
String ezCamelToClass(String name) =>
    name.replaceRange(0, 1, name[0].toUpperCase());

/// camelCase -> Title Case
String ezCamelToTitle(String name) => name
    .replaceAllMapped(
      RegExp(r'[A-Z]'),
      (Match match) => ' ${match.group(0)!}',
    )
    .replaceRange(0, 1, name[0].toUpperCase());

/// ClassCase -> snake_case
String ezClassToSnake(String name) =>
    name.replaceRange(0, 1, name[0].toLowerCase()).replaceAllMapped(
          RegExp(r'[A-Z]'),
          (Match match) => '_${match.group(0)!.toLowerCase()}',
        );

/// ClassCase -> camelCase
String ezClassToCamel(String name) =>
    name.replaceRange(0, 1, name[0].toLowerCase());

/// ClassCase -> Title Case
String ezClassToTitle(String name) => name
    .replaceAllMapped(RegExp(r'[A-Z]'), (Match match) => ' ${match.group(0)!}')
    .trim();

/// Title Case -> snake_case
String ezTitleToSnake(String name) => name
    .replaceAllMapped(
      RegExp(r'\s(\w)'),
      (Match match) => '_${match.group(1)!.toLowerCase()}',
    )
    .replaceRange(0, 1, name[0].toLowerCase());

/// Title Case -> camelCase
String ezTitleToCamel(String name) =>
    ezTitleToClass(name).replaceRange(0, 1, name[0].toLowerCase());

/// Title Case -> ClassCase
String ezTitleToClass(String name) => name.replaceAll(RegExp(r'\s'), '');

// Getters //

/// [TextTheme.headlineLarge] w/ the [TextStyle.fontSize] of [TextTheme.titleLarge]
TextStyle? subHeadingStyle(TextTheme textTheme) =>
    textTheme.headlineLarge?.copyWith(fontSize: textTheme.titleLarge?.fontSize);

/// [TextTheme.bodyLarge] w/ the [TextStyle.fontSize] of [TextTheme.titleLarge]
TextStyle? subTitleStyle(TextTheme textTheme) =>
    textTheme.bodyLarge?.copyWith(fontSize: textTheme.titleLarge?.fontSize);

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
    fontWeight: EzConfig.get(displayBoldedKey) == true
        ? FontWeight.bold
        : FontWeight.normal,
    fontStyle:
        EzConfig.get(displayItalicizedKey) == true ? FontStyle.italic : null,
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
    fontWeight: EzConfig.getDefault(displayBoldedKey) == true
        ? FontWeight.bold
        : FontWeight.normal,
    fontStyle: EzConfig.getDefault(displayItalicizedKey) == true
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
    fontWeight: EzConfig.get(headlineBoldedKey) == true
        ? FontWeight.bold
        : FontWeight.normal,
    fontStyle:
        EzConfig.get(headlineItalicizedKey) == true ? FontStyle.italic : null,
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
    fontWeight: EzConfig.getDefault(headlineBoldedKey) == true
        ? FontWeight.bold
        : FontWeight.normal,
    fontStyle: EzConfig.getDefault(headlineItalicizedKey) == true
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
    fontWeight: EzConfig.get(titleBoldedKey) == true
        ? FontWeight.bold
        : FontWeight.normal,
    fontStyle:
        EzConfig.get(titleItalicizedKey) == true ? FontStyle.italic : null,
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
    fontWeight: EzConfig.getDefault(titleBoldedKey) == true
        ? FontWeight.bold
        : FontWeight.normal,
    fontStyle: EzConfig.getDefault(titleItalicizedKey) == true
        ? FontStyle.italic
        : null,
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
    fontWeight: EzConfig.get(bodyBoldedKey) == true
        ? FontWeight.bold
        : FontWeight.normal,
    fontStyle:
        EzConfig.get(bodyItalicizedKey) == true ? FontStyle.italic : null,
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
    fontWeight: EzConfig.getDefault(bodyBoldedKey) == true
        ? FontWeight.bold
        : FontWeight.normal,
    fontStyle: EzConfig.getDefault(bodyItalicizedKey) == true
        ? FontStyle.italic
        : null,
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
    fontWeight: EzConfig.get(labelBoldedKey) == true
        ? FontWeight.bold
        : FontWeight.normal,
    fontStyle:
        EzConfig.get(labelItalicizedKey) == true ? FontStyle.italic : null,
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
    fontWeight: EzConfig.getDefault(labelBoldedKey) == true
        ? FontWeight.bold
        : FontWeight.normal,
    fontStyle: EzConfig.getDefault(labelItalicizedKey) == true
        ? FontStyle.italic
        : null,
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
