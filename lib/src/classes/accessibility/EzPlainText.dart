/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzPlainText extends WidgetSpan {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final String? semanticsLabel;
  final PlaceholderAlignment alignment;
  final TextBaseline? basline;

  /// [WidgetSpan] wrapper to use in [EzRichText] rather than [TextSpan] for ideal [Semantics]
  EzPlainText(
    this.text, {
    this.style,
    this.textAlign,
    this.semanticsLabel,
    this.alignment = PlaceholderAlignment.middle,
    this.basline,
  }) : super(
          child: ExcludeSemantics(
              child: EzText(
            text,
            style: style,
            textAlign: textAlign,
          )),
          alignment: alignment,
          baseline: basline,
        );
}
