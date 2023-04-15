library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Builds the "main screen" for pages built with [EzScaffold]
Container standardView({
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

/// Builds the "main screen" for pages built with [EzScaffold] that use a [PlatformNavBar]
Container navView({
  required BuildContext context,
  BoxDecoration? background,
  required Widget body,
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

/// Builds the "main screen" for pages built with [EzWebScaffold]
Container webView({
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
