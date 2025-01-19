/* empathetech_flutter_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Mimics the [AppBar.leading] back button
/// But can also be used in [AppBar.actions] for left handed layouts
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
