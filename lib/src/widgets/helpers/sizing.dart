/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';

// Consts //

/// 64.0
const double ezPillRadius = 64.0;

/// 4.0
const double ezRoundRadius = 4.0;

/// [BorderRadius].all([Radius.circular] => [ezPillRadius])
const BorderRadius ezPillEdge = BorderRadius.all(Radius.circular(ezPillRadius));

/// [BorderRadius].all([Radius.circular] => [ezRoundRadius])
const BorderRadius ezRoundEdge =
    BorderRadius.all(Radius.circular(ezRoundRadius));

/// [BorderRadius].only(top left && top right: [Radius.circular] => [ezRoundRadius])
const BorderRadius ezTextFieldRadius = BorderRadius.only(
  topLeft: Radius.circular(ezRoundRadius),
  topRight: Radius.circular(ezRoundRadius),
);

// Widgets //

class EzInsets extends EdgeInsets {
  /// [EdgeInsets].symmetric(horizontal: [base], vertical: [base] / 2)
  const EzInsets.col(double base)
      : super.symmetric(horizontal: base, vertical: base / 2);

  /// [EdgeInsets].symmetric(horizontal: [base] / 2, vertical: [base])
  const EzInsets.row(double base)
      : super.symmetric(horizontal: base / 2, vertical: base);

  /// [EdgeInsets].all([base] / 2)
  const EzInsets.wrap(double base) : super.all(base / 2);
}

class EzBox extends BoxConstraints {
  /// [BoxConstraints] with everything (min && max) set to [base]
  const EzBox.sym(double base)
      : super(minWidth: base, maxWidth: base, minHeight: base, maxHeight: base);

  /// [BoxConstraints] with [minWidth] && [maxWidth] set to [base]
  const EzBox.vertical(double base) : super(minHeight: base, maxHeight: base);

  /// [BoxConstraints] with [minHeight] && [maxHeight] set to [base]
  const EzBox.horizontal(double base) : super(minWidth: base, maxWidth: base);
}
