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

  /// Message that [EzRichText] will use for the full-block read
  final String? semantics;

  final String? semanticsLabel;

  /// [TextSpan] wrapper with custom [semantics] for use in [EzRichText]
  EzPlainText(
    this.text, {
    required this.context,
    this.style,
    this.semantics,
    this.semanticsLabel,
  }) : super(
          text: text,
          style: style,
          semanticsLabel: semanticsLabel ?? EFUILang.of(context)!.gContinue,
          spellOut: false,
        );
}
