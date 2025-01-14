/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';

class EzIcon extends Icon {
  /// Required to get [ThemeData.textTheme]
  final BuildContext context;

  /// [Icon] wrapper that responds to the theme's text size.
  /// [ThemeData.iconTheme] does not seem to be consumed properly at time of writing
  /// Jan 14th 2025
  EzIcon(
    super.icon,
    this.context, {
    super.key,
    super.fill,
    super.weight,
    super.grade,
    super.opticalSize,
    super.color,
    super.shadows,
    super.semanticLabel,
    super.textDirection,
    super.applyTextScaling,
    super.blendMode,
  }) : super(
          size: Theme.of(context).textTheme.titleLarge?.fontSize,
        );
}
