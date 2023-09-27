/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzRow extends StatelessWidget {
  /// Inherited from [Row]
  final Key? key;

  /// Inherited from [Row]
  final MainAxisAlignment mainAxisAlignment;

  /// Inherited from [Row]
  final MainAxisSize mainAxisSize;

  /// Inherited from [Row]
  final CrossAxisAlignment crossAxisAlignment;

  /// Inherited from [Row]
  final TextDirection? textDirection;

  /// Inherited from [Row]
  final VerticalDirection verticalDirection;

  /// Inherited from [Row]
  final TextBaseline? textBaseline;

  /// Inherited from [Row]
  final List<Widget> children;

  /// Whether [children] should be
  /// If true, [children] will be reversed when [EzConfig.instance]s  is [Hand.left]
  final bool reverseHands;

  /// [Row] wrapper that automatically supports [EzConfig.dominantHand]
  /// Can be disabled via setting [reverseHands] to false
  EzRow({
    this.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    required this.children,
    this.reverseHands = true,
  }) : super(key: key);

  List<Widget> _getList() {
    if (reverseHands && EzConfig.instance.dominantHand == Hand.left) {
      return children.reversed.toList();
    } else {
      return children;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      key: key,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: _getList(),
    );
  }
}
