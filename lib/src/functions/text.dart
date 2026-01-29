/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Helpers //

/// 404 [EzConfig.l10n].gError}
String ez404() => '404 ${EzConfig.l10n.gError}';

/// Returns the soon-to-be rendered [Size] of [text] via a [TextPainter]
Size ezTextSize(
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

/// [SystemChrome.setApplicationSwitcherDescription] wrapper
/// Sets the title of the tab on web and the title of the window on desktop
void ezWindowNamer(String title) =>
    SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(
        label: title,
        primaryColor: EzConfig.colors.primary.toARGB32(),
      ),
    );

/// Returns whether the passed [text] follows a URL pattern
bool ezUrlCheck(String text) => Uri.parse(text).host.isNotEmpty;

/// Splits the string on '_' and/or ' ' and returns the first word
String ezFirstWord(String text) => text.split(RegExp(r'[_\s]+')).first;

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
TextStyle? ezSubHeadingStyle() => EzConfig.styles.headlineLarge
    ?.copyWith(fontSize: EzConfig.styles.titleLarge?.fontSize);

/// [TextTheme.bodyLarge] w/ the [TextStyle.fontSize] of [TextTheme.titleLarge]
TextStyle? ezSubTitleStyle() => EzConfig.styles.bodyLarge
    ?.copyWith(fontSize: EzConfig.styles.titleLarge?.fontSize);

// Setters //

