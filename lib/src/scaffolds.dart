library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

// Standard full screen scaffold
Widget standardScaffold(
    BuildContext context,
    String title,
    Widget body,
    DecorationImage? backgroundImage,
    Color backgroundColor,
    Drawer? hamburger,
    CupertinoNavigationBar? iosNavBar) {
  // Gather theme data
  double margin = AppConfig.prefs[marginKey];
  Color themeColor = Color(AppConfig.prefs[themeColorKey]);
  Color themeTextColor = Color(AppConfig.prefs[themeTextColorKey]);

  // Gesture detector makes it so keyboards close on screen tap
  return GestureDetector(
    onTap: () => AppConfig.focus.primaryFocus?.unfocus(),
    child: PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(title, style: getTextStyle(titleStyleKey)),
        backgroundColor: themeColor,

        // Android app bar
        material: (context, platform) => MaterialAppBarData(
          centerTitle: true,
          iconTheme: IconThemeData(color: themeTextColor),
        ),

        // iOS app bar
        cupertino: (context, platform) => CupertinoNavigationBarData(),
      ),
      body: Container(
        width: screenWidth(context),
        height: screenHeight(context),

        // Background
        decoration: BoxDecoration(color: backgroundColor, image: backgroundImage),

        // Build space
        child: Container(child: body, margin: EdgeInsets.all(margin)),
      ),

      // Android scaffold
      material: (context, platform) => MaterialScaffoldData(endDrawer: hamburger),

      // iOS scaffold
      cupertino: (context, platform) =>
          CupertinoPageScaffoldData(navigationBar: iosNavBar),
    ),
  );
}

// Nav screen: Outer screen
Widget navScaffold(BuildContext context, String title, Widget body, Drawer? hamburger,
    CupertinoNavigationBar? iosNavBar, PlatformNavBar navBar) {
  // Gesture detector makes it so keyboards close on screen tap
  return GestureDetector(
    onTap: () => AppConfig.focus.primaryFocus?.unfocus(),
    child: PlatformScaffold(
      appBar: PlatformAppBar(title: Text(title)),
      body: body,
      bottomNavBar: navBar,

      // Android scaffold
      material: (context, platform) => MaterialScaffoldData(endDrawer: hamburger),

      // iOS scaffold
      cupertino: (context, platform) =>
          CupertinoPageScaffoldData(navigationBar: iosNavBar),
    ),
  );
}

// Nav screen: Inner screen
Widget navWindow(BuildContext context, Widget body, DecorationImage? backgroundImage,
    Color backgroundColor) {
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
