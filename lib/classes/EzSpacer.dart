/// empathetech_flutter_ui
/// Copyright (c) 2023 Empathetech LLC. All rights reserved.
/// See LICENSE for distribution and usage details.
library empathetech_flutter_ui;

import 'package:flutter/material.dart';

class EzSpacer extends SizedBox {
  final double space;

  /// [SizedBox] with height [space] for creating space in a [Column]
  const EzSpacer(this.space) : super(height: space);

  /// [SizedBox] with width [space] for creating space in a [Row]
  const EzSpacer.row(this.space) : super(width: space);

  /// [SizedBox] with height or width [space] based on [limitedSpace]
  EzSpacer.swap(this.space, {required bool limitedSpace})
      : super(
          height: limitedSpace ? space : null,
          width: limitedSpace ? null : space,
        );
}
