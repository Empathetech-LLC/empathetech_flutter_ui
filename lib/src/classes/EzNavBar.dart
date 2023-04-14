library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzNavBar extends PlatformNavBar {
  final Key? key;
  final Key? widgetKey;

  /// Default:
  /// [EzConfig.prefs] -> themeColorKey
  final Color? backgroundColor;
  final List<BottomNavigationBarItem>? items;
  final void Function(int)? itemChanged;
  final int? currentIndex;
  final double? height;
  final MaterialNavBarData Function(BuildContext, PlatformTarget)? material;
  final CupertinoTabBarData Function(BuildContext, PlatformTarget)? cupertino;

  /// Styles a [PlatformAppBar] with [EzConfig.prefs]
  EzNavBar({
    this.key,
    this.widgetKey,
    this.backgroundColor,
    this.items,
    this.itemChanged,
    this.currentIndex,
    this.height,
    this.material,
    this.cupertino,
  }) : super(
          key: key,
          widgetKey: widgetKey,
          backgroundColor: backgroundColor ?? EzConfig.prefs[themeColorKey],
          items: items,
          itemChanged: itemChanged,
          currentIndex: currentIndex,
          height: height,
          material: material,
          cupertino: cupertino,
        );
}
