library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzDrawer extends StatelessWidget {
  final Key? key;
  final double? elevation;
  final String? semanticLabel;
  final Widget header;
  final List<Widget> body;
  final bool forceMaterial;

  /// Builds a [PlatformTarget] dynamic [Drawer] from [EzConfig.prefs]
  /// Cupertino returns a [CupertinoActionSheet] for [showCupertinoModalPopup]
  /// Optionally provide [forceMaterial] to escape the walled garden
  /// All other params are inherited from [Drawer], and will only effect Material design
  EzDrawer({
    this.key,
    this.elevation,
    this.semanticLabel,
    required this.header,
    required this.body,
    this.forceMaterial = false,
  });

  // Cupertino body
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

  // Material body
  Drawer _materialWidget() {
    Color themeColor = Color(EzConfig.prefs[themeColorKey]);

    body.insert(0, DrawerHeader(child: header));
    return Drawer(
      key: key,
      elevation: elevation,
      semanticLabel: semanticLabel,
      backgroundColor: themeColor,
      child: ezScrollView(children: body),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (forceMaterial) {
      return _materialWidget();
    } else if (isCupertino(context)) {
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
          color: Color(EzConfig.prefs[themeTextColorKey]),
        ),
      );
    } else {
      return _materialWidget();
    }
  }
}
