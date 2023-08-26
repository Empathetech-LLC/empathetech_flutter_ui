/// empathetech_flutter_ui
/// Copyright (c) 2023 Empathetech LLC. All rights reserved.
/// See LICENSE for distribution and usage details.

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzTextTheme extends TextTheme {
  final Color color;

  EzTextTheme({
    required this.color,
  }) : super(
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
