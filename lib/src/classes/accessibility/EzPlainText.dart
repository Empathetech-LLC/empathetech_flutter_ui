/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzPlainText extends TextSpan {
  final String text;
  final TextStyle? style;
  final String? semanticsLabel;

  /// [TextSpan] wrapper with modified [Semantics] for use in [EzRichText]
  EzPlainText(
    this.text, {
    this.style,
    this.semanticsLabel,
  }) : super(
          text: text,
          style: style,
          semanticsLabel: null,
          spellOut: false,
        );
}
