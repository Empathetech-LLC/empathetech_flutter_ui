/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class EzWebLink extends TextSpan {
  /// Creates a [TextSpan] with an external link via [TapGestureRecognizer] && [launchUrl]
  /// See [EzLink] for making internal links
  ///
  /// --- WARNING! ---
  /// Unfortunately, the context (right-click) menu will not work as expected here
  /// Current theory: the [TextSpan] clobbers it, but...
  /// Empathetech chose to prioritize selectable text >> context menus
  ///
  /// Requires [semanticsLabel] to enforce accessibility
  EzWebLink({
    required String text,
    required Uri url,
    TextStyle? style,
    required String semanticsLabel,
  }) : super(
          text: text,
          recognizer: new TapGestureRecognizer()..onTap = () => launchUrl(url),
          style: style,
          semanticsLabel: semanticsLabel,
        );
}
