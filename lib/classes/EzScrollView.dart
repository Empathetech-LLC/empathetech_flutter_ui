library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class EzScrollView extends SingleChildScrollView {
  final Key? key;
  final Axis scrollDirection;

  /// Only useful when [scrollDirection] is [Axis.horizontal]
  /// Will reverse the contents of the [EzScrollView] when [EzConfig.dominantSide]
  /// is set to [Hand.left] and [reverseHands] is true
  final bool reverseHands;
  final bool reverse;
  final EdgeInsetsGeometry? padding;
  final bool? primary;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final Widget? child;
  final Clip clipBehavior;
  final DragStartBehavior dragStartBehavior;
  final String? restorationId;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final TextBaseline? textBaseline;
  final VerticalDirection verticalDirection;
  final List<Widget> children;

  /// Styles a [SingleChildScrollView] from [EzConfig.prefs]
  /// Dynamically switches between row/col based on [scrollDirection]
  /// Prefers the [children] list rather than [child] Widget
  EzScrollView({
    // SingleChildScrollView
    this.key,
    this.scrollDirection = Axis.vertical,
    this.reverseHands = false,
    this.reverse = false,
    this.padding,
    this.primary,
    this.physics = const BouncingScrollPhysics(),
    this.controller,
    this.child,
    this.clipBehavior = Clip.hardEdge,
    this.dragStartBehavior = DragStartBehavior.start,
    this.restorationId,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,

    // Row/Column
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.start,
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
        : (reverseHands && EzConfig.dominantSide == Hand.left)
            ? Row(
                mainAxisSize: mainAxisSize,
                mainAxisAlignment: mainAxisAlignment,
                crossAxisAlignment: crossAxisAlignment,
                textDirection: textDirection,
                textBaseline: textBaseline,
                verticalDirection: verticalDirection,
                children: children.reversed.toList(),
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
      physics: physics,
      controller: controller,
      child: child ?? core,
      dragStartBehavior: dragStartBehavior,
      clipBehavior: clipBehavior,
      restorationId: restorationId,
      keyboardDismissBehavior: keyboardDismissBehavior,
    );
  }
}
