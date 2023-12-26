/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class EzRichText extends StatelessWidget {
  final Key? key;
  final List<InlineSpan> children;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool softWrap;
  final TextOverflow overflow;
  final TextScaler textScaler;
  final int? maxLines;
  final Locale? locale;
  final StrutStyle? strutStyle;
  final TextWidthBasis textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final SelectionRegistrar? selectionRegistrar;
  final Color? selectionColor;
  final bool spellOut;

  /// [RichText] wrapper with pre-configured [Semantics]
  /// Best used with [EzInlineLink] and [EzPlainText]
  EzRichText(
    this.children, {
    this.key,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.textScaler = TextScaler.noScaling,
    this.maxLines,
    this.locale,
    this.strutStyle,
    this.textWidthBasis = TextWidthBasis.parent,
    this.textHeightBehavior,
    this.selectionRegistrar,
    this.selectionColor,
    this.spellOut = false,
  }) : super(key: key);

  String _buildSemantics() {
    StringBuffer message = StringBuffer("");

    for (InlineSpan child in children) {
      switch (child.runtimeType) {
        case TextSpan:
          // Get the Semantics as expected from a TextSpan
          TextSpan textChild = child as TextSpan;
          message.writeAll([textChild.semanticsLabel ?? textChild.text, " "]);
          break;
        case EzPlainText:
          // EzPlainText.semantics label is EFUILang.continue for a more logical Semantics tree traversal
          // So, grab the custom EzPlainText.semantics param for any custom message
          EzPlainText textChild = child as EzPlainText;
          message.writeAll([textChild.semantics ?? textChild.text, " "]);
          break;
        case EzInlineLink:
          // Get the visual text from EzInlineLink
          // It's Semantics message will still be traversed individually
          EzInlineLink linkChild = child as EzInlineLink;
          message.writeAll([linkChild.text, " "]);
          break;
        default:
          break;
      }
    }

    return message.toString();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: children,
        locale: locale,
        semanticsLabel: _buildSemantics(),
        spellOut: spellOut,
      ),
    );
  }
}
