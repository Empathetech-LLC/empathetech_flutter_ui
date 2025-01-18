/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzToolTipper extends StatelessWidget {
  /// [message] to be displayed in the [Tooltip]
  final String message;

  /// Whether to include an [EzTextBackground]
  final bool textBackground;

  /// Classic question mark tool tip
  const EzToolTipper(this.message, {super.key, this.textBackground = true});

  @override
  Widget build(BuildContext context) {
    final Widget tooltip = Semantics(
      value: message,
      child: Tooltip(
        waitDuration: Duration.zero,
        enableTapToDismiss: false,
        triggerMode: TooltipTriggerMode.tap,
        excludeFromSemantics: true,
        message: message,
        child: Container(
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: EzIcon(
            PlatformIcons(context).helpOutline,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ),
    );

    return textBackground
        ? EzTextBackground(tooltip, useSurface: true, borderRadius: ezPillShape)
        : tooltip;
  }
}
