library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Builds the "main screen" for pages built with [EzScaffold]
Container ezView({
  required BuildContext context,
  BoxDecoration? background,
  required Widget body,
}) {
  return Container(
    width: widthOf(context),
    height: heightOf(context),

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
Container ezNavView({
  required BuildContext context,
  BoxDecoration? background,
  required Widget body,
}) {
  double margin = EzConfig.prefs[marginKey];

  return Container(
    height: heightOf(context),
    width: widthOf(context),

    // Background
    decoration: background,

    // Build space
    child: Container(child: body, margin: EdgeInsets.all(margin)),
  );
}

/// Builds the "main screen" for pages built with [EzWebScaffold]
Container ezWebView({
  required BuildContext context,
  BoxDecoration? background,
  required Widget body,
}) {
  return Container(
    width: widthOf(context),
    height: heightOf(context),

    // Background
    decoration: background,

    // Build space
    child: Container(
      child: body,
      margin: EdgeInsets.all(EzConfig.prefs[marginKey]),
    ),
  );
}
