library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class EzLink extends TextSpan {
  /// Creates a [TextSpan] with an internal link via [TapGestureRecognizer]
  /// See [EzWebLink] for making extertnal links
  EzLink({
    required String text,
    required Function()? action,
    TextStyle? style,
  }) : super(
          text: text,
          recognizer: new TapGestureRecognizer()..onTap = action,
          style: style,
        );
}