/// Creates a [TextTheme] with sizes inspired by...
/// https://m3.material.io/styles/typography/type-scale-tokens
/// Each variant triplet (large, medium, small) are identical
/// 15 different options would be overload for users... 5 makes much more sense
TextTheme ezTextTheme(Color? color, {bool? isDark}) {
  final TextStyle display = ezDisplayStyle(color, isDark: isDark);
  final TextStyle headline = ezHeadlineStyle(color, isDark: isDark);
  final TextStyle title = ezTitleStyle(color, isDark: isDark);
  final TextStyle body = ezBodyStyle(color, isDark: isDark);
  final TextStyle label = ezLabelStyle(color, isDark: isDark);

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
/// Provide [isDark] if you are calling this before [EzConfig.initProvider]
TextStyle ezDisplayStyle(Color? color, {bool? isDark}) {
  final bool useDark = isDark ?? EzConfig.isDark;
  final TextStyle starter = useDark
      ? TextStyle(
          fontSize: EzConfig.get(darkDisplayFontSizeKey),
          fontWeight: EzConfig.get(darkDisplayBoldedKey) == true
              ? FontWeight.bold
              : FontWeight.normal,
          fontStyle: EzConfig.get(darkDisplayItalicizedKey) == true
              ? FontStyle.italic
              : null,
          decoration: EzConfig.get(darkDisplayUnderlinedKey) == true
              ? TextDecoration.underline
              : null,
          color: color,
          height: EzConfig.get(darkDisplayFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzConfig.get(darkDisplayLetterSpacingKey),
          wordSpacing: EzConfig.get(darkDisplayWordSpacingKey),
        )
      : TextStyle(
          fontSize: EzConfig.get(lightDisplayFontSizeKey),
          fontWeight: EzConfig.get(lightDisplayBoldedKey) == true
              ? FontWeight.bold
              : FontWeight.normal,
          fontStyle: EzConfig.get(lightDisplayItalicizedKey) == true
              ? FontStyle.italic
              : null,
          decoration: EzConfig.get(lightDisplayUnderlinedKey) == true
              ? TextDecoration.underline
              : null,
          color: color,
          height: EzConfig.get(lightDisplayFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzConfig.get(lightDisplayLetterSpacingKey),
          wordSpacing: EzConfig.get(lightDisplayWordSpacingKey),
        );

  return fuseWithGFont(
    starter: starter,
    gFont: EzConfig.get(
        useDark ? darkDisplayFontFamilyKey : lightDisplayFontFamilyKey),
  );
}

/// Builds [TextTheme.displayLarge] w/ values from [EzConfig]
/// Provide [isDark] if you are calling this before [EzConfig.initProvider]
TextStyle ezDefaultDisplayStyle(Color? color, {bool? isDark}) {
  final bool useDark = isDark ?? EzConfig.isDark;
  final TextStyle starter = useDark
      ? TextStyle(
          fontSize: EzConfig.getDefault(darkDisplayFontSizeKey),
          fontWeight: EzConfig.getDefault(darkDisplayBoldedKey) == true
              ? FontWeight.bold
              : FontWeight.normal,
          fontStyle: EzConfig.getDefault(darkDisplayItalicizedKey) == true
              ? FontStyle.italic
              : null,
          decoration: EzConfig.getDefault(darkDisplayUnderlinedKey) == true
              ? TextDecoration.underline
              : null,
          color: color,
          height: EzConfig.getDefault(darkDisplayFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzConfig.getDefault(darkDisplayLetterSpacingKey),
          wordSpacing: EzConfig.getDefault(darkDisplayWordSpacingKey),
        )
      : TextStyle(
          fontSize: EzConfig.getDefault(lightDisplayFontSizeKey),
          fontWeight: EzConfig.getDefault(lightDisplayBoldedKey) == true
              ? FontWeight.bold
              : FontWeight.normal,
          fontStyle: EzConfig.getDefault(lightDisplayItalicizedKey) == true
              ? FontStyle.italic
              : null,
          decoration: EzConfig.getDefault(lightDisplayUnderlinedKey) == true
              ? TextDecoration.underline
              : null,
          color: color,
          height: EzConfig.getDefault(lightDisplayFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzConfig.getDefault(lightDisplayLetterSpacingKey),
          wordSpacing: EzConfig.getDefault(lightDisplayWordSpacingKey),
        );

  return fuseWithGFont(
    starter: starter,
    gFont: EzConfig.getDefault(
        useDark ? darkDisplayFontFamilyKey : lightDisplayFontFamilyKey),
  );
}

/// Builds [TextTheme.headlineLarge] w/ values from [EzConfig.prefs]
/// Provide [isDark] if you are calling this before [EzConfig.initProvider]
TextStyle ezHeadlineStyle(Color? color, {bool? isDark}) {
  final bool useDark = isDark ?? EzConfig.isDark;
  final TextStyle starter = useDark
      ? TextStyle(
          fontSize: EzConfig.get(darkHeadlineFontSizeKey),
          fontWeight: EzConfig.get(darkHeadlineBoldedKey) == true
              ? FontWeight.bold
              : FontWeight.normal,
          fontStyle: EzConfig.get(darkHeadlineItalicizedKey) == true
              ? FontStyle.italic
              : null,
          decoration: EzConfig.get(darkHeadlineUnderlinedKey) == true
              ? TextDecoration.underline
              : null,
          color: color,
          height: EzConfig.get(darkHeadlineFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzConfig.get(darkHeadlineLetterSpacingKey),
          wordSpacing: EzConfig.get(darkHeadlineWordSpacingKey),
        )
      : TextStyle(
          fontSize: EzConfig.get(lightHeadlineFontSizeKey),
          fontWeight: EzConfig.get(lightHeadlineBoldedKey) == true
              ? FontWeight.bold
              : FontWeight.normal,
          fontStyle: EzConfig.get(lightHeadlineItalicizedKey) == true
              ? FontStyle.italic
              : null,
          decoration: EzConfig.get(lightHeadlineUnderlinedKey) == true
              ? TextDecoration.underline
              : null,
          color: color,
          height: EzConfig.get(lightHeadlineFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzConfig.get(lightHeadlineLetterSpacingKey),
          wordSpacing: EzConfig.get(lightHeadlineWordSpacingKey),
        );

  return fuseWithGFont(
    starter: starter,
    gFont: EzConfig.get(
        useDark ? darkHeadlineFontFamilyKey : lightHeadlineFontFamilyKey),
  );
}

/// Builds [TextTheme.headlineLarge] w/ values from [EzConfig.defaults]
/// Provide [isDark] if you are calling this before [EzConfig.initProvider]
TextStyle ezDefaultHeadlineStyle(Color? color, {bool? isDark}) {
  final bool useDark = isDark ?? EzConfig.isDark;
  final TextStyle starter = useDark
      ? TextStyle(
          fontSize: EzConfig.getDefault(darkHeadlineFontSizeKey),
          fontWeight: EzConfig.getDefault(darkHeadlineBoldedKey) == true
              ? FontWeight.bold
              : FontWeight.normal,
          fontStyle: EzConfig.getDefault(darkHeadlineItalicizedKey) == true
              ? FontStyle.italic
              : null,
          decoration: EzConfig.getDefault(darkHeadlineUnderlinedKey) == true
              ? TextDecoration.underline
              : null,
          color: color,
          height: EzConfig.getDefault(darkHeadlineFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzConfig.getDefault(darkHeadlineLetterSpacingKey),
          wordSpacing: EzConfig.getDefault(darkHeadlineWordSpacingKey),
        )
      : TextStyle(
          fontSize: EzConfig.getDefault(lightHeadlineFontSizeKey),
          fontWeight: EzConfig.getDefault(lightHeadlineBoldedKey) == true
              ? FontWeight.bold
              : FontWeight.normal,
          fontStyle: EzConfig.getDefault(lightHeadlineItalicizedKey) == true
              ? FontStyle.italic
              : null,
          decoration: EzConfig.getDefault(lightHeadlineUnderlinedKey) == true
              ? TextDecoration.underline
              : null,
          color: color,
          height: EzConfig.getDefault(lightHeadlineFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzConfig.getDefault(lightHeadlineLetterSpacingKey),
          wordSpacing: EzConfig.getDefault(lightHeadlineWordSpacingKey),
        );

  return fuseWithGFont(
    starter: starter,
    gFont: EzConfig.getDefault(
        useDark ? darkHeadlineFontFamilyKey : lightHeadlineFontFamilyKey),
  );
}

/// Builds [TextTheme.titleLarge] w/ values from [EzConfig.prefs]
/// Provide [isDark] if you are calling this before [EzConfig.initProvider]
TextStyle ezTitleStyle(Color? color, {bool? isDark}) {
  final bool useDark = isDark ?? EzConfig.isDark;
  final TextStyle starter = useDark
      ? TextStyle(
          fontSize: EzConfig.get(darkTitleFontSizeKey),
          fontWeight: EzConfig.get(darkTitleBoldedKey) == true
              ? FontWeight.bold
              : FontWeight.normal,
          fontStyle: EzConfig.get(darkTitleItalicizedKey) == true
              ? FontStyle.italic
              : null,
          decoration: EzConfig.get(darkTitleUnderlinedKey) == true
              ? TextDecoration.underline
              : null,
          color: color,
          height: EzConfig.get(darkTitleFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzConfig.get(darkTitleLetterSpacingKey),
          wordSpacing: EzConfig.get(darkTitleWordSpacingKey),
        )
      : TextStyle(
          fontSize: EzConfig.get(lightTitleFontSizeKey),
          fontWeight: EzConfig.get(lightTitleBoldedKey) == true
              ? FontWeight.bold
              : FontWeight.normal,
          fontStyle: EzConfig.get(lightTitleItalicizedKey) == true
              ? FontStyle.italic
              : null,
          decoration: EzConfig.get(lightTitleUnderlinedKey) == true
              ? TextDecoration.underline
              : null,
          color: color,
          height: EzConfig.get(lightTitleFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzConfig.get(lightTitleLetterSpacingKey),
          wordSpacing: EzConfig.get(lightTitleWordSpacingKey),
        );

  return fuseWithGFont(
    starter: starter,
    gFont: EzConfig.get(
        useDark ? darkTitleFontFamilyKey : lightTitleFontFamilyKey),
  );
}

/// Builds [TextTheme.titleLarge] w/ values from [EzConfig.defaults]
/// Provide [isDark] if you are calling this before [EzConfig.initProvider]
TextStyle ezDefaultTitleStyle(Color? color, {bool? isDark}) {
  final bool useDark = isDark ?? EzConfig.isDark;
  final TextStyle starter = useDark
      ? TextStyle(
          fontSize: EzConfig.getDefault(darkTitleFontSizeKey),
          fontWeight: EzConfig.getDefault(darkTitleBoldedKey) == true
              ? FontWeight.bold
              : FontWeight.normal,
          fontStyle: EzConfig.getDefault(darkTitleItalicizedKey) == true
              ? FontStyle.italic
              : null,
          decoration: EzConfig.getDefault(darkTitleUnderlinedKey) == true
              ? TextDecoration.underline
              : null,
          color: color,
          height: EzConfig.getDefault(darkTitleFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzConfig.getDefault(darkTitleLetterSpacingKey),
          wordSpacing: EzConfig.getDefault(darkTitleWordSpacingKey),
        )
      : TextStyle(
          fontSize: EzConfig.getDefault(lightTitleFontSizeKey),
          fontWeight: EzConfig.getDefault(lightTitleBoldedKey) == true
              ? FontWeight.bold
              : FontWeight.normal,
          fontStyle: EzConfig.getDefault(lightTitleItalicizedKey) == true
              ? FontStyle.italic
              : null,
          decoration: EzConfig.getDefault(lightTitleUnderlinedKey) == true
              ? TextDecoration.underline
              : null,
          color: color,
          height: EzConfig.getDefault(lightTitleFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzConfig.getDefault(lightTitleLetterSpacingKey),
          wordSpacing: EzConfig.getDefault(lightTitleWordSpacingKey),
        );

  return fuseWithGFont(
    starter: starter,
    gFont: EzConfig.getDefault(
        useDark ? darkTitleFontFamilyKey : lightTitleFontFamilyKey),
  );
}

/// Builds [TextTheme.bodyLarge] w/ values from [EzConfig.prefs]
/// Provide [isDark] if you are calling this before [EzConfig.initProvider]
TextStyle ezBodyStyle(Color? color, {bool? isDark}) {
  final bool useDark = isDark ?? EzConfig.isDark;
  final TextStyle starter = useDark
      ? TextStyle(
          fontSize: EzConfig.get(darkBodyFontSizeKey),
          fontWeight: EzConfig.get(darkBodyBoldedKey) == true
              ? FontWeight.bold
              : FontWeight.normal,
          fontStyle: EzConfig.get(darkBodyItalicizedKey) == true
              ? FontStyle.italic
              : null,
          decoration: EzConfig.get(darkBodyUnderlinedKey) == true
              ? TextDecoration.underline
              : null,
          color: color,
          height: EzConfig.get(darkBodyFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzConfig.get(darkBodyLetterSpacingKey),
          wordSpacing: EzConfig.get(darkBodyWordSpacingKey),
        )
      : TextStyle(
          fontSize: EzConfig.get(lightBodyFontSizeKey),
          fontWeight: EzConfig.get(lightBodyBoldedKey) == true
              ? FontWeight.bold
              : FontWeight.normal,
          fontStyle: EzConfig.get(lightBodyItalicizedKey) == true
              ? FontStyle.italic
              : null,
          decoration: EzConfig.get(lightBodyUnderlinedKey) == true
              ? TextDecoration.underline
              : null,
          color: color,
          height: EzConfig.get(lightBodyFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzConfig.get(lightBodyLetterSpacingKey),
          wordSpacing: EzConfig.get(lightBodyWordSpacingKey),
        );

  return fuseWithGFont(
    starter: starter,
    gFont:
        EzConfig.get(useDark ? darkBodyFontFamilyKey : lightBodyFontFamilyKey),
  );
}

/// Builds [TextTheme.bodyLarge] w/ values from [EzConfig.defaults]
/// Provide [isDark] if you are calling this before [EzConfig.initProvider]
TextStyle ezDefaultBodyStyle(Color? color, {bool? isDark}) {
  final bool useDark = isDark ?? EzConfig.isDark;
  final TextStyle starter = useDark
      ? TextStyle(
          fontSize: EzConfig.getDefault(darkBodyFontSizeKey),
          fontWeight: EzConfig.getDefault(darkBodyBoldedKey) == true
              ? FontWeight.bold
              : FontWeight.normal,
          fontStyle: EzConfig.getDefault(darkBodyItalicizedKey) == true
              ? FontStyle.italic
              : null,
          decoration: EzConfig.getDefault(darkBodyUnderlinedKey) == true
              ? TextDecoration.underline
              : null,
          color: color,
          height: EzConfig.getDefault(darkBodyFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzConfig.getDefault(darkBodyLetterSpacingKey),
          wordSpacing: EzConfig.getDefault(darkBodyWordSpacingKey),
        )
      : TextStyle(
          fontSize: EzConfig.getDefault(lightBodyFontSizeKey),
          fontWeight: EzConfig.getDefault(lightBodyBoldedKey) == true
              ? FontWeight.bold
              : FontWeight.normal,
          fontStyle: EzConfig.getDefault(lightBodyItalicizedKey) == true
              ? FontStyle.italic
              : null,
          decoration: EzConfig.getDefault(lightBodyUnderlinedKey) == true
              ? TextDecoration.underline
              : null,
          color: color,
          height: EzConfig.getDefault(lightBodyFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzConfig.getDefault(lightBodyLetterSpacingKey),
          wordSpacing: EzConfig.getDefault(lightBodyWordSpacingKey),
        );

  return fuseWithGFont(
    starter: starter,
    gFont: EzConfig.getDefault(
        useDark ? darkBodyFontFamilyKey : lightBodyFontFamilyKey),
  );
}

/// Builds [TextTheme.labelLarge] w/ values from [EzConfig.prefs]
/// Provide [isDark] if you are calling this before [EzConfig.initProvider]
TextStyle ezLabelStyle(Color? color, {bool? isDark}) {
  final bool useDark = isDark ?? EzConfig.isDark;
  final TextStyle starter = useDark
      ? TextStyle(
          fontSize: EzConfig.get(darkLabelFontSizeKey),
          fontWeight: EzConfig.get(darkLabelBoldedKey) == true
              ? FontWeight.bold
              : FontWeight.normal,
          fontStyle: EzConfig.get(darkLabelItalicizedKey) == true
              ? FontStyle.italic
              : null,
          decoration: EzConfig.get(darkLabelUnderlinedKey) == true
              ? TextDecoration.underline
              : null,
          color: color,
          height: EzConfig.get(darkLabelFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzConfig.get(darkLabelLetterSpacingKey),
          wordSpacing: EzConfig.get(darkLabelWordSpacingKey),
        )
      : TextStyle(
          fontSize: EzConfig.get(lightLabelFontSizeKey),
          fontWeight: EzConfig.get(lightLabelBoldedKey) == true
              ? FontWeight.bold
              : FontWeight.normal,
          fontStyle: EzConfig.get(lightLabelItalicizedKey) == true
              ? FontStyle.italic
              : null,
          decoration: EzConfig.get(lightLabelUnderlinedKey) == true
              ? TextDecoration.underline
              : null,
          color: color,
          height: EzConfig.get(lightLabelFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzConfig.get(lightLabelLetterSpacingKey),
          wordSpacing: EzConfig.get(lightLabelWordSpacingKey),
        );

  return fuseWithGFont(
    starter: starter,
    gFont: EzConfig.get(
        useDark ? darkLabelFontFamilyKey : lightLabelFontFamilyKey),
  );
}

/// Builds [TextTheme.labelLarge] w/ values from [EzConfig.defaults]
/// Provide [isDark] if you are calling this before [EzConfig.initProvider]
TextStyle ezDefaultLabelStyle(Color? color, {bool? isDark}) {
  final bool useDark = isDark ?? EzConfig.isDark;
  final TextStyle starter = useDark
      ? TextStyle(
          fontSize: EzConfig.getDefault(darkLabelFontSizeKey),
          fontWeight: EzConfig.getDefault(darkLabelBoldedKey) == true
              ? FontWeight.bold
              : FontWeight.normal,
          fontStyle: EzConfig.getDefault(darkLabelItalicizedKey) == true
              ? FontStyle.italic
              : null,
          decoration: EzConfig.getDefault(darkLabelUnderlinedKey) == true
              ? TextDecoration.underline
              : null,
          color: color,
          height: EzConfig.getDefault(darkLabelFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzConfig.getDefault(darkLabelLetterSpacingKey),
          wordSpacing: EzConfig.getDefault(darkLabelWordSpacingKey),
        )
      : TextStyle(
          fontSize: EzConfig.getDefault(lightLabelFontSizeKey),
          fontWeight: EzConfig.getDefault(lightLabelBoldedKey) == true
              ? FontWeight.bold
              : FontWeight.normal,
          fontStyle: EzConfig.getDefault(lightLabelItalicizedKey) == true
              ? FontStyle.italic
              : null,
          decoration: EzConfig.getDefault(lightLabelUnderlinedKey) == true
              ? TextDecoration.underline
              : null,
          color: color,
          height: EzConfig.getDefault(lightLabelFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzConfig.getDefault(lightLabelLetterSpacingKey),
          wordSpacing: EzConfig.getDefault(lightLabelWordSpacingKey),
        );

  return fuseWithGFont(
    starter: starter,
    gFont: EzConfig.getDefault(
        useDark ? darkLabelFontFamilyKey : lightLabelFontFamilyKey),
  );
}
