/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

/// EdgeInsets.all(EzConfig margin)
EdgeInsets ezMargin() => EdgeInsets.all(EzConfig.get(marginKey));

/// EdgeInsets.symmetric(horizontal: full margin, vertical: half margin)
EdgeInsets ezColumnMargin() => EdgeInsets.symmetric(
      horizontal: EzConfig.get(marginKey),
      vertical: EzConfig.get(marginKey) / 2,
    );

/// EdgeInsets.symmetric(horizontal: half margin, vertical: full margin)
EdgeInsets ezRowMargin() => EdgeInsets.symmetric(
      horizontal: EzConfig.get(marginKey) / 2,
      vertical: EzConfig.get(marginKey),
    );

/// EdgeInsets.all(Half EzConfig margin)
EdgeInsets ezWrapMargin() => EdgeInsets.all(EzConfig.get(marginKey) / 2);

/// EdgeInsets.all(EzConfig padding)
EdgeInsets ezPadding() => EdgeInsets.all(EzConfig.get(paddingKey));

/// EdgeInsets.symmetric(horizontal: full padding, vertical: half padding)
EdgeInsets ezColumnPadding() => EdgeInsets.symmetric(
      horizontal: EzConfig.get(paddingKey),
      vertical: EzConfig.get(paddingKey) / 2,
    );

/// EdgeInsets.symmetric(horizontal: half padding, vertical: full padding)
EdgeInsets ezRowPadding() => EdgeInsets.symmetric(
      horizontal: EzConfig.get(paddingKey) / 2,
      vertical: EzConfig.get(paddingKey),
    );

/// EdgeInsets.all(Half EzConfig padding)
EdgeInsets ezWrapPadding() => EdgeInsets.all(EzConfig.get(paddingKey) / 2);

/// BorderRadius.all(Radius.circular(20))
const BorderRadius ezRoundEdge = BorderRadius.all(Radius.circular(5));

/// min: [widthOf] context * (2 / 3), max: [smallBreakpoint]
BoxConstraints textFieldConstraints(BuildContext context) {
  final double threeQs = widthOf(context) * 0.75;

  return BoxConstraints(
    minWidth: threeQs,
    maxWidth: min(smallBreakpoint, threeQs),
  );
}
