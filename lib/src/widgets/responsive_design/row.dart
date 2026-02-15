/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzRow extends StatelessWidget {
  /// [Row.mainAxisAlignment] passthrough
  final MainAxisAlignment mainAxisAlignment;

  /// [Row.mainAxisSize] passthrough
  final MainAxisSize mainAxisSize;

  /// [Row.crossAxisAlignment] passthrough
  final CrossAxisAlignment crossAxisAlignment;

  /// [Row.textDirection] passthrough
  final TextDirection? textDirection;

  /// [Row.verticalDirection] passthrough
  final VerticalDirection verticalDirection;

  /// [Row.textBaseline] passthrough
  final TextBaseline? textBaseline;

  /// Whether this should respond to [isLeftyKey]'s status
  /// If true, [children] will be reversed
  final bool reverseHands;

  /// [Row.children] passthrough
  final List<Widget> children;

  /// [Row] wrapper that optionally reverses [children] based on [isLeftyKey]'s status
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
    if (reverseHands && EzConfig.isLefty == true) {
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
