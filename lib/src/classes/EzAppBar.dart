library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzAppBar extends PlatformAppBar {
  final Key? key;
  final Key? widgetKey;
  final Widget title;

  /// Default:
  /// [EzConfig.prefs] -> themeColorKey
  final Color? backgroundColor;

  final Widget? leading;
  final dynamic trailing;
  final bool? automaticallyImplyLeading;
  final MaterialAppBarData Function(BuildContext, PlatformTarget)? material;
  final CupertinoNavigationBarData Function(BuildContext, PlatformTarget)? cupertino;

  /// Styles a [PlatformAppBar] with [EzConfig.prefs]
  EzAppBar({
    this.key,
    this.widgetKey,
    required this.title,
    this.backgroundColor,
    this.leading,
    this.trailing,
    this.automaticallyImplyLeading,
    this.material,
    this.cupertino,
  }) : super(
          key: key,
          widgetKey: widgetKey,

          title: title,
          backgroundColor: backgroundColor ?? Color(EzConfig.prefs[themeColorKey]),
          leading: leading,

          // Only set trailing actions if trailing is a List
          // Otherwise, trailing is a [Drawer], and will be handled in [EzScaffold]
          trailingActions: (trailing is List<Widget>) ? trailing : null,
          automaticallyImplyLeading: automaticallyImplyLeading,

          // Platform configs
          // By default, only override the iOS trailing widget in the case that this.trailing
          // is a [Drawer]
          material: material,
          cupertino: (context, platform) => CupertinoNavigationBarData(
            trailing: (trailing is Widget) ? trailing : null,
          ),
        );
}
