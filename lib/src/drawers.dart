library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Converts a [List] of [Widget]s to a [List] of [CupertinoActionSheetAction]s
/// Removes any child-less [Container]s (i.e. spacers)
List<CupertinoActionSheetAction> buttons2Actions(List<Widget> children) {
  List<CupertinoActionSheetAction> toReturn = [];

  children.forEach((widget) {
    switch (widget.runtimeType) {
      case Container:
        Container cast = widget as Container;
        if (cast.child != null)
          toReturn.add(
            CupertinoActionSheetAction(
              onPressed: doNothing,
              child: widget,
            ),
          );
        break;

      default:
        toReturn.add(
          CupertinoActionSheetAction(
            onPressed: doNothing,
            child: widget,
          ),
        );
    }
  });

  return toReturn;
}

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
          actions: buttons2Actions(body),
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
