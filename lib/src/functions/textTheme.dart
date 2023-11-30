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
TextStyle buildDisplayLarge() {
  return TextStyle(
    fontSize: 57,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

/// 45
TextStyle buildDisplayMedium() {
  return TextStyle(
    fontSize: 45,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

/// 36
TextStyle buildDisplaySmall() {
  return TextStyle(
    fontSize: 36,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

/// 32
TextStyle buildHeadlineLarge() {
  return TextStyle(
    fontSize: 32,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

/// 28
TextStyle buildHeadlineMedium() {
  return TextStyle(
    fontSize: 28,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

/// 24
TextStyle buildHeadlineSmall() {
  return TextStyle(
    fontSize: 24,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

/// 22
TextStyle buildTitleLarge() {
  return TextStyle(
    fontSize: 22,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

/// 16
TextStyle buildTitleMedium() {
  return TextStyle(
    fontSize: 16,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

/// 14
TextStyle buildTitleSmall() {
  return TextStyle(
    fontSize: 14,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

/// 14
TextStyle buildLabelLarge() {
  return TextStyle(
    fontSize: 14,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

/// 12
TextStyle buildLabelMedium() {
  return TextStyle(
    fontSize: 12,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

/// 11
TextStyle buildLabelSmall() {
  return TextStyle(
    fontSize: 11,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

/// 16
TextStyle buildBodyLarge() {
  return TextStyle(
    fontSize: 16,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

/// 14
TextStyle buildBodyMedium() {
  return TextStyle(
    fontSize: 14,
    fontFamily: EzConfig.instance.fontFamily,
  );
}

/// 12
TextStyle buildBodySmall() {
  return TextStyle(
    fontSize: 12,
    fontFamily: EzConfig.instance.fontFamily,
  );
}
