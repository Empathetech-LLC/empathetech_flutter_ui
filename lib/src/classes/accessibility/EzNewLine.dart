/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';

class EzNewLine extends TextSpan {
  final TextStyle? style;

  /// [TextSpan] with [text] set to an empty string.
  const EzNewLine(this.style)
      : super(
          text: "",
          style: style,
          semanticsLabel: null,
          spellOut: false,
        );
}
