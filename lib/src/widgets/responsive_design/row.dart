/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzRow extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;

  /// Whether this should respond to [isLeftyKey]'s status
  /// If true, [children] will be reversed
  final bool reverseHands;

  final List<Widget> children;

  /// [Row] wrapper that automatically supports [isLeftyKey]'s status via [reverseHands]
  const EzRow({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.reverseHands = true,
    required this.children,
  });

  /// Reverses [children] when [reverseHands] is true and [isLeftyKey] is true
  List<Widget> getChildren() {
    if (reverseHands && EzConfig.get(isLeftyKey) == true) {
      return children.reversed.toList();
    } else {
      return children;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: getChildren(),
    );
  }
}
