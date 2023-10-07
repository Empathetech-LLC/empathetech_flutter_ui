/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class EzWebLink extends TextSpan {
  /// Link message
  final String text;

  /// Link destination
  final Uri url;

  /// Link style
  final TextStyle? style;

  /// Hint for screen readers
  /// Where does this link go?
  final String? semanticsLabel;

  /// Creates a [TextSpan] with an external link via [TapGestureRecognizer] && [launchUrl]
  /// Requires a [semanticsLabel] for screen readers
  /// See [EzLink] for making internal links
  ///
  /// --- WARNING! ---
  /// Unfortunately, the context (right-click) menu will not work as expected here
  /// Current theory: the [TextSpan] clobbers it, but...
  /// Empathetech chose to prioritize selectable text >> context menus
  EzWebLink({
    required this.text,
    required this.url,
    this.style,
    required this.semanticsLabel,
  }) : super(
          text: text,
          recognizer: new TapGestureRecognizer()..onTap = () => launchUrl(url),
          style: style,
          semanticsLabel: semanticsLabel,
        );
}
