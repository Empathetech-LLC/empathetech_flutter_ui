library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Builds a [PlatformTarget] dynamic end [Drawer]
/// Cupertino retuins a [CupertinoActionSheet] for [showCupertinoModalPopup]
Widget ezDrawer({
  required BuildContext context,
  required PlatformTarget platform,
  required Widget header,
  required List<Widget> body,
}) {
  Color themeColor = Color(AppConfig.prefs[themeColorKey]);

  if (platform == PlatformTarget.iOS || platform == PlatformTarget.macOS) {
    return CupertinoActionSheet();
  } else {
    body.insert(0, header);
    return Drawer(
      backgroundColor: themeColor,
      child: ezScrollView(children: body),
    );
  }
}
