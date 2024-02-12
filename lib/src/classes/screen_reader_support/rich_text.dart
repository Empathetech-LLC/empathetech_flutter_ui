/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzRichText extends StatelessWidget {
  final List<InlineSpan> children;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool softWrap;
  final TextOverflow overflow;
  final TextScaler textScaler;
  final int? maxLines;
  final StrutStyle? strutStyle;
  final TextWidthBasis textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  /// [Text.rich] wrapper with custom [Semantics] behavior
  /// Recommended to pair with [EzPlainText] and [EzInlineLink] rather than [TextSpan]s
  const EzRichText(
    this.children, {
    super.key,
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
          label.writeAll(<String>[ogSpan.semanticsLabel ?? ogSpan.text!, ' ']);
          break;
        case const (EzPlainText):
          final EzPlainText plainSpan = child as EzPlainText;
          label.writeAll(<String>[
            plainSpan.semanticsLabel ?? plainSpan.text!,
            ' ',
          ]);
          break;
        case const (EzInlineLink):
          final EzInlineLink linkSpan = child as EzInlineLink;
          label.writeAll(<String>[linkSpan.textFix ?? linkSpan.text, ' ']);
          break;
        default:
          break;
      }
    }

    return label.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: _semanticsLabel(),
      child: Text.rich(
        TextSpan(children: children),
        key: key,
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
      ),
    );
  }
}
