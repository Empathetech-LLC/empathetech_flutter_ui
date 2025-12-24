/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzScrollView extends StatefulWidget {
  /// [Scrollbar.controller] passthrough
  final ScrollController? controller;

  /// [Scrollbar.thumbVisibility] passthrough
  final bool? thumbVisibility;

  /// [Scrollbar.thickness] passthrough
  final double? thickness;

  /// [Scrollbar.radius] passthrough
  final Radius? radius;

  /// [Scrollbar.notificationPredicate] passthrough
  final ScrollNotificationPredicate? notificationPredicate;

  /// [Scrollbar.scrollbarOrientation] passthrough
  final ScrollbarOrientation? scrollbarOrientation;

  /// If true, when there is scrollable content, a halo of [ColorScheme.secondary] will be shown
  final bool showScrollHint;

  /// [SingleChildScrollView.scrollDirection] passthrough
  final Axis scrollDirection;

  /// Only useful when [scrollDirection] is [Axis.horizontal]
  /// Is passed to the [SingleChildScrollView]s [EzRow]
  final bool reverseHands;

  /// [SingleChildScrollView.reverse] passthrough
  final bool reverse;

  /// [SingleChildScrollView.padding] passthrough
  final EdgeInsetsGeometry? padding;

  /// [SingleChildScrollView.primary] passthrough
  final bool? primary;

  /// [SingleChildScrollView.physics] passthrough
  final ScrollPhysics? physics;

  /// [SingleChildScrollView.child] passthrough
  final Widget? child;

  /// [SingleChildScrollView.clipBehavior] passthrough
  final Clip clipBehavior;

  /// [SingleChildScrollView.dragStartBehavior] passthrough
  final DragStartBehavior dragStartBehavior;

  /// [SingleChildScrollView.restorationId] passthrough
  final String? restorationId;

  /// [SingleChildScrollView.keyboardDismissBehavior] passthrough
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  /// [EzRow.mainAxisSize]/[Column.mainAxisSize] passthrough
  final MainAxisSize mainAxisSize;

  /// [EzRow.mainAxisAlignment]/[Column.mainAxisAlignment] passthrough
  final MainAxisAlignment mainAxisAlignment;

  /// [EzRow.crossAxisAlignment]/[Column.crossAxisAlignment] passthrough
  final CrossAxisAlignment crossAxisAlignment;

  /// [EzRow.textDirection]/[Column.textDirection] passthrough
  final TextDirection? textDirection;

  /// [EzRow.textBaseline]/[Column.textBaseline] passthrough
  final TextBaseline? textBaseline;

  /// [EzRow.verticalDirection]/[Column.verticalDirection] passthrough
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

    // Scrollbar
    this.controller,
    this.thumbVisibility,
    this.thickness,
    this.radius,
    this.notificationPredicate,
    this.scrollbarOrientation,
    this.showScrollHint = false,

    // SingleChildScrollView
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

    // EzRow/Column parameters
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
  // Gather the fixed theme data //

  // Define the build data //

  late final ScrollController controller;
  late final bool hideScroll =
      EzConfig.hideScroll || (widget.thumbVisibility == false);

  bool canScrollUp = false;
  bool canScrollDown = false;

  // Init //

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? ScrollController();

    if (widget.startCentered) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || !controller.hasClients) return;

        final double position = controller.position.maxScrollExtent / 2;
        controller.jumpTo(position);
      });
    }

    if (widget.showScrollHint) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || !controller.hasClients) return;

        final ScrollPosition pos = controller.position;
        final bool up = pos.pixels > 0;
        final bool down = pos.pixels < pos.maxScrollExtent;

        if (up || down) {
          setState(() {
            canScrollUp = up;
            canScrollDown = down;
          });
        }
      });
    }
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    late final Color hover =
        Theme.of(context).colorScheme.secondary.withValues(alpha: 0.5);

    late final Widget core = PlatformScrollbar(
      controller: controller,
      thumbVisibility: hideScroll ? false : widget.thumbVisibility,
      thickness: hideScroll ? 0.0 : widget.thickness,
      radius: hideScroll ? Radius.zero : widget.radius,
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
            ? widget.child!
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

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: widget.scrollDirection == Axis.vertical
            ? <PointerDeviceKind>{
                PointerDeviceKind.invertedStylus,
                PointerDeviceKind.stylus,
                PointerDeviceKind.touch,
                PointerDeviceKind.trackpad,
                PointerDeviceKind.unknown,
              } // No mouse
            : PointerDeviceKind.values.toSet(),
      ),
      child: widget.showScrollHint
          ? NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notif) {
                final ScrollMetrics metrics = notif.metrics;
                final bool up = metrics.pixels > 0;
                final bool down = metrics.pixels < metrics.maxScrollExtent;

                if (up != canScrollUp || down != canScrollDown) {
                  setState(() {
                    canScrollUp = up;
                    canScrollDown = down;
                  });
                }
                return false;
              },
              child: Stack(
                children: <Widget>[
                  core,

                  // Up/left
                  if (canScrollUp)
                    widget.scrollDirection == Axis.vertical
                        ? Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            child: ExcludeSemantics(
                              child: EzIcon(
                                PlatformIcons(context).upArrow,
                                color: hover,
                              ),
                            ),
                          )
                        : Positioned(
                            left: 0,
                            top: 0,
                            bottom: 0,
                            child: ExcludeSemantics(
                              child: EzIcon(
                                PlatformIcons(context).leftChevron,
                                color: hover,
                              ),
                            ),
                          ),

                  // Down/right
                  if (canScrollDown)
                    widget.scrollDirection == Axis.vertical
                        ? Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: ExcludeSemantics(
                              child: EzIcon(
                                PlatformIcons(context).downArrow,
                                color: hover,
                              ),
                            ),
                          )
                        : Positioned(
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: ExcludeSemantics(
                              child: EzIcon(
                                PlatformIcons(context).rightChevron,
                                color: hover,
                              ),
                            ),
                          )
                ],
              ),
            )
          : core,
    );
  }
}
