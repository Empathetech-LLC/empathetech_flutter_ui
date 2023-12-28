/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/services.dart';

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class EzPlainText extends TextSpan {
  final String text;

  /// Message to prepend to the [semanticsLabel]
  /// For use with [EzInlineLink]s in [RichText] blocks
  final String? preLinkText;

  /// Message to append to the [semanticsLabel]
  /// For use with [EzInlineLink]s in [RichText] blocks
  final String? postLinkText;

  final TextStyle? style;
  final GestureRecognizer? recognizer;
  final MouseCursor mouseCursor;
  final PointerEnterEventListener? onEnter;
  final PointerExitEventListener? onExit;
  final String? semanticsLabel;
  final Locale? locale;
  final bool spellOut;

  /// [TextSpan] wrapper with custom [Semantics] to pair with [EzInlineLink]s in [RichText] blocks
  /// Because [EzInlineLink]s are [WidgetSpan]s, [RichText] doesn't combine the [Semantics] like we'd want
  /// So, simply provide the [EzInlineLink]'s [linkText] and it will be appended to the [semanticsLabel]
  EzPlainText({
    required this.text,
    this.preLinkText,
    this.postLinkText,
    this.style,
    this.recognizer,
    this.mouseCursor = MouseCursor.defer,
    this.onEnter,
    this.onExit,
    this.semanticsLabel,
    this.locale,
    this.spellOut = false,
  }) : super(
          text: text,
          style: style,
          recognizer: recognizer,
          mouseCursor: mouseCursor,
          onEnter: onEnter,
          onExit: onExit,
          semanticsLabel:
              '$preLinkText ${semanticsLabel ?? text} $postLinkText',
          locale: locale,
          spellOut: spellOut,
        );
}
