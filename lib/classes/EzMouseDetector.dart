library empathetech_flutter_ui;

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class EzMouseDetector extends MouseRegion {
  final Key? key;

  /// Actually:
  /// GestureDetector(
  ///   onTap: onTap,
  ///   onLongPress: onLongPress,
  ///   onDoubleTap: onDoubleTap,
  ///   child: child,
  /// )
  final Widget child;

  final void Function(PointerEnterEvent)? onEnter;
  final void Function(PointerExitEvent)? onExit;
  final void Function(PointerHoverEvent)? onHover;
  final MouseCursor cursor;
  final bool opaque;
  final HitTestBehavior hitTestBehavior;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final void Function()? onDoubleTap;

  /// Quick [MouseRegion] && [GestureDetector] combo
  EzMouseDetector({
    this.key,
    required this.child,
    this.onEnter,
    this.onExit,
    this.onHover,
    this.cursor = SystemMouseCursors.click,
    this.opaque = true,
    this.hitTestBehavior = HitTestBehavior.deferToChild,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
  }) : super(
          key: key,
          child: GestureDetector(
            onTap: onTap,
            onLongPress: onLongPress,
            onDoubleTap: onDoubleTap,
            child: child,
          ),
          onEnter: onEnter,
          onExit: onExit,
          onHover: onHover,
          cursor: cursor,
          opaque: opaque,
          hitTestBehavior: hitTestBehavior,
        );
}
