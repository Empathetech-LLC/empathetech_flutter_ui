library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Builds a [PlatformScaffold] styled from [AppConfig.prefs]
/// [drawerHeader] and [drawerBody] are used to build an end [Drawer] for [Material]
/// and a [CupertinoActionSheet] for Cupertino
Widget ezScaffold({
  required BuildContext context,
  required String title,
  required DecorationImage? backgroundImage,
  required Color backgroundColor,
  required Widget body,
  Widget? drawerHeader,
  List<Widget>? drawerBody,
  Widget? fab,
}) {
  Widget baseBody = Container(
    width: screenWidth(context),
    height: screenHeight(context),

    // Background
    decoration: BoxDecoration(color: backgroundColor, image: backgroundImage),

    // Build space
    child: Container(child: body, margin: EdgeInsets.all(AppConfig.prefs[marginKey])),
  );

  return GestureDetector(
    // Close open keyboard(s) on tap
    onTap: () => AppConfig.focus.primaryFocus?.unfocus(),

    child: PlatformScaffold(
      appBar: PlatformAppBar(title: Text(title, style: getTextStyle(titleStyleKey))),

      // Platform specific configurations
      material: (context, platform) => MaterialScaffoldData(
        body: baseBody,
        endDrawer: ezDrawer(
          context: context,
          platform: platform,
          header: drawerHeader,
          body: drawerBody,
        ),
        floatingActionButton: fab,
      ),
      cupertino: (context, platform) => CupertinoPageScaffoldData(
        body: (fab != null)
            ? Stack(
                children: [
                  baseBody,
                  Positioned(
                    bottom: 32.0,
                    right: 32.0,
                    child: fab,
                  ),
                ],
              )
            : baseBody,
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            title,
            style: getTextStyle(titleStyleKey),
            textAlign: TextAlign.center,
          ),
          trailing: ezDrawer(
            context: context,
            platform: platform,
            header: drawerHeader,
            body: drawerBody,
          ),
        ),
      ),
    ),
  );
}

/// Builds a [PlatformScaffold] with a [BottomNavigationBar]/[CupertinoTabBar]
/// from the passed values that will automatically update alongside [AppConfig]
Widget ezNavScaffold({
  required BuildContext context,
  required String title,
  required Widget body,
  required int? index,
  required void Function(int)? onChanged,
  required List<BottomNavigationBarItem>? items,
  Widget? drawerHeader,
  List<Widget>? drawerBody,
  Widget? fab,
}) {
  Color themeColor = Color(AppConfig.prefs[themeColorKey]);
  Color themeTextColor = Color(AppConfig.prefs[themeTextColorKey]);
  Color buttonColor = Color(AppConfig.prefs[buttonColorKey]);

  return GestureDetector(
    // Close open keyboard(s) on tap
    onTap: () => AppConfig.focus.primaryFocus?.unfocus(),

    child: PlatformScaffold(
      appBar: PlatformAppBar(title: Text(title, style: getTextStyle(titleStyleKey))),

      bottomNavBar: PlatformNavBar(
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
      ),

      // Platform specific configurations
      material: (context, platform) => MaterialScaffoldData(
        body: body,
        endDrawer: ezDrawer(
          context: context,
          platform: platform,
          header: drawerHeader,
          body: drawerBody,
        ),
        floatingActionButton: fab,
      ),
      cupertino: (context, platform) => CupertinoPageScaffoldData(
        body: (fab != null)
            ? Stack(
                children: [
                  body,
                  Positioned(
                    bottom: 32.0,
                    right: 32.0,
                    child: fab,
                  ),
                ],
              )
            : body,
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            title,
            style: getTextStyle(titleStyleKey),
            textAlign: TextAlign.center,
          ),
          trailing: ezDrawer(
            context: context,
            platform: platform,
            header: drawerHeader,
            body: drawerBody,
          ),
        ),
      ),
    ),
  );
}

/// Builds the "main screen" for and pages built with [ezNavScaffold]
Widget navWindow({
  required BuildContext context,
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
