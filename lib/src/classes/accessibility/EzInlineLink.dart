/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class EzInlineLink extends TextSpan {
  final String text;
  final TextStyle? style;

  /// Message for screen readers
  final String semanticsLabel;

  /// Destination function
  final void Function()? onTap;

  /// Destination URL
  final Uri? url;

  final MouseCursor mouseCursor;
  final void Function(PointerEnterEvent)? onEnter;
  final void Function(PointerExitEvent)? onExit;
  final Locale? locale;
  final bool spellOut;

  /// [TextSpan] wrapper that either opens an internal link via [onTap]
  /// Or an external link to [url]
  /// Requires [semanticsLabel] for screen readers
  EzInlineLink(
    this.text, {
    this.style,
    required this.semanticsLabel,
    this.onTap,
    this.url,
    this.mouseCursor = SystemMouseCursors.click,
    this.onEnter,
    this.onExit,
    this.locale,
    this.spellOut = false,
  })  : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.'),
        super(
          text: text,
          style: style,
          semanticsLabel: semanticsLabel,
          recognizer: new TapGestureRecognizer()
            ..onTap = onTap ?? () => launchUrl(url!),
          mouseCursor: mouseCursor,
          onEnter: onEnter,
          onExit: onExit,
          locale: locale,
          spellOut: spellOut,
        );
}
