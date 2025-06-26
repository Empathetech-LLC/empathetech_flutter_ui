/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzAdaptiveWidget extends StatelessWidget {
  /// Displayed when the context's [ScreenSize] <= [ScreenSize.small]
  final Widget small;

  /// Displayed when the context's [ScreenSize] <= [ScreenSize.medium]
  final Widget? medium;

  /// Displayed when the context's [ScreenSize] > [ScreenSize.medium]
  final Widget? large;

  /// Display a different [Widget] for each [ScreenSize]
  /// Always [small] if [EzScreenSize] is not in the Widget tree
  const EzAdaptiveWidget({
    super.key,
    required this.small,
    required this.medium,
    required this.large,
  });

  @override
  Widget build(BuildContext context) {
    final int? order = EzScreenSize.of(context)?.screenSize.order;

    switch (order) {
      case 1:
        return medium ?? small;
      case 2:
        return large ?? medium ?? small;
      default:
        return small;
    }
  }
}
