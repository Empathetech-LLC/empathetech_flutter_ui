library empathetech_flutter_ui;

import 'package:flutter/material.dart';

class EzSpacer extends SizedBox {
  final double space;

  /// [Container] with height [space] for creating space in a [Column]
  const EzSpacer(this.space) : super(height: space);

  /// [Container] with height [space] for creating space in a [Row]
  const EzSpacer.row(this.space) : super(width: space);
}
