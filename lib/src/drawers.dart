library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Builds a [PlatformTarget] dynamic end [Drawer]
/// Cupertino retuins a [CupertinoActionSheet] for [showCupertinoModalPopup]
Widget? ezDrawer({
  required BuildContext context,
  required PlatformTarget platform,
  required Widget? header,
  required List<Widget>? body,
}) {
  if (header == null || body == null) {
    return null;
  }

  Color themeColor = Color(AppConfig.prefs[themeColorKey]);

  if (platform == PlatformTarget.iOS || platform == PlatformTarget.macOS) {
    return GestureDetector(
      onTap: () => showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: header,
          actions: body,
        ),
      ),
      child: Icon(
        CupertinoIcons.line_horizontal_3,
        color: Color(AppConfig.prefs[themeTextColorKey]),
      ),
    );
  } else {
    body.insert(0, DrawerHeader(child: header));
    return Drawer(
      backgroundColor: themeColor,
      child: ezScrollView(children: body),
    );
  }
}
