/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzRowCol extends StatelessWidget {
  /// Which [ScreenSize] the Widget should respond to
  final ScreenSize breakpoint;

  /// Displayed when [EzScreenSize] > [breakpoint]
  final Widget row;

  /// Displayed when [EzScreenSize] <= [breakpoint]
  final Column col;

  /// [row] that will switch to a [col] if the [EzScreenSize] <= [breakpoint]
  /// Will always be [col] if [EzScreenSize] is not in the Widget tree
  EzRowCol({
    super.key,
    this.breakpoint = ScreenSize.small,
    required this.row,
    required this.col,
  })  : assert(
          row.runtimeType == Row ||
              row.runtimeType == EzRow ||
              row.runtimeType == EzScrollView,
          'row Widget can be a Row, EzRow, or EzScrollView',
        ),
        assert(
          col.runtimeType == Column || col.runtimeType == EzScrollView,
          'col Widget can be a Column or EzScrollView',
        );

  @override
  Widget build(BuildContext context) =>
      ((EzScreenSize.of(context)?.screenSize ?? ScreenSize.small).size <=
              breakpoint.size)
          ? col
          : row;

  /// Horizontal [EzScrollView] that will switch to a [Column] based on [breakpoint]
  /// Alignment, size, and direction values will be shared (symmetric)
  EzRowCol.sym({
    super.key,
    this.breakpoint = ScreenSize.medium,
    bool reverseHands = false,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline? textBaseline,
    required List<Widget> children,
  })  : row = EzScrollView(
          scrollDirection: Axis.horizontal,
          reverseHands: reverseHands,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
          textBaseline: textBaseline,
          children: children,
        ),
        col = Column(
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
          textBaseline: textBaseline,
          children: children,
        );
}
