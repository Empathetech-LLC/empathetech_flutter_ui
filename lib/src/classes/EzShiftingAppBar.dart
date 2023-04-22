library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EzShiftingAppBar extends AppBar {
  final Key? key;

  /// Pass in from [PreferredSize] parent
  final double width;

  /// Pass in from [PreferredSize] parent
  final double height;

  /// Whether the UI should reverse for an [EzConfig.dominantSide] config of [Hand.left]
  /// Default: true
  final bool reverseHands;

  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;
  final double? elevation;
  final double? scrolledUnderElevation;

  /// Default: [defaultScrollNotificationPredicate]
  final bool Function(ScrollNotification) notificationPredicate;

  final Color? shadowColor;
  final Color? surfaceTintColor;
  final ShapeBorder? shape;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconThemeData? iconTheme;
  final IconThemeData? actionsIconTheme;

  /// Default: true
  final bool primary;

  /// Default: true
  final bool? centerTitle;

  /// Default: false
  final bool excludeHeaderSemantics;

  final double? titleSpacing;

  /// Default: 1.0
  final double toolbarOpacity;

  /// Default: 1.0
  final double bottomOpacity;

  final TextStyle? toolbarTextStyle;
  final TextStyle? titleTextStyle;
  final SystemUiOverlayStyle? systemOverlayStyle;

  /// [AppBar] that requires the [width] and [height] values from it's
  /// [PreferredSize] parent to do some auto-magical reshaping
  EzShiftingAppBar({
    this.key,
    required this.width,
    required this.height,
    required this.threshold,
    this.reverseHands = true,
    this.leading,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    this.scrolledUnderElevation,
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.shadowColor,
    this.surfaceTintColor,
    this.shape,
    this.backgroundColor,
    this.foregroundColor,
    this.iconTheme,
    this.actionsIconTheme,
    this.primary = true,
    this.centerTitle = true,
    this.excludeHeaderSemantics = false,
    this.titleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.toolbarTextStyle,
    this.titleTextStyle,
    this.systemOverlayStyle,
  }) : super(
          key: key,
          leading: _leading(leading, width),
          automaticallyImplyLeading: (leading == null) ? true : false,
          title: _title(title, width),
          actions: _actions(actions, width),
          flexibleSpace: flexibleSpace,
          bottom: bottom,
          elevation: elevation,
          shadowColor: shadowColor,
          shape: shape,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          iconTheme: iconTheme,
          actionsIconTheme: actionsIconTheme,
          primary: primary,
          centerTitle: centerTitle,
          titleSpacing: titleSpacing,
          toolbarOpacity: toolbarOpacity,
          bottomOpacity: bottomOpacity,
          toolbarHeight: height,
          leadingWidth: _leadingWidth(width, height),
          toolbarTextStyle: toolbarTextStyle,
          titleTextStyle: titleTextStyle,
          systemOverlayStyle: systemOverlayStyle,
        );

  static Widget? _leading(Widget? leading, double width) {
    return leading;
  }

  static double _leadingWidth(double width, double height) {
    return 0;
  }

  static Widget? _title(Widget? title, double width) {
    return title;
  }

  static List<Widget>? _actions(List<Widget>? actions, double width) {
    return actions;
  }
}
