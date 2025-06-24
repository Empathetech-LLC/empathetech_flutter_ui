/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzBackFAB extends FloatingActionButton {
  /// [FloatingActionButton] that goes back; [Navigator.pop]
  EzBackFAB(BuildContext context, {super.key, bool showHome = false})
      : super(
          heroTag: 'back_fab',
          child: EzIcon(showHome
              ? PlatformIcons(context).home
              : PlatformIcons(context).back),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: ezL10n(context).gBack,
        );
}
