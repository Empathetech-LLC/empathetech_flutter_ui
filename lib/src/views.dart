library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Styles a [SingleChildScrollView] from [AppConfig.prefs]
/// Dynamically switches between row/col based on [direction]
Widget ezScrollView({
  required List<Widget> children,
  bool centered = false,
  MainAxisSize mainAxisSize = MainAxisSize.min,
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceEvenly,
  Axis direction = Axis.vertical,
}) {
  SingleChildScrollView core = SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    scrollDirection: direction,
    child: direction == Axis.vertical
        ? Column(
            mainAxisSize: mainAxisSize,
            mainAxisAlignment: mainAxisAlignment,
            children: children,
          )
        : Row(
            mainAxisSize: mainAxisSize,
            mainAxisAlignment: mainAxisAlignment,
            children: children,
          ),
  );

  return centered ? Center(child: core) : core;
}

/// Wraps [PlatformListTile]s in an [ezScrollView] with a [title]
/// Optionally provide a height limit, 1/3 [screenHeight] will be used as default
/// Optionally provide a [trailingAction] if an action button is paired with the list
Widget ezList(
  BuildContext context, {
  required String title,
  required List<Widget> items,
  double? customHeight,
  Widget? trailingAction,
}) {
  Color themeColor = Color(AppConfig.prefs[themeColorKey]);
  TextStyle titleStyle = getTextStyle(titleStyleKey);

  List<Widget> children = [
    Text(title, style: titleStyle),
    ezScrollView(children: items),
  ];

  if (trailingAction != null) children.add(trailingAction);

  return Container(
    width: screenWidth(context),
    height: customHeight ?? screenHeight(context) / 3.0,
    decoration: BoxDecoration(
      color: themeColor.withOpacity(themeColor.opacity * 0.75),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
    ),
  );
}
