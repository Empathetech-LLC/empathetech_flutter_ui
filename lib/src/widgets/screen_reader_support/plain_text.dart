/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class EzPlainText extends TextSpan {
  /// [TextSpan] wrapper with custom [Semantics] to pair with [EzInlineLink]s in [RichText] blocks
  /// Does not accept [children], only [text]
  const EzPlainText({
    super.text,
    super.style,
    super.recognizer,
    super.mouseCursor,
    super.onEnter,
    super.onExit,
    super.semanticsLabel,
    super.locale,
    super.spellOut,
  });

  @override
  void computeSemanticsInformation(
    List<InlineSpanSemanticsInformation> collector, {
    ui.Locale? inheritedLocale,
    bool inheritedSpellOut = false,
  }) {
    // Do nothing
    // EzRichText will add this.text to it's semanticsLabel
    // So we want this to be skipped in the semantics tree
  }
}
