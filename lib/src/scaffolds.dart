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
    Drawer? androidHamburger,
    CupertinoNavigationBar? iosNavBar) {
  double margin = AppConfig.prefs[marginKey];

  // Gesture detector makes it so keyboards close on screen tap
  return GestureDetector(
    onTap: () => AppConfig.focus.primaryFocus?.unfocus(),
    child: PlatformScaffold(
      appBar: PlatformAppBar(title: PlatformText(title)),
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
      material: (context, platform) => MaterialScaffoldData(endDrawer: androidHamburger),
      cupertino: (context, platform) =>
          CupertinoPageScaffoldData(navigationBar: iosNavBar),
    ),
  );
}

// Nav screen: Outer screen
Widget navScaffold(BuildContext context, String title, Widget body,
    Drawer? androidHamburger, CupertinoNavigationBar? iosNavBar, PlatformNavBar navBar) {
  // Gesture detector makes it so keyboards close on screen tap
  return GestureDetector(
    onTap: () => AppConfig.focus.primaryFocus?.unfocus(),
    child: PlatformScaffold(
      appBar: PlatformAppBar(title: PlatformText(title)),
      body: body,
      material: (context, platform) => MaterialScaffoldData(endDrawer: androidHamburger),
      cupertino: (context, platform) =>
          CupertinoPageScaffoldData(navigationBar: iosNavBar),
      bottomNavBar: navBar,
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
