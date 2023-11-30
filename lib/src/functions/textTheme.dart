/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// Creates a [TextTheme] with [color] and sizes from...
/// https://api.flutter.dev/flutter/material/TextTheme-class.html
TextTheme ezTextTheme() {
  return TextTheme(
    displayLarge: buildDisplayLarge(),
    displayMedium: buildDisplayMedium(),
    displaySmall: buildDisplaySmall(),
    headlineLarge: buildHeadlineLarge(),
    headlineMedium: buildHeadlineMedium(),
    headlineSmall: buildHeadlineSmall(),
    titleLarge: buildTitleLarge(),
    titleMedium: buildTitleMedium(),
    titleSmall: buildTitleSmall(),
    labelLarge: buildLabelLarge(),
    labelMedium: buildLabelMedium(),
    labelSmall: buildLabelSmall(),
    bodyLarge: buildBodyLarge(),
    bodyMedium: buildBodyMedium(),
    bodySmall: buildBodySmall(),
  );
}

/// 57
TextStyle buildDisplayLarge({Color? color}) {
  return TextStyle(
    fontSize: 57,
    color: color,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

/// 45
TextStyle buildDisplayMedium({Color? color}) {
  return TextStyle(
    fontSize: 45,
    color: color,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

/// 36
TextStyle buildDisplaySmall({Color? color}) {
  return TextStyle(
    fontSize: 36,
    color: color,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

/// 32
TextStyle buildHeadlineLarge({Color? color}) {
  return TextStyle(
    fontSize: 32,
    color: color,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

/// 28
TextStyle buildHeadlineMedium({Color? color}) {
  return TextStyle(
    fontSize: 28,
    color: color,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

/// 24
TextStyle buildHeadlineSmall({Color? color}) {
  return TextStyle(
    fontSize: 24,
    color: color,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

/// 22
TextStyle buildTitleLarge({Color? color}) {
  return TextStyle(
    fontSize: 22,
    color: color,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

/// 16
TextStyle buildTitleMedium({Color? color}) {
  return TextStyle(
    fontSize: 16,
    color: color,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

/// 14
TextStyle buildTitleSmall({Color? color}) {
  return TextStyle(
    fontSize: 14,
    color: color,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

/// 14
TextStyle buildLabelLarge({Color? color}) {
  return TextStyle(
    fontSize: 14,
    color: color,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

/// 12
TextStyle buildLabelMedium({Color? color}) {
  return TextStyle(
    fontSize: 12,
    color: color,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

/// 11
TextStyle buildLabelSmall({Color? color}) {
  return TextStyle(
    fontSize: 11,
    color: color,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

/// 16
TextStyle buildBodyLarge({Color? color}) {
  return TextStyle(
    fontSize: 16,
    color: color,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

/// 14
TextStyle buildBodyMedium({Color? color}) {
  return TextStyle(
    fontSize: 14,
    color: color,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

/// 12
TextStyle buildBodySmall({Color? color}) {
  return TextStyle(
    fontSize: 12,
    color: color,
    fontFamily: EzConfig.instance.fontFamily,
  );
}
