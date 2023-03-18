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
    MaterialScaffoldData androidConfig,
    CupertinoPageScaffoldData iosConfig) {
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

        // Android config
        material: (context, platform) => MaterialAppBarData(
          centerTitle: true,
          iconTheme: IconThemeData(color: themeTextColor),
        ),

        // iOS config
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

      material: (context, platform) => androidConfig,

      // iOS scaffold
      cupertino: (context, platform) => iosConfig,
    ),
  );
}

// Nav screen: Outer screen
Widget navScaffold(BuildContext context, String title, Widget body, PlatformNavBar navBar,
    MaterialScaffoldData androidConfig, CupertinoPageScaffoldData iosConfig) {
  // Gather theme data
  Color themeColor = Color(AppConfig.prefs[themeColorKey]);
  Color themeTextColor = Color(AppConfig.prefs[themeTextColorKey]);

  // Gesture detector makes it so keyboards close on screen tap
  return GestureDetector(
    onTap: () => AppConfig.focus.primaryFocus?.unfocus(),
    child: PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(title, style: getTextStyle(titleStyleKey)),
        backgroundColor: themeColor,

        // Android config
        material: (context, platform) => MaterialAppBarData(
          centerTitle: true,
          iconTheme: IconThemeData(color: themeTextColor),
        ),

        // iOS config
        cupertino: (context, platform) => CupertinoNavigationBarData(),
      ),

      body: body,

      bottomNavBar: navBar,

      // Android config
      material: (context, platform) => androidConfig,

      // iOS scaffold
      cupertino: (context, platform) => iosConfig,
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
