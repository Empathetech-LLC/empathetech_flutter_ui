/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzLink extends WidgetSpan {
  /// Link message
  final String text;

  /// Link's purpose
  final void Function()? action;

  /// Link style
  final TextStyle? style;

  /// Hint for screen readers
  /// What does this link do?
  final String? semanticsLabel;

  final PlaceholderAlignment alignment;
  final TextBaseline? baseline;

  /// Custom [WidgetSpan] to pair with [EzTextBlock]
  /// Creates an internal [action] link via [EzText.onTap]
  /// See [EzWebLink] for making extertnal links
  EzLink(
    this.text, {
    required this.action,
    this.style,
    this.semanticsLabel,
    this.alignment = PlaceholderAlignment.middle,
    this.baseline,
  }) : super(
          child: EzText(
            text,
            style: style,
            onTap: action,
            semanticsLabel: semanticsLabel,
          ),
          alignment: alignment,
          baseline: baseline,
        );
}
