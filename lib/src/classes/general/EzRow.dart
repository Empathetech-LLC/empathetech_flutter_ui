/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzRow extends StatelessWidget {
  final Key? key;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final List<Widget> children;

  /// Whether this should respond to [Hand] changes
  /// If true, [children] will be reversed when [Hand.left]
  final bool reverseHands;

  /// [Row] wrapper that automatically supports [Hand] changes via [reverseHands]
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

  /// Reverses [children] when [reverseHands] is true and [isRightHandKey] is false
  List<Widget> _getList() {
    if (reverseHands && EzConfig.get(isRightHandKey) == false) {
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
