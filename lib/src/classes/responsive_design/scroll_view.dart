/* empathetech_flutter_ui
 * Copyright (c) 2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class EzScrollView extends StatelessWidget {
  // Scrollbar parameters //

  final ScrollController? controller;
  final bool? thumbVisibility;
  final bool? trackVisibility;
  final double? thickness;
  final Radius? radius;
  final ScrollNotificationPredicate? notificationPredicate;
  final bool? interactive;
  final ScrollbarOrientation? scrollbarOrientation;

  // SingleChildScrollView parameters //

  final Axis scrollDirection;

  /// Only useful when [scrollDirection] is [Axis.horizontal]
  /// Is passed to the [SingleChildScrollView]s [EzRow]
  final bool reverseHands;

  final bool reverse;
  final EdgeInsetsGeometry? padding;
  final bool? primary;
  final ScrollPhysics? physics;
  final Widget? child;
  final Clip clipBehavior;
  final DragStartBehavior dragStartBehavior;
  final String? restorationId;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  // EzRow/Column parameters //

  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final TextBaseline? textBaseline;
  final VerticalDirection verticalDirection;

  /// Replacement to original [child] parameter
  /// [children] will be placed into an [EzRow] or [Column] based on [scrollDirection]
  final List<Widget>? children;

  /// [SingleChildScrollView] (and [Scrollbar]) wrapper
  /// If [children] are provided the original child parameter will be an [EzRow] or [Column] based on [scrollDirection]
  /// Behaves like a standard [SingleChildScrollView] if [child] is provided
  /// Parameters from [Scrollbar], [SingleChildScrollView] and [EzRow]/[Column] are supported
  const EzScrollView({
    super.key,

    // Scrollbar parameters //
    this.controller,
    this.thumbVisibility,
    this.trackVisibility,
    this.thickness,
    this.radius,
    this.notificationPredicate,
    this.interactive,
    this.scrollbarOrientation,

    // SingleChildScrollView parameters //

    this.scrollDirection = Axis.vertical,
    this.reverseHands = false,
    this.reverse = false,
    this.padding,
    this.primary,
    this.physics = const BouncingScrollPhysics(),
    this.child,
    this.clipBehavior = Clip.hardEdge,
    this.dragStartBehavior = DragStartBehavior.start,
    this.restorationId,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,

    // EzRow/Column parameters //

    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.textBaseline,
    this.verticalDirection = VerticalDirection.down,
    this.children,
  }) : assert(
          (child == null) != (children == null),
          'Either child or children should be provided, but not both.',
        );

  Widget _child() {
    return (scrollDirection == Axis.vertical)
        ? Column(
            mainAxisSize: mainAxisSize,
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            textDirection: textDirection,
            verticalDirection: verticalDirection,
            textBaseline: textBaseline,
            children: children!,
          )
        : EzRow(
            mainAxisSize: mainAxisSize,
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            textDirection: textDirection,
            verticalDirection: verticalDirection,
            textBaseline: textBaseline,
            reverseHands: reverseHands,
            children: children!,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: controller,
      thumbVisibility: thumbVisibility,
      trackVisibility: trackVisibility,
      thickness: thickness,
      radius: radius,
      notificationPredicate: notificationPredicate,
      interactive: interactive,
      scrollbarOrientation: scrollbarOrientation,
      child: SingleChildScrollView(
        scrollDirection: scrollDirection,
        reverse: reverse,
        padding: padding,
        primary: primary,
        physics: physics,
        controller: controller,
        dragStartBehavior: dragStartBehavior,
        clipBehavior: clipBehavior,
        restorationId: restorationId,
        keyboardDismissBehavior: keyboardDismissBehavior,
        child: child ?? _child(),
      ),
    );
  }
}
