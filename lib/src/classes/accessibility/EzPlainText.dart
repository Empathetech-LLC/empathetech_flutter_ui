/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzPlainText extends TextSpan {
  final String text;
  final BuildContext context;
  final TextStyle? style;
  final String? semantics;

  /// [TextSpan] wrapper with modified [Semantics] for use in [EzRichText]
  EzPlainText(
    this.text, {
    required this.context,
    this.style,
    this.semantics,
  }) : super(
          text: text,
          style: style,
          semanticsLabel: EFUILang.of(context)!.gContinue,
          spellOut: false,
        );
}
