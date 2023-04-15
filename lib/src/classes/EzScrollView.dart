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

  final TextDirection? textDirection;
  final TextBaseline? textBaseline;

  /// Default: [VerticalDirection.down]
  final VerticalDirection verticalDirection;

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
    this.textDirection,
    this.textBaseline,
    this.verticalDirection = VerticalDirection.down,
  });

  /// Get a matching [CrossAxisAlignment] from the current [mainAxisAlignment]
  CrossAxisAlignment matchCrossAxis() {
    switch (mainAxisAlignment) {
      case MainAxisAlignment.start:
        return CrossAxisAlignment.start;
      case MainAxisAlignment.end:
        return CrossAxisAlignment.end;
      case MainAxisAlignment.center:
      default:
        return CrossAxisAlignment.center;
    }
  }

  Widget _buildCore() {
    return (scrollDirection == Axis.vertical)
        ? Column(
            mainAxisSize: mainAxisSize,
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: matchCrossAxis(),
            textDirection: textDirection,
            textBaseline: textBaseline,
            verticalDirection: verticalDirection,
            children: children,
          )
        : Row(
            mainAxisSize: mainAxisSize,
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: matchCrossAxis(),
            textDirection: textDirection,
            textBaseline: textBaseline,
            verticalDirection: verticalDirection,
            children: children,
          );
  }

  @override
  Widget build(BuildContext context) {
    Widget core = _buildCore();

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
