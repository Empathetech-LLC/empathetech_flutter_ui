/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

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

  /// Whether the [Row] should switch to a [Column]
  final bool limitedSpace;

  /// Whether the [EzRow] should reverse its [children] when [EzConfig.dominantHand] is [Hand.left]
  /// Defaults to false; not many use cases where both transformations will be wanted
  final bool reverseHands;

  /// [EzRow] that will switch to a [Column] if there's [limitedSpace]
  /// Alignment, size, and direction values will be shared
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
    this.reverseHands = false,
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
        : EzRow(
            mainAxisAlignment: mainAxisAlignment,
            mainAxisSize: mainAxisSize,
            crossAxisAlignment: crossAxisAlignment,
            textDirection: textDirection,
            verticalDirection: verticalDirection,
            textBaseline: textBaseline,
            children: children,
            reverseHands: reverseHands,
          );
  }
}
