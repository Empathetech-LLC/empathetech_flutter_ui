/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzBackFAB extends FloatingActionButton {
  /// [FloatingActionButton] that goes back; [Navigator.pop]
  EzBackFAB(BuildContext context, {super.key})
      : super(
          child: EzIcon(PlatformIcons(context).back),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: ezL10n(context).gBack,
        );
}
