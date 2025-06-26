/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzSwapWidget extends StatelessWidget {
  /// Which [ScreenSize] the Widget should respond to
  final ScreenSize breakpoint;

  /// When [EzScreenSize] <= [breakpoint]
  final Widget restricted;

  /// When [EzScreenSize] > [breakpoint]
  final Widget expanded;

  /// [EzScreenSize] > [breakpoint] => [expanded]
  /// [EzScreenSize] <= [breakpoint] => [restricted]
  /// [EzScreenSize] is not in the Widget tree => [restricted]
  const EzSwapWidget({
    super.key,
    this.breakpoint = ScreenSize.small,
    required this.restricted,
    required this.expanded,
  });

  @override
  Widget build(BuildContext context) =>
      ((EzScreenSize.of(context)?.screenSize ?? ScreenSize.small).size <=
              breakpoint.size)
          ? restricted
          : expanded;
}
