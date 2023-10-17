/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzLink extends EzText {
  /// Link message
  final String text;

  /// Link's purpose
  final void Function()? onTap;

  /// Link style
  final TextStyle? style;

  /// Hint for screen readers
  /// What does this link do?
  final String? semanticsLabel;

  /// [EzText] wrapper that opens an internal link via [onTap]
  /// See [EzWebLink] for making external links
  EzLink(
    this.text, {
    this.style,
    this.semanticsLabel,
    required this.onTap,
  }) : super(
          text,
          style: style,
          semanticsLabel: semanticsLabel,
          onTap: onTap,
        );
}
