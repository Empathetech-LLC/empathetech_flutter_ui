library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class EzWebLink extends TextSpan {
  /// Use with [EzWebLink.onTap] to setup a quick link text span
  const EzWebLink({
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

  static GestureRecognizer onTap({required Uri url}) {
    return TapGestureRecognizer()..onTap = () => openLink(url);
  }
}
