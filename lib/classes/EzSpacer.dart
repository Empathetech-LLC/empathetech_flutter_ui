library empathetech_flutter_ui;

import 'package:flutter/material.dart';

class EzSpacer extends Container {
  final double space;

  /// [Container] with height [space] for creating space in a [Column]
  EzSpacer(this.space) : super(height: space);

  /// [Container] with height [space] for creating space in a [Row]
  EzSpacer.row(this.space) : super(width: space);
}
