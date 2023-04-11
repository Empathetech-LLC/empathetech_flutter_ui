library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Builds the "main screen" for pages built with [EzScaffold.standard]
Widget standardWindow(
  BuildContext context, {
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

/// Builds the "main screen" for pages built with [EzScaffold.nav]
Widget navWindow(
  BuildContext context, {
  required Widget body,
  required DecorationImage? backgroundImage,
  required Color backgroundColor,
}) {
  double margin = EzConfig.prefs[marginKey];

  return Container(
    height: screenHeight(context),
    width: screenWidth(context),

    // Background
    decoration: BoxDecoration(color: backgroundColor, image: backgroundImage),

    // Build space
    child: Container(child: body, margin: EdgeInsets.all(margin)),
  );
}

/// Builds the "main screen" for pages built with [EzScaffold.web]
Widget webWindow(
  BuildContext context, {
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
