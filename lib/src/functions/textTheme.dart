/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';

/// Creates a [TextTheme] with [color] and sizes from...
/// https://api.flutter.dev/flutter/material/TextTheme-class.html
TextTheme ezTextTheme(Color color) {
  return TextTheme(
    displayLarge: buildDisplayLarge(color),
    displayMedium: buildDisplayMedium(color),
    displaySmall: buildDisplaySmall(color),
    headlineLarge: buildHeadlineLarge(color),
    headlineMedium: buildHeadlineMedium(color),
    headlineSmall: buildHeadlineSmall(color),
    titleLarge: buildTitleLarge(color),
    titleMedium: buildTitleMedium(color),
    titleSmall: buildTitleSmall(color),
    labelLarge: buildLabelLarge(color),
    labelMedium: buildLabelMedium(color),
    labelSmall: buildLabelSmall(color),
    bodyLarge: buildBodyLarge(color),
    bodyMedium: buildBodyMedium(color),
    bodySmall: buildBodySmall(color),
  );
}

/// 57
TextStyle buildDisplayLarge(Color color) {
  return TextStyle(
    fontSize: 57,
    color: color,
  );
}

/// 45
TextStyle buildDisplayMedium(Color color) {
  return TextStyle(
    fontSize: 45,
    color: color,
  );
}

/// 36
TextStyle buildDisplaySmall(Color color) {
  return TextStyle(
    fontSize: 36,
    color: color,
  );
}

/// 32
TextStyle buildHeadlineLarge(Color color) {
  return TextStyle(
    fontSize: 32,
    color: color,
  );
}

/// 28
TextStyle buildHeadlineMedium(Color color) {
  return TextStyle(
    fontSize: 28,
    color: color,
  );
}

/// 24
TextStyle buildHeadlineSmall(Color color) {
  return TextStyle(
    fontSize: 24,
    color: color,
  );
}

/// 22
TextStyle buildTitleLarge(Color color) {
  return TextStyle(
    fontSize: 22,
    color: color,
  );
}

/// 16
TextStyle buildTitleMedium(Color color) {
  return TextStyle(
    fontSize: 16,
    color: color,
  );
}

/// 14
TextStyle buildTitleSmall(Color color) {
  return TextStyle(
    fontSize: 14,
    color: color,
  );
}

/// 14
TextStyle buildLabelLarge(Color color) {
  return TextStyle(
    fontSize: 14,
    color: color,
  );
}

/// 12
TextStyle buildLabelMedium(Color color) {
  return TextStyle(
    fontSize: 12,
    color: color,
  );
}

/// 11
TextStyle buildLabelSmall(Color color) {
  return TextStyle(
    fontSize: 11,
    color: color,
  );
}

/// 16
TextStyle buildBodyLarge(Color color) {
  return TextStyle(
    fontSize: 16,
    color: color,
  );
}

/// 14
TextStyle buildBodyMedium(Color color) {
  return TextStyle(
    fontSize: 14,
    color: color,
  );
}

/// 12
TextStyle buildBodySmall(Color color) {
  return TextStyle(
    fontSize: 12,
    color: color,
  );
}
