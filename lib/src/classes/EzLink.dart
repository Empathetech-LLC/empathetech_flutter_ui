/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class EzLink extends TextSpan {
  /// Link message
  final String text;

  /// Link action
  final void Function()? action;

  /// Link style
  final TextStyle? style;

  /// Hint for screen readers
  /// Where does this link go?
  final String? semanticsLabel;

  /// Creates a [TextSpan] with an internal link via [TapGestureRecognizer]
  /// Requires a [semanticsLabel] for screen readers
  /// See [EzWebLink] for making extertnal links
  EzLink({
    required this.text,
    required this.action,
    this.style,
    required this.semanticsLabel,
  }) : super(
          text: text,
          recognizer: new TapGestureRecognizer()..onTap = action,
          style: style,
          semanticsLabel: semanticsLabel,
        );
}
