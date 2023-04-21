library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzDrawer extends StatelessWidget {
  final Key? key;

  /// Used directly when [isCupertino]
  /// Wrapped in a [DrawerHeader] when [isMaterial]
  final Widget? header;

  final List<Widget> body;

  /// Default: false
  final bool forceMaterial;

  final Color? backgroundColor;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final double? elevation;
  final ShapeBorder? shape;
  final double? width;
  final String? semanticLabel;

  /// Builds a [PlatformTarget] dynamic [Drawer] from [EzConfig.prefs]
  /// Cupertino returns a [CupertinoActionSheet] for [showCupertinoModalPopup]
  /// Optionally provide [forceMaterial] to escape the walled garden
  /// All other params are inherited from [Drawer], and will only effect Material design
  EzDrawer({
    this.key,
    this.header,
    required this.body,
    this.forceMaterial = false,
    this.backgroundColor,
    this.shadowColor,
    this.surfaceTintColor,
    this.elevation,
    this.shape,
    this.width,
    this.semanticLabel,
  });

  /// Material (Android) body
  Drawer _materialWidget() {
    return Drawer(
      key: key,
      backgroundColor: backgroundColor,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      elevation: elevation,
      shape: shape,
      width: width,
      semanticLabel: semanticLabel,
      child: EzScrollView(
        children: [DrawerHeader(child: header), ...body],
      ),
    );
  }

  /// Cupertino (iOS) body
  Widget _cupertinoWidget(BuildContext context) {
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

        case EzButton:
          actions.add((widget as EzButton).toAction());
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

    return GestureDetector(
      onTap: () => showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: header,
          actions: actions,
        ),
      ),
      child: Icon(CupertinoIcons.line_horizontal_3),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isCupertino(context) && !forceMaterial) {
      return _cupertinoWidget(context);
    } else {
      return _materialWidget();
    }
  }
}
