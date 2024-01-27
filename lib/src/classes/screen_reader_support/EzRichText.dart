/* empathetech_flutter_ui
 * Copyright (c) 2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class EzRichText extends StatelessWidget {
  final List<InlineSpan> children;
  final Key? key;
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
  final SelectionRegistrar? selectionRegistrar;
  final Color? selectionColor;

  /// [Text.rich] wrapper with custom [Semantics] behavior
  /// Recommended to pair with [EzPlainText] and [EzInlineLink] rather than [TextSpan]s
  EzRichText(
    this.children, {
    this.key,
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
    this.selectionRegistrar,
    this.selectionColor,
  });

  String _semanticsLabel() {
    StringBuffer label = StringBuffer("");

    for (InlineSpan child in children) {
      switch (child.runtimeType) {
        case TextSpan:
          TextSpan ogSpan = child as TextSpan;
          label.writeAll([ogSpan.semanticsLabel ?? ogSpan.text, " "]);
          break;
        case EzPlainText:
          EzPlainText plainSpan = child as EzPlainText;
          label.writeAll([plainSpan.semanticsLabel ?? plainSpan.text, " "]);
          break;
        case EzInlineLink:
          EzInlineLink linkSpan = child as EzInlineLink;
          label.writeAll([linkSpan.textFix ?? linkSpan.text, " "]);
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
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaler: textScaler,
        maxLines: maxLines,
        semanticsLabel: null,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
        selectionColor: selectionColor,
      ),
    );
  }
}
