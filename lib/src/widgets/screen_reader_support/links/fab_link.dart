/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class EzFABLink extends StatelessWidget {
  /// [Link.uri] passthrough
  final Uri uri;

  /// [FloatingActionButton.tooltip] passthrough
  final String? tooltip;

  /// [FloatingActionButton.foregroundColor] passthrough
  final Color? foregroundColor;

  /// [FloatingActionButton.backgroundColor] passthrough
  final Color? backgroundColor;

  /// [FloatingActionButton.focusColor] passthrough
  final Color? focusColor;

  /// [FloatingActionButton.hoverColor] passthrough
  final Color? hoverColor;

  /// [FloatingActionButton.splashColor] passthrough
  final Color? splashColor;

  /// [FloatingActionButton.heroTag] passthrough
  final Object? heroTag;

  /// [FloatingActionButton.elevation] passthrough
  final double? elevation;

  /// [FloatingActionButton.focusElevation] passthrough
  final double? focusElevation;

  /// [FloatingActionButton.hoverElevation] passthrough
  final double? hoverElevation;

  /// [FloatingActionButton.highlightElevation] passthrough
  final double? highlightElevation;

  /// [FloatingActionButton.disabledElevation] passthrough
  final double? disabledElevation;

  /// [FloatingActionButton.mouseCursor] passthrough
  final MouseCursor? mouseCursor;

  /// [FloatingActionButton.mini] passthrough
  final bool mini;

  /// [FloatingActionButton.shape] passthrough
  final ShapeBorder? shape;

  /// [FloatingActionButton.clipBehavior] passthrough
  final Clip clipBehavior;

  /// [FloatingActionButton.focusNode] passthrough
  final FocusNode? focusNode;

  /// [FloatingActionButton.autofocus] passthrough
  final bool autofocus;

  /// [FloatingActionButton.materialTapTargetSize] passthrough
  final MaterialTapTargetSize? materialTapTargetSize;

  /// [FloatingActionButton.isExtended] passthrough
  final bool isExtended;

  /// [FloatingActionButton.enableFeedback] passthrough
  final bool? enableFeedback;

  /// [FloatingActionButton.child] passthrough
  final Widget? child;

  /// [FloatingActionButton] wrapped in a [Link]
  const EzFABLink({
    super.key,
    required this.uri,
    this.tooltip,
    this.foregroundColor,
    this.backgroundColor,
    this.focusColor,
    this.hoverColor,
    this.splashColor,
    this.heroTag,
    this.elevation,
    this.focusElevation,
    this.hoverElevation,
    this.highlightElevation,
    this.disabledElevation,
    this.mouseCursor,
    this.mini = false,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.materialTapTargetSize,
    this.isExtended = false,
    this.enableFeedback,
    this.child,
  });

  @override
  Widget build(BuildContext context) => Link(
        uri: uri,
        builder: (_, FollowLink? followLink) => FloatingActionButton(
          tooltip: tooltip,
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
          focusColor: focusColor,
          hoverColor: hoverColor,
          splashColor: splashColor,
          heroTag: heroTag,
          elevation: elevation,
          focusElevation: focusElevation,
          hoverElevation: hoverElevation,
          highlightElevation: highlightElevation,
          disabledElevation: disabledElevation,
          onPressed: followLink,
          mouseCursor: mouseCursor,
          mini: mini,
          shape: shape,
          clipBehavior: clipBehavior,
          focusNode: focusNode,
          autofocus: autofocus,
          materialTapTargetSize: materialTapTargetSize,
          isExtended: isExtended,
          enableFeedback: enableFeedback,
          child: child,
        ),
      );
}
