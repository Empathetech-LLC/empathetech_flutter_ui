library empathetech_flutter_ui;

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class EzLink extends TextSpan {
  /// Use with [EzLink.onTap] to setup a quick link text span
  const EzLink({
    required String text,
    required GestureRecognizer recognizer,
    TextStyle? style,
    MouseCursor? mouseCursor,
    void Function(PointerEnterEvent)? onEnter,
    void Function(PointerExitEvent)? onExit,
  }) : super(
          text: text,
          recognizer: recognizer,
          style: style,
          mouseCursor: mouseCursor,
          onEnter: onEnter,
          onExit: onExit,
        );

  static GestureRecognizer onTap({required void Function() action}) {
    return TapGestureRecognizer()..onTap = action;
  }
}
