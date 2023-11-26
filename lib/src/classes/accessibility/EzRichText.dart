/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzRichText extends StatelessWidget {
  final List<InlineSpan> children;
  final Key? key;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextScaler? textScaler;
  final int? maxLines;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;

  /// [Text.rich] wrapper with customized defaults and pre-configured [Semantics]
  EzRichText(
    this.children, {
    this.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.textScaler,
    this.maxLines,
    this.textWidthBasis,
    this.textHeightBehavior,
  });

  String _buildSemantics() {
    StringBuffer message = StringBuffer("");

    for (InlineSpan child in children) {
      switch (child.runtimeType) {
        case TextSpan:
          TextSpan textChild = child as TextSpan;
          message.writeAll([textChild.semanticsLabel ?? textChild.text, " "]);
          break;
        case EzPlainText:
          EzPlainText textChild = child as EzPlainText;
          message.writeAll([textChild.semantics ?? textChild.text, " "]);
          break;
        case EzInlineLink:
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
    return Text.rich(
      TextSpan(children: children),
      key: key,
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      textScaler: textScaler,
      maxLines: maxLines,
      semanticsLabel: _buildSemantics(),
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
  }
}
