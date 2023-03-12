library ez_ui;

import 'helpers.dart';
import 'constants.dart';
import 'app-config.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

// Standard full screen scaffold
Widget standardScaffold(BuildContext context, String title, Widget body,
    DecorationImage? backgroundImage, Color backgroundColor, Drawer? hamburger) {
  double margin = AppConfig.prefs[marginKey];

  // Gesture detector makes it so keyboards close on screen tap
  return GestureDetector(
    onTap: () => AppConfig.focus.primaryFocus?.unfocus(),
    child: Scaffold(
      appBar: AppBar(title: PlatformText(title)),
      body: Container(
        width: screenWidth(context),
        height: screenHeight(context),
        decoration: BoxDecoration(
          color: backgroundColor,
          image: backgroundImage,
        ),

        // Wrapping the passed body in a margin'd container means UI code can always...
        // ...use the full context width && have consistent margins
        child: Container(
          child: body,
          margin: EdgeInsets.all(margin),
        ),
      ),
      endDrawer: hamburger,
    ),
  );
}

// Nav screen: Outer screen
Widget navScaffold(BuildContext context, String title, Widget body, Drawer? hamburger,
    BottomNavigationBar navBar) {
  // Gesture detector makes it so keyboards close on screen tap
  return GestureDetector(
    onTap: () => AppConfig.focus.primaryFocus?.unfocus(),
    child: Scaffold(
      appBar: AppBar(title: PlatformText(title)),
      body: body,
      endDrawer: hamburger,
      bottomNavigationBar: navBar,
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
    decoration: BoxDecoration(
      color: backgroundColor,
      image: backgroundImage,
    ),

    // Wrapping the passed body in a margin'd container means UI code can always...
    // ...use the full context width && have consistent margins
    child: Container(
      child: body,
      margin: EdgeInsets.all(margin),
    ),
  );
}
