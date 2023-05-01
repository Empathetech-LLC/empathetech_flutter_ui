library empathetech_flutter_ui;

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class EzPageView extends SingleChildScrollView {
  // SingleChildScrollView
  final Key? viewKey;
  final EdgeInsetsGeometry? padding;
  final bool? primary;
  final ScrollPhysics? physics;
  final DragStartBehavior dragStartBehavior;
  final Clip clipBehavior;
  final String? restorationId;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  // Column
  final Key? columnKey;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final List<Widget> children;

  /// Wraps a vertical [SingleChildScrollView] Widget with a [Column] child that holds [children]
  /// The vertical view is wrapped in a horizontal [SingleChildScrollView] to allow for bi-directional scrolling
  EzPageView({
    // SingleChildScrollView
    this.viewKey,
    this.padding,
    this.primary,
    this.physics,
    this.dragStartBehavior = DragStartBehavior.start,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,

    // Column
    this.columnKey,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: viewKey,
      padding: padding,
      primary: primary,
      physics: physics,
      dragStartBehavior: dragStartBehavior,
      clipBehavior: clipBehavior,
      restorationId: restorationId,
      keyboardDismissBehavior: keyboardDismissBehavior,
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        key: key,
        padding: padding,
        primary: primary,
        physics: physics,
        dragStartBehavior: dragStartBehavior,
        clipBehavior: clipBehavior,
        restorationId: restorationId,
        keyboardDismissBehavior: keyboardDismissBehavior,
        scrollDirection: Axis.vertical,
        child: Column(
          key: columnKey,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
          textBaseline: textBaseline,
          children: children,
        ),
      ),
    );
  }
}
