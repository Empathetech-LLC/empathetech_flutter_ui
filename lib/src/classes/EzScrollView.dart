library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class EzScrollView extends SingleChildScrollView {
  final Key? key;
  final Axis scrollDirection;
  final bool reverse;
  final EdgeInsetsGeometry? padding;
  final bool? primary;

  /// Default: [BouncingScrollPhysics]
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final Widget? child;

  /// Default: [Clip.hardEdge]
  final Clip clipBehavior;

  /// Default: [DragStartBehavior.start]
  final DragStartBehavior dragStartBehavior;

  final String? restorationId;

  /// Default: [ScrollViewKeyboardDismissBehavior.manual]
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  /// Default: [MainAxisSize.min]
  final MainAxisSize mainAxisSize;

  /// Default: [MainAxisAlignment.spaceEvenly]
  final MainAxisAlignment mainAxisAlignment;

  /// Default: [CrossAxisAlignment.center]
  final CrossAxisAlignment crossAxisAlignment;

  final TextDirection? textDirection;
  final TextBaseline? textBaseline;

  /// Default: [VerticalDirection.down]
  final VerticalDirection verticalDirection;

  final List<Widget> children;

  /// Styles a [SingleChildScrollView] from [EzConfig.prefs]
  /// Dynamically switches between row/col based on [direction]
  /// Uses a [children] list rather than [child] Widget
  /// Optionally overwrite with -> child: child && children: []
  EzScrollView({
    // SingleChildScrollView
    this.key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.padding,
    this.primary,
    this.physics,
    this.controller,
    this.child,
    this.clipBehavior = Clip.hardEdge,
    this.dragStartBehavior = DragStartBehavior.start,
    this.restorationId,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,

    // Row/Column
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.textBaseline,
    this.verticalDirection = VerticalDirection.down,
    required this.children,
  });

  Widget _buildCore() {
    return (scrollDirection == Axis.vertical)
        ? Column(
            mainAxisSize: mainAxisSize,
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            textDirection: textDirection,
            textBaseline: textBaseline,
            verticalDirection: verticalDirection,
            children: children,
          )
        : Row(
            mainAxisSize: mainAxisSize,
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
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
      child: child ?? core,
      dragStartBehavior: dragStartBehavior,
      clipBehavior: clipBehavior,
      restorationId: restorationId,
      keyboardDismissBehavior: keyboardDismissBehavior,
    );
  }
}
