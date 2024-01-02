/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Mimics the leading back button in an app bar
/// But is designed for the actions widget
/// Useful for [Hand.left]
class EzBackAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator.canPop(context)
        ? IconButton(
            icon: Icon(PlatformIcons(context).back),
            onPressed: () => popScreen(context: context),
            tooltip: EFUILang.of(context)!.gBack,
          )
        : const SizedBox.shrink();
  }
}
