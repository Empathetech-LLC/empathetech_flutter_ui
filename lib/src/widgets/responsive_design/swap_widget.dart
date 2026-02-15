/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzSwapWidget extends StatelessWidget {
  /// Which [ScreenSize] the Widget should respond to
  final ScreenSize breakpoint;

  /// Displayed when the context's [ScreenSize] > [breakpoint]
  final Widget expanded;

  /// Displayed when the context's [ScreenSize] <= [breakpoint]
  final Widget restricted;

  /// [ScreenSize] > [breakpoint] => [expanded]
  /// [ScreenSize] <= [breakpoint] => [restricted]
  /// [ScreenSize] is not in the Widget tree => [restricted]
  const EzSwapWidget({
    super.key,
    this.breakpoint = ScreenSize.small,
    required this.restricted,
    required this.expanded,
  });

  @override
  Widget build(BuildContext context) {
    final ScreenSize? size = EzScreenSize.of(context)?.screenSize;

    return (size == null || size.order <= breakpoint.order)
        ? restricted
        : expanded;
  }
}
