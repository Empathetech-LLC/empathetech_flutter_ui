/* empathetech_flutter_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzSwapWidget extends StatelessWidget {
  /// When ! [ScreenSpace.isLimited]
  final Widget large;

  /// When [ScreenSpace.isLimited]
  final Widget small;

  /// [ScreenSpace.isLimited] ? [small] : [large]
  /// Returns [small] if there is no [ScreenSpace] in the context
  const EzSwapWidget({
    super.key,
    required this.large,
    required this.small,
  });

  @override
  Widget build(BuildContext context) =>
      (ScreenSpace.of(context)?.isLimited ?? true) ? small : large;
}
