library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Builds the "main screen" for pages built with [EzScaffold.standard]
Widget standardWindow({
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
Widget navWindow({
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
Widget webWindow({
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

BoxDecoration? imageBackground(String? path) {
  if (path == null || path == noImageKey) {
    return null;
  } else if (isAsset(path)) {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage(path),
        fit: BoxFit.fill,
      ),
    );
  } else {
    return BoxDecoration(
      image: DecorationImage(
        image: FileImage(File(path)),
        fit: BoxFit.fill,
      ),
    );
  }
}

/// Build a solid color background from [colorKey]s [EzConfig.prefs] value
BoxDecoration colorBackground({
  required String colorKey,
}) {
  return BoxDecoration(color: Color(EzConfig.prefs[colorKey]));
}

/// Quickly build a color gradient background
BoxDecoration gradientBackground({
  required List<Color> colors,
  Alignment begin = Alignment.topCenter,
  Alignment end = Alignment.bottomCenter,
  List<double>? stops,
}) {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: begin,
      end: end,
      colors: colors,
      stops: stops,
    ),
  );
}
