/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';

class EzCol extends Column {
  const EzCol({
    super.key,
    super.mainAxisAlignment,
    super.mainAxisSize = MainAxisSize.min,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline,
    super.spacing,
    super.children,
  });
}

class EzWrap extends Wrap {
  const EzWrap({
    super.key,
    super.direction,
    super.alignment = WrapAlignment.center,
    super.spacing,
    super.runAlignment = WrapAlignment.center,
    super.runSpacing,
    super.crossAxisAlignment = WrapCrossAlignment.center,
    super.textDirection,
    super.verticalDirection,
    super.clipBehavior,
    super.children,
  });
}
