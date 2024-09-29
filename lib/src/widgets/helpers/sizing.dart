/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class EzInsets extends EdgeInsets {
  /// [EdgeInsets].symmetric(horizontal: [base], vertical: [base] / 2)
  const EzInsets.col(double base)
      : super.symmetric(horizontal: base, vertical: base / 2);

  /// [EdgeInsets].symmetric(horizontal: [base] / 2, vertical: [base])
  const EzInsets.row(double base)
      : super.symmetric(horizontal: base / 2, vertical: base);

  /// [EdgeInsets].all([base] / 2)
  const EzInsets.wrap(double base) : super.all(base / 2);

  /// [EdgeInsets] .only(left: [width], right: [width], top: [height])
  const EzInsets.menu({required double width, required double height})
      : super.only(left: width, right: width, top: height);
}

/// BorderRadius.all(Radius.circular(4.0))
const BorderRadius ezRoundEdge = BorderRadius.all(Radius.circular(4.0));

/// BorderRadius.all(Radius.circular(64.0))
const BorderRadius ezPillShape = BorderRadius.all(Radius.circular(64.0));

/// threeQs = [widthOf] context * 0.75
/// min: threeQs, max: min(threeQs, [smallBreakpoint])
BoxConstraints textFieldConstraints(BuildContext context) {
  final double threeQs = widthOf(context) * 0.75;

  return BoxConstraints(
    minWidth: threeQs,
    maxWidth: min(threeQs, smallBreakpoint),
  );
}
