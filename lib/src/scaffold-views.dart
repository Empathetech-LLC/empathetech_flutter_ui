library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Builds the "main screen" for pages built with [EzScaffold.standard]
Widget standardView({
  required BuildContext context,
  BoxDecoration? background,
  required Widget body,
}) {
  return Container(
    width: screenWidth(context),
    height: screenHeight(context),

    // Background
    decoration: background,

    // Build space
    child: Container(
      child: body,
      margin: EdgeInsets.all(EzConfig.prefs[marginKey]),
    ),
  );
}

/// Builds the "main screen" for pages built with [EzScaffold.nav]
Widget navView({
  required BuildContext context,
  required Widget body,
  BoxDecoration? background,
}) {
  double margin = EzConfig.prefs[marginKey];

  return Container(
    height: screenHeight(context),
    width: screenWidth(context),

    // Background
    decoration: background,

    // Build space
    child: Container(child: body, margin: EdgeInsets.all(margin)),
  );
}

/// Builds the "main screen" for pages built with [EzScaffold.web]
Widget webView({
  required BuildContext context,
  required Color backgroundColor,
  BoxDecoration? background,
  required Widget body,
}) {
  return Container(
    width: screenWidth(context),
    height: screenHeight(context),

    // Background
    decoration: background,

    // Build space
    child: Container(
      child: body,
      margin: EdgeInsets.all(EzConfig.prefs[marginKey]),
    ),
  );
}
