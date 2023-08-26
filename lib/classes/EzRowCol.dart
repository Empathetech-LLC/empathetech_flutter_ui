/// empathetech_flutter_ui
/// Copyright (c) 2023 Empathetech LLC. All rights reserved.
/// See LICENSE for distribution and usage details.
library empathetech_flutter_ui;

import 'package:flutter/material.dart';

class EzRowCol extends StatelessWidget {
  final Key? key;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final List<Widget> children;
  final bool limitedSpace;

  /// [Row] that will switch to a [Column] if there's [limitedSpace]
  EzRowCol({
    this.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    required this.children,
    this.limitedSpace = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return limitedSpace
        ? Column(
            mainAxisAlignment: mainAxisAlignment,
            mainAxisSize: mainAxisSize,
            crossAxisAlignment: crossAxisAlignment,
            textDirection: textDirection,
            verticalDirection: verticalDirection,
            textBaseline: textBaseline,
            children: children,
          )
        : Row(
            mainAxisAlignment: mainAxisAlignment,
            mainAxisSize: mainAxisSize,
            crossAxisAlignment: crossAxisAlignment,
            textDirection: textDirection,
            verticalDirection: verticalDirection,
            textBaseline: textBaseline,
            children: children,
          );
  }
}
