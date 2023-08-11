library empathetech_flutter_ui;

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class EzWebLink extends TextSpan {
  /// Use with [EzWebLink.onTap] to setup a quick link text span
  EzWebLink({
    required String text,
    required Uri url,
    TextStyle? style,
    MouseCursor? mouseCursor,
    void Function(PointerEnterEvent)? onEnter,
    void Function(PointerExitEvent)? onExit,
  }) : super(
          text: text,
          recognizer: new TapGestureRecognizer()..onTap = () => launchUrl(url),
          style: style,
        );
}
