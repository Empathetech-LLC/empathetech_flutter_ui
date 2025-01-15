/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Mimics the leading back button in an app bar
/// But is designed for the actions widget
/// Useful for [EzConfig]'s [isLeftyKey]
class EzBackAction extends StatelessWidget {
  const EzBackAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator.canPop(context)
        ? IconButton(
            icon: Icon(PlatformIcons(context).back),
            onPressed: () => Navigator.of(context).pop(),
            tooltip: EFUILang.of(context)!.gBack,
            padding: EdgeInsets.zero,
            style: IconButton.styleFrom(side: BorderSide.none),
          )
        : const SizedBox.shrink();
  }
}
