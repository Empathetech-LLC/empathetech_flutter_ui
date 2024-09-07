/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzSwapWidget extends StatelessWidget {
  final Widget large;
  final Widget small;

  /// [small] when[ScreenSpace.isLimited], [large] otherwise
  const EzSwapWidget({
    super.key,
    required this.large,
    required this.small,
  });

  @override
  Widget build(BuildContext context) {
    final bool limitedSpace = ScreenSpace.of(context)?.isLimited ?? true;
    return limitedSpace ? small : large;
  }
}
