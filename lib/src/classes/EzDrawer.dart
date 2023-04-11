library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzDrawer extends StatelessWidget {
  final PlatformTarget platform;
  final Widget header;
  final List<Widget> body;

  /// Builds a [PlatformTarget] dynamic [Drawer] from [AppConfig.prefs]
  /// Cupertino returns a [CupertinoActionSheet] for [showCupertinoModalPopup]
  EzDrawer({
    required this.platform,
    required this.header,
    required this.body,
  });

  List<CupertinoActionSheetAction> _createActions() {
    List<CupertinoActionSheetAction> actions = [];

    body.forEach((widget) {
      switch (widget.runtimeType) {
        case Container:
          if ((widget as Container).child != null)
            actions.add(
              CupertinoActionSheetAction(
                onPressed: doNothing,
                child: widget,
              ),
            );
          break;

        case EZButton:
          actions.add((widget as EZButton).toAction());
          break;

        default:
          actions.add(
            CupertinoActionSheetAction(
              onPressed: doNothing,
              child: widget,
            ),
          );
          break;
      }
    });

    return actions;
  }

  @override
  Widget build(BuildContext context) {
    Color themeColor = Color(AppConfig.prefs[themeColorKey]);

    if (platform == PlatformTarget.iOS || platform == PlatformTarget.macOS) {
      return GestureDetector(
        onTap: () => showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) => CupertinoActionSheet(
            title: header,
            actions: _createActions(),
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
}
