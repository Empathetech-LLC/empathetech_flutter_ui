library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzScrollView extends SingleChildScrollView {
  final Key? key;
  final Axis scrollDirection;
  final bool reverse;
  final EdgeInsetsGeometry? padding;
  final bool? primary;

  /// Default:
  /// [BouncingScrollPhysics]
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final Widget? child;
  final List<Widget> children;

  /// Default:
  /// [Clip.hardEdge]
  final Clip clipBehavior;
  final String? restorationId;

  /// Default:
  /// [ScrollViewKeyboardDismissBehavior.manual]
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final bool centered;

  /// Default:
  /// [MainAxisSize.min]
  final MainAxisSize mainAxisSize;

  /// Default:
  /// [MainAxisAlignment.spaceEvenly]
  final MainAxisAlignment mainAxisAlignment;

  /// Styles a [SingleChildScrollView] from [EzConfig.prefs]
  /// Dynamically switches between row/col based on [direction]
  /// Uses a [children] list rather than [child] Widget
  /// Optionally overwrite with -> child: child && children: []
  EzScrollView({
    this.key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.padding,
    this.primary,
    this.physics,
    this.controller,
    this.child,
    required this.children,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.centered = false,
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
  });

  @override
  Widget build(BuildContext context) {
    Widget core = scrollDirection == Axis.vertical
        ? Column(
            mainAxisSize: mainAxisSize,
            mainAxisAlignment: mainAxisAlignment,
            children: children,
          )
        : Row(
            mainAxisSize: mainAxisSize,
            mainAxisAlignment: mainAxisAlignment,
            children: children,
          );

    return SingleChildScrollView(
      key: key,
      scrollDirection: scrollDirection,
      reverse: reverse,
      padding: padding,
      primary: primary,
      physics: physics ?? BouncingScrollPhysics(),
      controller: controller,
      child: child ?? (centered ? Center(child: core) : core),
      clipBehavior: clipBehavior,
      restorationId: restorationId,
      keyboardDismissBehavior: keyboardDismissBehavior,
    );
  }
}
