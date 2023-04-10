library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Enumerator for selecting the type of Scaffold that is being built
enum ScaffoldType {
  standard,
  nav,
}

class EZScaffold extends StatelessWidget {
  final Widget title;
  final DecorationImage? backgroundImage;
  final Color backgroundColor;
  final Widget body;
  final Widget? drawerHeader;
  final List<Widget>? drawerBody;
  final Widget? fab;
  final int? index;
  final void Function(int)? onChanged;
  final List<BottomNavigationBarItem>? items;
  final ScaffoldType _type;

  /// Builds a [PlatformScaffold] styled from [AppConfig.prefs]
  /// [drawerHeader] and [drawerBody] are used to build an end [Drawer] for [Material]
  /// and a [CupertinoActionSheet] for Cupertino
  EZScaffold({
    required this.title,
    this.backgroundImage,
    required this.backgroundColor,
    required this.body,
    this.drawerHeader,
    this.drawerBody,
    this.fab,
    this.index,
    this.onChanged,
    this.items,
  })  : _type = ScaffoldType.standard,
        assert(index == null || onChanged != null);

  /// Builds a [PlatformScaffold] with a [BottomNavigationBar]/[CupertinoTabBar]
  /// from the passed values that will automatically update alongside [AppConfig]
  /// use [navWindow] for the [body]
  EZScaffold.nav(
    BuildContext context, {
    required this.title,
    required this.body,
    required this.index,
    required this.onChanged,
    required this.items,
    this.drawerHeader,
    this.drawerBody,
    this.fab,
    this.backgroundImage,
  })  : _type = ScaffoldType.nav,
        backgroundColor = Color(AppConfig.prefs[themeColorKey]),
        assert(index != null && onChanged != null);

  // Returns the appropriate body widget based on constructor variables
  Widget buildBody(BuildContext context, ScaffoldType type) {
    switch (type) {
      case ScaffoldType.standard:
        return Container(
          width: screenWidth(context),
          height: screenHeight(context),

          // Background
          decoration: BoxDecoration(color: backgroundColor, image: backgroundImage),

          // Build space
          child: Container(
            child: body,
            margin: EdgeInsets.all(AppConfig.prefs[marginKey]),
          ),
        );
      case ScaffoldType.nav:
        return body;
    }
  }

  @override
  Widget build(BuildContext context) {
    late Color themeColor = Color(AppConfig.prefs[themeColorKey]);
    late Color themeTextColor = Color(AppConfig.prefs[themeTextColorKey]);
    late Color buttonColor = Color(AppConfig.prefs[buttonColorKey]);

    late double margin = AppConfig.prefs[marginKey];

    return GestureDetector(
      // Close open keyboard(s) on tap
      onTap: () => AppConfig.focus.primaryFocus?.unfocus(),

      child: PlatformScaffold(
        // App bar
        appBar: PlatformAppBar(
          title: title,
          cupertino: (context, platform) => CupertinoNavigationBarData(
            trailing: ezDrawer(
              context,
              platform: platform,
              header: drawerHeader,
              body: drawerBody,
            ),
          ),
        ),

        // Body
        material: (context, platform) => MaterialScaffoldData(
          body: buildBody(context, _type),
          endDrawer: ezDrawer(
            context,
            platform: platform,
            header: drawerHeader,
            body: drawerBody,
          ),
          floatingActionButton: fab,
        ),
        cupertino: (context, platform) => CupertinoPageScaffoldData(
          body: SafeArea(
            child: (fab != null)
                ? Stack(
                    children: [
                      buildBody(context, _type),
                      Positioned(
                        bottom: 16.0 + margin,
                        right: 16.0 + margin,
                        child: fab ?? Container(),
                      ),
                    ],
                  )
                : buildBody(context, _type),
          ),
        ),

        // Nav bar
        bottomNavBar: index != null && onChanged != null && items != null
            ? PlatformNavBar(
                currentIndex: index!,
                itemChanged: onChanged!,
                items: items!,

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

/// Builds the "main screen" for and pages built with [EZScaffold.nav]
Widget navWindow(
  BuildContext context, {
  required Widget body,
  required DecorationImage? backgroundImage,
  required Color backgroundColor,
}) {
  double margin = AppConfig.prefs[marginKey];

  return Container(
    height: screenHeight(context),
    width: screenWidth(context),

    // Background
    decoration: BoxDecoration(color: backgroundColor, image: backgroundImage),

    // Build space
    child: Container(child: body, margin: EdgeInsets.all(margin)),
  );
}
