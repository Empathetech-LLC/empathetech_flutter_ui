/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzPlainText extends WidgetSpan {
  final String text;
  final TextStyle? style;
  final String? semanticsLabel;
  final PlaceholderAlignment alignment;
  final TextBaseline? basline;

  /// [WidgetSpan] wrapper to use in [EzRichText] rather than [TextSpan] for ideal [Semantics]
  EzPlainText(
    this.text, {
    this.style,
    this.semanticsLabel,
    this.alignment = PlaceholderAlignment.bottom,
    this.basline,
  }) : super(
          child: ExcludeSemantics(child: EzText(text, style: style)),
          alignment: alignment,
          baseline: basline,
        );
}
