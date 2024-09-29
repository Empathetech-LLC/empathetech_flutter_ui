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

  /// [EdgeInsets] .only(left: [base], right: [base], top: [base])
  const EzInsets.menu(double base)
      : super.only(left: base, right: base, top: base);
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

/// Returns an appropriate width for a [DropdownMenu]
double dropdownWidth({
  required BuildContext context,
  required List<String> entries,
}) {
  final TextStyle style = Theme.of(context)
          .menuButtonTheme
          .style
          ?.textStyle
          ?.resolve(<WidgetState>{}) ??
      Theme.of(context).textTheme.bodyLarge!;

  return measureText(getLongest(entries), context: context, style: style)
          .width +
      measureIcon(Icons.arrow_drop_down, context: context, style: style).width +
      EzConfig.get(marginKey) +
      EzConfig.get(paddingKey) * 2;
}

/// Returns the longest [String] in [list]
String getLongest(List<String> list) =>
    list.reduce((String a, String b) => a.length > b.length ? a : b);
