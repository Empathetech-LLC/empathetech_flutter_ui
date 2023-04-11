library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzAppBar extends StatelessWidget {
  final Key? key;
  final Key? widgetKey;
  final bool? automaticallyImplyLeading;
  final Widget? leading;
  final Widget title;
  final List<Widget>? trailingActions;
  final EzDrawer? endDrawer;
  final MaterialAppBarData? materialData;
  final CupertinoNavigationBarData? cupertinoData;

  /// Styles a [PlatformAppBar] with [EzConfig.prefs]
  EzAppBar({
    this.key,
    this.widgetKey,
    this.automaticallyImplyLeading,
    this.leading,
    required this.title,
    this.trailingActions,
    this.endDrawer,
    this.materialData,
    this.cupertinoData,
  });

  @override
  Widget build(BuildContext context) {
    return PlatformAppBar(
      // Widgets
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: leading,
      title: title,
      trailingActions: trailingActions,

      // Color
      backgroundColor: Color(EzConfig.prefs[themeColorKey]),

      // Platform configs
      material: (context, platform) => materialData ?? MaterialAppBarData(),
      cupertino: (context, platform) =>
          cupertinoData ??
          CupertinoNavigationBarData(
            trailing: endDrawer,
          ),
    );
  }
}
