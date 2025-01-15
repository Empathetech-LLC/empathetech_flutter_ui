/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzIcon extends Icon {
  /// [Icon] wrapper that responds to [EzConfig]s [iconSizeKey]
  /// [ThemeData.iconTheme] does not seem to be consumed properly at time of writing
  /// Jan 2025
  EzIcon(
    super.icon, {
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
  }) : super(size: EzConfig.get(iconSizeKey));
}
