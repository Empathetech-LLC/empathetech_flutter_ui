/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class EzMargin extends EdgeInsets {
  /// EdgeInsets.all(EzConfig margin)
  EzMargin() : super.all(EzConfig.get(marginKey));

  /// EdgeInsets.symmetric(horizontal: full margin, vertical: half margin)
  EzMargin.col()
      : super.symmetric(
          horizontal: EzConfig.get(marginKey),
          vertical: EzConfig.get(marginKey) / 2,
        );

  /// EdgeInsets.symmetric(horizontal: half margin, vertical: full margin)
  EzMargin.row()
      : super.symmetric(
          horizontal: EzConfig.get(marginKey) / 2,
          vertical: EzConfig.get(marginKey),
        );

  /// EdgeInsets.all(Half EzConfig margin)
  EzMargin.wrap() : super.all(EzConfig.get(marginKey) / 2);
}

class EzPadding extends EdgeInsets {
  /// EdgeInsets.all(EzConfig padding)
  EzPadding() : super.all(EzConfig.get(paddingKey));

  /// EdgeInsets.symmetric(horizontal: full padding, vertical: half padding)
  EzPadding.col()
      : super.symmetric(
          horizontal: EzConfig.get(paddingKey),
          vertical: EzConfig.get(paddingKey) / 2,
        );

  /// EdgeInsets.symmetric(horizontal: half padding, vertical: full padding)
  EzPadding.row()
      : super.symmetric(
          horizontal: EzConfig.get(paddingKey) / 2,
          vertical: EzConfig.get(paddingKey),
        );

  /// EdgeInsets.all(Half EzConfig padding)
  EzPadding.wrap() : super.all(EzConfig.get(paddingKey) / 2);

  /// EdgeInsets padding everywhere but bottom
  EzPadding.menu()
      : super.only(
          left: EzConfig.get(paddingKey),
          right: EzConfig.get(paddingKey),
          top: EzConfig.get(paddingKey),
        );
}

/// BorderRadius.all(Radius.circular(4.0))
const BorderRadius ezRoundEdge = BorderRadius.all(Radius.circular(4.0));

/// BorderRadius.all(Radius.circular(64.0))
const BorderRadius ezPillShape = BorderRadius.all(Radius.circular(64.0));

/// threeQs = [widthOf] context * (2 / 3)
/// min: threeQs, max: min(threeQs, [smallBreakpoint])
BoxConstraints textFieldConstraints(BuildContext context) {
  final double threeQs = widthOf(context) * 0.75;

  return BoxConstraints(
    minWidth: threeQs,
    maxWidth: min(threeQs, smallBreakpoint),
  );
}
