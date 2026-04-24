/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';

class EzClickable extends MouseRegion {
  const EzClickable({
    super.key,
    super.onEnter,
    super.onExit,
    super.onHover,
    super.cursor = SystemMouseCursors.click,
    super.opaque = true,
    super.hitTestBehavior,
    super.child,
  });
}
