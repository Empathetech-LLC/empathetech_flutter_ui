library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Builds the "main screen" for pages built with [EzScaffold.standard]
Widget standardWindow({
  required BuildContext context,
  DecorationImage? backgroundImage,
  required Widget body,
}) {
  return Container(
    width: screenWidth(context),
    height: screenHeight(context),

    // Background
    decoration: BoxDecoration(image: backgroundImage),

    // Build space
    child: Container(
      child: body,
      margin: EdgeInsets.all(EzConfig.prefs[marginKey]),
    ),
  );
}

/// Builds the "main screen" for pages built with [EzScaffold.nav]
Widget navWindow({
  required BuildContext context,
  required Widget body,
  required DecorationImage? backgroundImage,
}) {
  double margin = EzConfig.prefs[marginKey];

  return Container(
    height: screenHeight(context),
    width: screenWidth(context),

    // Background
    decoration: BoxDecoration(image: backgroundImage),

    // Build space
    child: Container(child: body, margin: EdgeInsets.all(margin)),
  );
}

/// Builds the "main screen" for pages built with [EzScaffold.web]
Widget webWindow({
  required BuildContext context,
  required Color backgroundColor,
  DecorationImage? backgroundImage,
  required Widget body,
}) {
  return Container(
    width: screenWidth(context),
    height: screenHeight(context),

    // Background
    decoration: BoxDecoration(color: backgroundColor, image: backgroundImage),

    // Build space
    child: Container(
      child: body,
      margin: EdgeInsets.all(EzConfig.prefs[marginKey]),
    ),
  );
}
