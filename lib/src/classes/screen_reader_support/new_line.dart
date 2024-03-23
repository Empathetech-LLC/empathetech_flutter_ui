/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';

class EzNewLine extends StatelessWidget {
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final bool? softWrap;
  final TextOverflow? overflow;
  final TextScaler? textScaler;
  final Color? selectionColor;

  /// [Text] wrapper with an empty string for easily creating new lines in the passed [style]
  /// Ignored by semantics tree
  const EzNewLine(
    this.style, {
    super.key,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.textScaler,
    this.selectionColor,
  });

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Text(
        '',
        style: style,
        textAlign: textAlign,
        textDirection: textDirection,
        softWrap: softWrap,
        overflow: overflow,
        textScaler: textScaler,
        semanticsLabel: null,
        selectionColor: selectionColor,
      ),
    );
  }
}
