/* empathetech_flutter_ui
 * Copyright (c) 2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

class EzPlainText extends TextSpan {
  final String? text;
  final TextStyle? style;
  final GestureRecognizer? recognizer;
  final MouseCursor mouseCursor;
  final PointerEnterEventListener? onEnter;
  final PointerExitEventListener? onExit;
  final String? semanticsLabel;
  final Locale? locale;
  final bool? spellOut;

  /// [TextSpan] wrapper with custom [Semantics] to pair with [EzInlineLink]s in [RichText] blocks
  EzPlainText(
    this.text, {
    this.style,
    this.recognizer,
    this.mouseCursor = MouseCursor.defer,
    this.onEnter,
    this.onExit,
    this.semanticsLabel,
    this.locale,
    this.spellOut,
  }) : super(
          text: text,
          style: style,
          recognizer: recognizer,
          mouseCursor: mouseCursor,
          onEnter: onEnter,
          onExit: onExit,
          semanticsLabel: semanticsLabel,
          locale: locale,
          spellOut: spellOut,
        );

  @override
  void computeSemanticsInformation(
    List<InlineSpanSemanticsInformation> collector, {
    ui.Locale? inheritedLocale,
    bool inheritedSpellOut = false,
  }) {
    // Do nothing
    // EzRichText will add this.text to it's semanticsLabel
    // This will return no semantics information so it is skipped on EzRichText traversal
  }
}
