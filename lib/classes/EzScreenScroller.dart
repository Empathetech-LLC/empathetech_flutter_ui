library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class EzScreenScroller extends StatelessWidget {
  final Key? key;
  final ScrollPhysics physics;
  final Clip clipBehavior;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final List<Widget> children;

  /// Wraps a vertical [EzScrollView] in a horizontal [EzScrollView]
  const EzScreenScroller({
    this.key,
    this.physics = const BouncingScrollPhysics(),
    this.clipBehavior = Clip.hardEdge,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return EzScrollView(
      key: key,
      scrollDirection: Axis.horizontal,
      primary: false,
      reverseHands: false,
      reverse: false,
      physics: physics,
      clipBehavior: clipBehavior,
      dragStartBehavior: dragStartBehavior,
      keyboardDismissBehavior: keyboardDismissBehavior,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      verticalDirection: VerticalDirection.down,
      child: EzScrollView(
        scrollDirection: Axis.vertical,
        primary: true,
        reverseHands: false,
        reverse: false,
        physics: physics,
        clipBehavior: clipBehavior,
        dragStartBehavior: dragStartBehavior,
        keyboardDismissBehavior: keyboardDismissBehavior,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        verticalDirection: VerticalDirection.down,
        children: children,
      ),
    );
  }
}
