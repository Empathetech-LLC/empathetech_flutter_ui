library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// Styles a [SingleChildScrollView] from [AppConfig.prefs]
/// Dynamically switches between row/col based on [direction]
Widget ezScrollView({
  required List<Widget> children,
  bool centered = false,
  MainAxisSize axisSize = MainAxisSize.min,
  MainAxisAlignment axisAlign = MainAxisAlignment.spaceEvenly,
  Axis direction = Axis.vertical,
}) {
  SingleChildScrollView core = SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    scrollDirection: direction,
    child: direction == Axis.vertical
        ? Column(
            mainAxisSize: axisSize,
            mainAxisAlignment: axisAlign,
            children: children,
          )
        : Row(
            mainAxisSize: axisSize,
            mainAxisAlignment: axisAlign,
            children: children,
          ),
  );

  return centered ? Center(child: core) : core;
}

/// Styles a [ExpansionTile] from [AppConfig.prefs]
Widget ezList({
  required String title,
  required List<Widget> body,
  bool open = false,
}) {
  TextStyle titleStyle = getTextStyle(titleStyleKey);
  Color themeColor = Color(AppConfig.prefs[themeColorKey]);
  Color themeTextColor = Color(AppConfig.prefs[themeTextColorKey]);

  double padding = AppConfig.prefs[paddingKey];

  return ExpansionTile(
    title: Text(title, style: titleStyle),
    children: body,
    initiallyExpanded: open,
    onExpansionChanged: (bool open) => AppConfig.focus.primaryFocus?.unfocus(),

    // Padding
    tilePadding: EdgeInsets.all(padding),
    childrenPadding: EdgeInsets.all(padding),

    // Collapsed theme
    collapsedBackgroundColor: themeColor,
    collapsedTextColor: themeTextColor,
    collapsedIconColor: themeTextColor,

    // Open theme
    backgroundColor: themeColor,
    textColor: themeTextColor,
    iconColor: themeTextColor,
  );
}
