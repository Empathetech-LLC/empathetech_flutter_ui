/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzRichText extends StatelessWidget {
  /// Whether a default [EzTextBackground] should be included
  final bool textBackground;

  /// [Text.rich] passthrough
  final List<InlineSpan> children;

  /// [Text.rich] passthrough
  final TextStyle? style;

  /// [Text.rich] passthrough
  final TextAlign textAlign;

  /// [Text.rich] passthrough
  final TextDirection? textDirection;

  /// [Text.rich] passthrough
  final Locale? locale;

  /// [Text.rich] passthrough
  final bool softWrap;

  /// [Text.rich] passthrough
  final TextOverflow overflow;

  /// [Text.rich] passthrough
  final TextScaler textScaler;

  /// [Text.rich] passthrough
  final int? maxLines;

  /// [Text.rich] passthrough
  final StrutStyle? strutStyle;

  /// [Text.rich] passthrough
  final TextWidthBasis textWidthBasis;

  /// [Text.rich] passthrough
  final TextHeightBehavior? textHeightBehavior;

  /// [Text.rich] passthrough
  final Color? selectionColor;

  /// [Text.rich] wrapper with custom [Semantics] behavior
  /// Recommended to pair with [EzPlainText] and [EzInlineLink] rather than [TextSpan]s
  const EzRichText(
    this.children, {
    super.key,
    this.textBackground = true,
    this.style,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.locale,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.textScaler = TextScaler.noScaling,
    this.maxLines,
    this.strutStyle,
    this.textWidthBasis = TextWidthBasis.parent,
    this.textHeightBehavior,
    this.selectionColor,
  });

  String _semanticsLabel() {
    final StringBuffer label = StringBuffer('');

    for (final InlineSpan child in children) {
      switch (child.runtimeType) {
        case const (TextSpan):
          final TextSpan ogSpan = child as TextSpan;
          label.write(ogSpan.semanticsLabel ?? ogSpan.text!);
          break;
        case const (EzPlainText):
          final EzPlainText plainSpan = child as EzPlainText;
          label.write(plainSpan.semanticsLabel ?? plainSpan.text!);
          break;
        case const (EzInlineLink):
          final EzInlineLink linkSpan = child as EzInlineLink;
          label.write(linkSpan.richLabel ?? linkSpan.text);
          break;
        default:
          break;
      }
    }

    return label.toString();
  }

  @override
  Widget build(BuildContext context) {
    final Text text = Text.rich(
      TextSpan(children: children, semanticsLabel: null),
      style: style,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaler: textScaler,
      maxLines: maxLines,
      strutStyle: strutStyle,
      semanticsLabel: null,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );

    return Semantics(
      label: _semanticsLabel(),
      container: true,
      explicitChildNodes: true,
      child: textBackground ? EzTextBackground(text) : text,
    );
  }
}
