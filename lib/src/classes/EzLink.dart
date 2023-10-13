/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class EzLink extends TextSpan {
  /// Link message
  final String text;

  /// Link's purpose
  final void Function()? action;

  /// Link style
  final TextStyle? style;

  /// Hint for screen readers
  /// What does this link do?
  final String? semanticsLabel;

  /// [TextSpan] wrapper that creates an internal [action] link via [TapGestureRecognizer]
  /// Requires [semanticsLabel] for screen readers
  /// See [EzWebLink] for making extertnal links
  EzLink(
    this.text, {
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
