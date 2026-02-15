/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzPlainText extends TextSpan {
  /// [TextSpan] extension with custom [Semantics] to pair with [EzInlineLink]s in [EzRichText] blocks
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
    Locale? inheritedLocale,
    bool inheritedSpellOut = false,
  }) =>
      collector.add(InlineSpanSemanticsInformation.placeholder);
}
