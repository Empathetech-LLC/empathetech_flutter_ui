/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzScrollView extends StatefulWidget {
  // Scrollbar parameters //

  final ScrollController? controller;
  final bool? thumbVisibility;
  final double? thickness;
  final Radius? radius;
  final ScrollNotificationPredicate? notificationPredicate;
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

  /// Optionally jump to the center of the scroll upon creation
  final bool startCentered;

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
    this.thickness,
    this.radius,
    this.notificationPredicate,
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
    this.startCentered = false,
    this.children,
  }) : assert(
          (child == null) != (children == null),
          'Either child or children should be provided, but not both.',
        );

  @override
  State<EzScrollView> createState() => _EzScrollViewState();
}

class _EzScrollViewState extends State<EzScrollView> {
  // Define build data //

  late final ScrollController controller;

  // Init //

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.startCentered && controller.hasClients) {
        final double position = controller.position.maxScrollExtent / 2;
        controller.jumpTo(position);
      }
    });
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return PlatformScrollbar(
      controller: controller,
      thumbVisibility: widget.thumbVisibility,
      thickness: widget.thickness,
      radius: widget.radius,
      notificationPredicate: widget.notificationPredicate,
      scrollbarOrientation: widget.scrollbarOrientation,
      child: SingleChildScrollView(
        scrollDirection: widget.scrollDirection,
        reverse: widget.reverse,
        padding: widget.padding,
        primary: widget.primary,
        physics: widget.physics,
        controller: controller,
        dragStartBehavior: widget.dragStartBehavior,
        clipBehavior: widget.clipBehavior,
        restorationId: widget.restorationId,
        keyboardDismissBehavior: widget.keyboardDismissBehavior,
        child: (widget.child != null)
            ? widget.child
            : (widget.scrollDirection == Axis.vertical)
                ? Column(
                    mainAxisSize: widget.mainAxisSize,
                    mainAxisAlignment: widget.mainAxisAlignment,
                    crossAxisAlignment: widget.crossAxisAlignment,
                    textDirection: widget.textDirection,
                    verticalDirection: widget.verticalDirection,
                    textBaseline: widget.textBaseline,
                    children: widget.children!,
                  )
                : EzRow(
                    mainAxisSize: widget.mainAxisSize,
                    mainAxisAlignment: widget.mainAxisAlignment,
                    crossAxisAlignment: widget.crossAxisAlignment,
                    textDirection: widget.textDirection,
                    verticalDirection: widget.verticalDirection,
                    textBaseline: widget.textBaseline,
                    reverseHands: widget.reverseHands,
                    children: widget.children!,
                  ),
      ),
    );
  }
}
