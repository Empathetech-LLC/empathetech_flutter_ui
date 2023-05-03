library empathetech_flutter_ui;

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class EzScreenScroller extends SingleChildScrollView {
  final EdgeInsetsGeometry? padding;
  final bool? primary;
  final ScrollPhysics? physics;
  final DragStartBehavior dragStartBehavior;
  final Clip clipBehavior;
  final String? restorationId;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final Widget child;

  /// [SingleChildScrollView] inside another [SingleChildScrollView]
  /// [Axis.horizontal] then [Axis.vertical]
  const EzScreenScroller({
    this.padding,
    this.primary,
    this.physics,
    this.dragStartBehavior = DragStartBehavior.start,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: padding,
      primary: primary,
      physics: physics,
      dragStartBehavior: dragStartBehavior,
      clipBehavior: clipBehavior,
      restorationId: restorationId,
      keyboardDismissBehavior: keyboardDismissBehavior,
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        padding: padding,
        primary: primary,
        physics: physics,
        dragStartBehavior: dragStartBehavior,
        clipBehavior: clipBehavior,
        restorationId: restorationId,
        keyboardDismissBehavior: keyboardDismissBehavior,
        scrollDirection: Axis.vertical,
        child: child,
      ),
    );
  }
}
