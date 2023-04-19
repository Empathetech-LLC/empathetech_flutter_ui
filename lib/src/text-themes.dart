library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Overrides defaults with [EzConfig]
TextTheme materialTextTheme() {
  double fontScalar = EzConfig.prefs[fontScalarKey];

  return TextTheme(
    // Displays
    displayLarge: EzTextStyle(
      fontSize: 58 * fontScalar,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: EzTextStyle(
      fontSize: 46 * fontScalar,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: EzTextStyle(
      fontSize: 36 * fontScalar,
      fontWeight: FontWeight.bold,
    ),

    // Headlines
    headlineLarge: EzTextStyle(
      fontSize: 32,
      decoration: TextDecoration.underline,
    ),
    headlineMedium: EzTextStyle(
      fontSize: 28,
      decoration: TextDecoration.underline,
    ),
    headlineSmall: EzTextStyle(
      fontSize: 24,
      decoration: TextDecoration.underline,
    ),

    // Titles
    titleLarge: EzTextStyle(fontSize: 22),
    titleMedium: EzTextStyle(fontSize: 16),
    titleSmall: EzTextStyle(fontSize: 14),

    // Labels
    labelLarge: EzTextStyle(
      fontSize: 14,
      decoration: TextDecoration.underline,
    ),
    labelMedium: EzTextStyle(
      fontSize: 12,
      decoration: TextDecoration.underline,
    ),
    labelSmall: EzTextStyle(
      fontSize: 10,
      decoration: TextDecoration.underline,
    ),

    // Body
    bodyLarge: EzTextStyle(fontSize: 16),
    bodyMedium: EzTextStyle(fontSize: 14),
    bodySmall: EzTextStyle(fontSize: 12),
  );
}

enum MaterialStyles {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  labelLarge,
  labelMedium,
  labelSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
}

/// Overrides defaults with [EzConfig]
CupertinoTextThemeData cupertinoTextTheme() {
  return CupertinoTextThemeData(
    primaryColor: Color(EzConfig.prefs[themeTextColorKey]),

    // bodyLarge
    textStyle: EzTextStyle(fontSize: 16),

    // labelLarge
    actionTextStyle: EzTextStyle(
      fontSize: 14,
      decoration: TextDecoration.underline,
    ),

    // labelLarge
    tabLabelTextStyle: EzTextStyle(
      fontSize: 14,
      decoration: TextDecoration.underline,
    ),

    // titleMedium
    navTitleTextStyle: EzTextStyle(fontSize: 16),

    // titleLarge
    navLargeTitleTextStyle: EzTextStyle(fontSize: 22),

    // labelLarge
    navActionTextStyle: EzTextStyle(
      fontSize: 14,
      decoration: TextDecoration.underline,
    ),

    // bodyLarge
    pickerTextStyle: EzTextStyle(fontSize: 16),

    // bodyLarge
    dateTimePickerTextStyle: EzTextStyle(fontSize: 16),
  );
}

/// More readable than Theme.of(context).textTheme.
/// Also redundant for confidence
TextStyle ezTextStyle(
  BuildContext context,
  MaterialStyles textStyle,
) {
  double fontScalar = EzConfig.prefs[fontScalarKey];

  switch (textStyle) {
    // Displays
    case MaterialStyles.displayLarge:
      return Theme.of(context).textTheme.displayLarge ??
          EzTextStyle(
            fontSize: 58 * fontScalar,
            fontWeight: FontWeight.bold,
          );
    case MaterialStyles.displayMedium:
      return Theme.of(context).textTheme.displayMedium ??
          EzTextStyle(
            fontSize: 46 * fontScalar,
            fontWeight: FontWeight.bold,
          );
    case MaterialStyles.displaySmall:
      return Theme.of(context).textTheme.displaySmall ??
          EzTextStyle(
            fontSize: 36 * fontScalar,
            fontWeight: FontWeight.bold,
          );

    // Headlines
    case MaterialStyles.headlineLarge:
      return Theme.of(context).textTheme.headlineLarge ??
          EzTextStyle(
            fontSize: 32,
            decoration: TextDecoration.underline,
          );
    case MaterialStyles.headlineMedium:
      return Theme.of(context).textTheme.headlineMedium ??
          EzTextStyle(
            fontSize: 28,
            decoration: TextDecoration.underline,
          );
    case MaterialStyles.headlineSmall:
      return Theme.of(context).textTheme.headlineSmall ??
          EzTextStyle(
            fontSize: 24,
            decoration: TextDecoration.underline,
          );

    // Titles
    case MaterialStyles.titleLarge:
      return Theme.of(context).textTheme.titleLarge ?? EzTextStyle(fontSize: 22);
    case MaterialStyles.titleMedium:
      return Theme.of(context).textTheme.titleMedium ?? EzTextStyle(fontSize: 16);
    case MaterialStyles.titleSmall:
      return Theme.of(context).textTheme.titleSmall ?? EzTextStyle(fontSize: 14);

    // Label
    case MaterialStyles.labelLarge:
      return Theme.of(context).textTheme.labelLarge ??
          EzTextStyle(
            fontSize: 14,
            decoration: TextDecoration.underline,
          );
    case MaterialStyles.labelMedium:
      return Theme.of(context).textTheme.labelMedium ??
          EzTextStyle(
            fontSize: 12,
            decoration: TextDecoration.underline,
          );
    case MaterialStyles.labelSmall:
      return Theme.of(context).textTheme.labelSmall ??
          EzTextStyle(
            fontSize: 10,
            decoration: TextDecoration.underline,
          );

    // Body
    case MaterialStyles.bodyLarge:
      return Theme.of(context).textTheme.bodyLarge ?? EzTextStyle(fontSize: 16);
    case MaterialStyles.bodyMedium:
      return Theme.of(context).textTheme.bodyMedium ?? EzTextStyle(fontSize: 14);
    case MaterialStyles.bodySmall:
      return Theme.of(context).textTheme.bodySmall ?? EzTextStyle(fontSize: 12);
  }
}
