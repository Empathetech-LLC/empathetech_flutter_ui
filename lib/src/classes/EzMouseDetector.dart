library empathetech_flutter_ui;

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class EzMouseDetector extends MouseRegion {
  /// Quick [MouseRegion] && [GestureDetector] combo
  EzMouseDetector({
    Key? key,
    required Widget child,
    void Function(PointerEnterEvent)? onEnter,
    void Function(PointerExitEvent)? onExit,
    void Function(PointerHoverEvent)? onHover,
    MouseCursor cursor = SystemMouseCursors.click,
    bool opaque = true,
    HitTestBehavior? hitTestBehavior,
    void Function()? onTap,
    void Function()? onLongPress,
    void Function()? onDoubleTap,
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
          hitTestBehavior: hitTestBehavior ?? HitTestBehavior.deferToChild,
        );
}
