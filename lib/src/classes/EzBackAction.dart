/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Mimics the leading back button in an app bar
/// But is designed for the actions widget
/// Useful for [Hand.left]
class EzBackAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Check if there is a Navigator and if it can pop
    bool canPop = Navigator.canPop(context);

    return canPop
        ? IconButton(
            icon: Icon(PlatformIcons(context).back),
            onPressed: () => popScreen(context: context),
          )
        : SizedBox.shrink();
  }
}
