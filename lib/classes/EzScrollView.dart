/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

part of empathetech_flutter_ui;

class EzScrollView extends SingleChildScrollView {
  final Key? key;
  final Axis scrollDirection;

  /// Only useful when [scrollDirection] is [Axis.horizontal]
  /// Is passed to the [SingleChildScrollView]s [EzRow]
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
  final List<Widget>? children;

  /// [SingleChildScrollView] wrapper
  /// Prefers the [children] list rather than [child] Widget
  /// Behaves like a standard wrapper if [child] is provided
  /// If [children] are provided...
  /// Dynamically switches the child widget between an [EzRow] and [Column] based on [scrollDirection]
  const EzScrollView({
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

    // EzRow/Column
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.textBaseline,
    this.verticalDirection = VerticalDirection.down,
    this.children,
  }) : assert(child != null || children != null);

  Widget _buildCore() {
    return (scrollDirection == Axis.vertical)
        ? Column(
            mainAxisSize: mainAxisSize,
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            textDirection: textDirection,
            textBaseline: textBaseline,
            verticalDirection: verticalDirection,
            children: children!,
          )
        : EzRow(
            mainAxisSize: mainAxisSize,
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            textDirection: textDirection,
            textBaseline: textBaseline,
            verticalDirection: verticalDirection,
            children: children!,
            reverseHands: reverseHands,
          );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: key,
      scrollDirection: scrollDirection,
      reverse: reverse,
      padding: padding,
      primary: primary,
      physics: physics,
      controller: controller,
      child: child ?? _buildCore(),
      dragStartBehavior: dragStartBehavior,
      clipBehavior: clipBehavior,
      restorationId: restorationId,
      keyboardDismissBehavior: keyboardDismissBehavior,
    );
  }
}
