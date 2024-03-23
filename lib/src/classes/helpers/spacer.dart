/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzSpacer extends SizedBox {
  final double space;

  /// [SizedBox] with height [space] for creating space in a [Column]
  const EzSpacer(this.space, {super.key}) : super(height: space);

  /// [SizedBox] with width [space] for creating space in a [Row]
  const EzSpacer.row(this.space, {super.key}) : super(width: space);
}

class EzSwapSpacer extends StatelessWidget {
  final double space;

  /// Mimics [EzSpacer.row] by default
  /// Swaps to [EzSpacer] when [ScreenSpace.isLimited]
  const EzSwapSpacer(this.space, {super.key});

  @override
  Widget build(BuildContext context) {
    final bool limitedSpace = ScreenSpace.of(context)?.isLimited ?? false;

    return ExcludeSemantics(
      child: limitedSpace ? EzSpacer(space) : EzSpacer.row(space),
    );
  }
}
