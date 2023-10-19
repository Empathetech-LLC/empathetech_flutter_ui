/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class EzInlineLink extends TextSpan {
  final String text;
  final void Function()? onTap;
  final Uri? url;
  final String? semanticsLabel;
  final bool? spellOut;
  final Locale? locale;
  final TextStyle? style;
  final MouseCursor mouseCursor;
  final void Function(PointerEnterEvent)? onEnter;
  final void Function(PointerExitEvent)? onExit;

  /// [TextSpan] wrapper that opens either an internal link via [onTap] or an external link to [url]
  /// Requires [semanticsLabel] for screen readers
  /// Pairs well with [EzRichText]
  EzInlineLink(
    this.text, {
    this.onTap,
    this.url,
    required this.semanticsLabel,
    this.spellOut,
    this.locale,
    this.style,
    this.mouseCursor = SystemMouseCursors.click,
    this.onEnter,
    this.onExit,
  })  : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.'),
        super(
          text: text,
          recognizer: TapGestureRecognizer()
            ..onTap = onTap ?? () => launchUrl(url!),
          semanticsLabel: semanticsLabel,
          spellOut: spellOut,
          locale: locale,
          style: style,
          mouseCursor: mouseCursor,
          onEnter: onEnter,
          onExit: onExit,
        );
}
