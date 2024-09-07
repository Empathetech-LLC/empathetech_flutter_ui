/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzRowCol extends StatelessWidget {
  final Widget row;
  final Column col;

  /// [Row] or [EzRow] that will switch to a [Column] if the [ScreenSpace.isLimited]
  EzRowCol({
    super.key,
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
  Widget build(BuildContext context) {
    final bool limitedSpace = ScreenSpace.of(context)?.isLimited ?? true;
    return limitedSpace ? col : row;
  }

  /// Horizontal [EzScrollView] that will switch to a [Column] if the [ScreenSpace.isLimited]
  /// Alignment, size, and direction values will be shared (symmetric)
  EzRowCol.sym({
    super.key,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline? textBaseline,
    required List<Widget> children,
    bool reverseHands = false,
  })  : row = EzScrollView(
          scrollDirection: Axis.horizontal,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
          textBaseline: textBaseline,
          reverseHands: reverseHands,
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
