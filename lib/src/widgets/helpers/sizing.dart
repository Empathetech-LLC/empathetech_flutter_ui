/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';

// Aliases //

/// [BorderRadius].only(top left && top right: [Radius.circular] => 4.0)
const BorderRadius textFieldRadius = BorderRadius.only(
  topLeft: Radius.circular(4),
  topRight: Radius.circular(4),
);

/// Returns the longest [String] in [list]
String getLongest(List<String> list) =>
    list.reduce((String a, String b) => a.length > b.length ? a : b);

// Custom //

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

/// 4.0
const double ezRoundRadius = 4.0;

/// [BorderRadius].all([Radius.circular] => [ezRoundRadius] == 4.0)
const BorderRadius ezRoundEdge =
    BorderRadius.all(Radius.circular(ezRoundRadius));

/// 64.0
const double ezPillRadius = 64.0;

/// [BorderRadius].all([Radius.circular] => [ezPillRadius] == 64.0)
const BorderRadius ezPillShape =
    BorderRadius.all(Radius.circular(ezPillRadius));

class EzBox extends BoxConstraints {
  /// [BoxConstraints] with everything (min && max) set to [base]
  const EzBox.sym(double base)
      : super(minWidth: base, maxWidth: base, minHeight: base, maxHeight: base);

  /// [BoxConstraints] with [minWidth] && [maxWidth] set to [base]
  const EzBox.vertical(double base) : super(minHeight: base, maxHeight: base);

  /// [BoxConstraints] with [minHeight] && [maxHeight] set to [base]
  const EzBox.horizontal(double base) : super(minWidth: base, maxWidth: base);
}

/// threeQs = [widthOf] context * 0.75
/// min: threeQs, max: min(threeQs, [ScreenSize.small])
BoxConstraints ezTextFieldConstraints(BuildContext context) {
  final double threeQs = widthOf(context) * 0.75;

  return BoxConstraints(
    minWidth: min(threeQs, ScreenSize.small.size),
    maxWidth: min(threeQs, ScreenSize.small.size),
  );
}

/// Returns an appropriate width for a [DropdownMenu]
double ezDropdownWidth({
  required BuildContext context,
  required List<String> entries,
}) =>
    2 * EzConfig.margin +
    ezTextSize(
      getLongest(entries),
      context: context,
      style: Theme.of(context).textTheme.bodyLarge,
    ).width +
    EzConfig.padding +
    max(EzConfig.padding + EzConfig.iconSize, kMinInteractiveDimension);
