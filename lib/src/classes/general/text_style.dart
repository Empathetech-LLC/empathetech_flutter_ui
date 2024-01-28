/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';

class EzTextStyle extends TextStyle {
  /// [TextStyle] wrapper with some custom defaults for readability based on...
  /// https://m3.material.io/styles/typography/applying-type
  const EzTextStyle({
    super.inherit = true,
    super.color,
    super.backgroundColor,
    super.fontSize,
    super.fontWeight,
    super.fontStyle,
    super.letterSpacing,
    super.wordSpacing = 1.0,
    super.textBaseline = TextBaseline.alphabetic,
    super.height = 1.5,
    super.leadingDistribution = TextLeadingDistribution.even,
    super.locale,
    super.foreground,
    super.background,
    super.shadows,
    super.fontFeatures,
    super.fontVariations,
    super.decoration,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.debugLabel,
    super.fontFamily,
    super.fontFamilyFallback,
    super.package,
    super.overflow,
  });
}
