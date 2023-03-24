library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Builds a [PlatformScaffold] from the passed values that will
/// automatically update alongside [AppConfig]
Widget ezScaffold({
  required BuildContext context,
  required String title,
  required Widget body,
  required DecorationImage? backgroundImage,
  required Color backgroundColor,
  required MaterialScaffoldData materialConfig,
}) {
  return GestureDetector(
    // Close open keyboard(s) on tap
    onTap: () => AppConfig.focus.primaryFocus?.unfocus(),

    child: PlatformScaffold(
      appBar: PlatformAppBar(title: Text(title, style: getTextStyle(titleStyleKey))),

      body: Container(
        width: screenWidth(context),
        height: screenHeight(context),

        // Background
        decoration: BoxDecoration(color: backgroundColor, image: backgroundImage),

        // Build space
        child: Container(child: body, margin: EdgeInsets.all(AppConfig.prefs[marginKey])),
      ),

      // Platform specific configurations
      material: (context, platform) => materialConfig,
      cupertino: (context, platform) => m2cScaffold(context, materialConfig, title),
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
  required MaterialScaffoldData materialConfig,
}) {
  return GestureDetector(
    // Close open keyboard(s) on tap
    onTap: () => AppConfig.focus.primaryFocus?.unfocus(),

    child: PlatformScaffold(
      appBar: PlatformAppBar(title: Text(title, style: getTextStyle(titleStyleKey))),

      body: body,

      bottomNavBar: PlatformNavBar(
        currentIndex: index,
        itemChanged: onChanged,
        items: items,
      ),

      // Platform specific configurations
      material: (context, platform) => materialConfig,
      cupertino: (context, platform) => m2cScaffold(context, materialConfig, title),
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
