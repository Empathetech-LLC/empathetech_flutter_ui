/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzSpacer extends SizedBox {
  final double space;

  /// [SizedBox] with height [space] for creating space in a [Column]
  const EzSpacer(this.space) : super(height: space);

  /// [SizedBox] with width [space] for creating space in a [Row]
  const EzSpacer.row(this.space) : super(width: space);
}

class EzSwapSpacer extends StatelessWidget {
  final double space;

  /// Mimics [EzSpacer.row] by default
  /// Swaps to [EzSpacer] when [ScreenSpace.isLimited]
  EzSwapSpacer(this.space);

  @override
  Widget build(BuildContext context) {
    bool limitedSpace = ScreenSpace.of(context)?.isLimited ?? false;

    return ExcludeSemantics(
      child: limitedSpace ? EzSpacer(space) : EzSpacer.row(space),
    );
  }
}
