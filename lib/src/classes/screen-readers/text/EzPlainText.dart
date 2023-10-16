/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// Custom [WidgetSpan] to pair with [EzTextBlock]
/// Helps automtically configure good [Semantics]
class EzPlainText extends WidgetSpan {
  final String text;
  final TextStyle? style;
  final PlaceholderAlignment alignment;
  final TextBaseline? baseline;

  EzPlainText(
    this.text, {
    this.style,
    this.alignment = PlaceholderAlignment.middle,
    this.baseline,
  }) : super(
          child: ExcludeSemantics(child: EzText(text, style: style)),
          alignment: alignment,
          baseline: baseline,
        );
}
