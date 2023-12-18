/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class EzPlainText extends TextSpan {
  final String text;
  final BuildContext context;
  final TextStyle? style;

  /// Message that [EzRichText] will use for the full-block read
  final String? semantics;

  final MouseCursor mouseCursor;
  final void Function(PointerEnterEvent)? onEnter;
  final void Function(PointerExitEvent)? onExit;
  final Locale? locale;
  final bool spellOut;

  /// [TextSpan] wrapper with custom [Semantics] for use in [EzRichText]
  /// Use [semantics] in place of [TextSpan.semanticsLabel]
  EzPlainText(
    this.text, {
    required this.context,
    this.style,
    this.semantics,
    this.mouseCursor = SystemMouseCursors.text,
    this.onEnter,
    this.onExit,
    this.locale,
    this.spellOut = false,
  }) : super(
          text: text,
          style: style,
          semanticsLabel: EFUILang.of(context)!.gContinue,
          recognizer: null,
          mouseCursor: mouseCursor,
          onEnter: onEnter,
          onExit: onExit,
          locale: locale,
          spellOut: spellOut,
        );
}
