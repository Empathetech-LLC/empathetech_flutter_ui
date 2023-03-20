library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Builds a [PlatformScaffold] from the passed values that will
/// automatically update alongside [AppConfig]
Widget ezScaffold(
    BuildContext context,
    String title,
    Widget body,
    DecorationImage? backgroundImage,
    Color backgroundColor,
    MaterialScaffoldData androidConfig,
    CupertinoPageScaffoldData iosConfig) {
  return GestureDetector(
    // Close open keyboard(s) on tap
    onTap: () => AppConfig.focus.primaryFocus?.unfocus(),

    child: PlatformScaffold(
      appBar: PlatformAppBar(title: Text(title)),
      body: Container(
        width: screenWidth(context),
        height: screenHeight(context),

        // Background
        decoration: BoxDecoration(color: backgroundColor, image: backgroundImage),

        // Build space
        child: Container(child: body, margin: EdgeInsets.all(AppConfig.prefs[marginKey])),
      ),

      // Platform specific configurations
      material: (context, platform) => androidConfig,
      cupertino: (context, platform) => iosConfig,
    ),
  );
}

/// Builds a [PlatformScaffold] with a [BottomNavigationBar]/[CupertinoTabBar]
/// from the passed values that will automatically update alongside [AppConfig]
Widget ezNavScaffold(
    BuildContext context,
    String title,
    Widget body,
    int? index,
    void Function(int)? onChanged,
    List<BottomNavigationBarItem>? items,
    MaterialScaffoldData androidConfig,
    CupertinoPageScaffoldData iosConfig) {
  return GestureDetector(
    // Close open keyboard(s) on tap
    onTap: () => AppConfig.focus.primaryFocus?.unfocus(),

    child: PlatformScaffold(
      appBar: PlatformAppBar(title: Text(title)),

      body: body,

      bottomNavBar: PlatformNavBar(
        currentIndex: index,
        itemChanged: onChanged,
        items: items,

        // Platform specific configurations
        material: (context, platform) => MaterialNavBarData(),
        cupertino: (context, platform) => CupertinoTabBarData(),
      ),

      // Platform specific configurations
      material: (context, platform) => androidConfig,
      cupertino: (context, platform) => iosConfig,
    ),
  );
}

/// Builds the "main screen" for and pages built with [ezNavScaffold]
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
