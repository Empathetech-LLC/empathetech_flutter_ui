library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Enumerator for selecting the type of Scaffold that is being built
enum ScaffoldType {
  standard,
  nav,
  web,
}

class EzScaffold extends StatelessWidget {
  final Key? key;
  final Key? widgetKey;
  final BoxDecoration background;
  final PlatformAppBar appBar;
  final Widget body;
  final Widget? fab;
  final int? index;
  final List<BottomNavigationBarItem>? items;
  final void Function(int)? onChanged;

  /// Standardizes building a [PlatformScaffold] styled from [EzConfig.prefs]
  /// Handling platform differences, like [floatingActionButton]s on iOS
  /// It's recommended to use [standardWindow] for the [body]
  EzScaffold({
    this.key,
    this.widgetKey,
    required this.background,
    required this.appBar,
    required this.body,
    this.fab,
    this.index,
    this.items,
    this.onChanged,
  }) : assert(index == null && onChanged == null && items == null);

  /// [EzScaffold] with a [PlatformNavBar]
  /// It's recommended to use [navWindow] for the [body]
  EzScaffold.nav({
    this.key,
    this.widgetKey,
    required this.background,
    required this.appBar,
    required this.body,
    this.fab,
    required this.index,
    required this.items,
    required this.onChanged,
  }) : assert(index != null && onChanged != null && items != null);

  /// [EzScaffold] designed for use on web
  /// It's recommended to use [webWindow] for the [body]
  EzScaffold.web({
    this.key,
    this.widgetKey,
    required this.background,
    required this.appBar,
    required this.body,
    this.fab,
    this.index,
    this.onChanged,
    this.items,
  });

  @override
  Widget build(BuildContext context) {
    late Color themeColor = Color(EzConfig.prefs[themeColorKey]);
    late Color themeTextColor = Color(EzConfig.prefs[themeTextColorKey]);
    late Color buttonColor = Color(EzConfig.prefs[buttonColorKey]);

    late double margin = EzConfig.prefs[marginKey];

    return GestureDetector(
      // Close open keyboard(s) on tap
      onTap: () => EzConfig.focus.primaryFocus?.unfocus(),

      child: PlatformScaffold(
        appBar: appBar,

        // Body
        material: (context, platform) => MaterialScaffoldData(
          body: Container(
            decoration: background,
            child: SafeArea(child: body),
          ),
          floatingActionButton: fab,
        ),
        cupertino: (context, platform) => CupertinoPageScaffoldData(
          body: Container(
            decoration: background,
            child: SafeArea(
              child: (fab == null)
                  ? body
                  : Stack(
                      children: [
                        body,
                        Positioned(
                          bottom: 16.0 + margin,
                          right: 16.0 + margin,
                          child: fab ?? Container(),
                        ),
                      ],
                    ),
            ),
          ),
        ),

        // Nav bar
        bottomNavBar: (index != null && onChanged != null && items != null)
            ? PlatformNavBar(
                currentIndex: index,
                itemChanged: onChanged,
                items: items,

                // Platform specific configurations
                material: (context, platform) => MaterialNavBarData(
                  backgroundColor: themeColor,
                  selectedItemColor: buttonColor,
                  selectedIconTheme: IconThemeData(color: buttonColor),
                  unselectedItemColor: themeTextColor,
                  unselectedIconTheme: IconThemeData(color: themeTextColor),
                ),
                cupertino: (context, platform) => CupertinoTabBarData(
                  backgroundColor: themeColor,
                  activeColor: buttonColor,
                ),
              )
            : null,
      ),
    );
  }
}
