/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
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

  /// [EzSpacer.row], that swaps to a default [EzSpacer] when [ScreenSpace.isLimited]
  factory EzSpacer.swap(BuildContext context, double space) {
    bool limitedSpace = ScreenSpace.of(context)?.isLimited ?? false;

    if (limitedSpace) {
      return EzSpacer(space);
    } else {
      return EzSpacer.row(space);
    }
  }
}
