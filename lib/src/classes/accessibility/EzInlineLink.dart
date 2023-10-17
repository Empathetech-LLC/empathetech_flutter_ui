/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class EzInlineLink extends TextSpan {
  final String text;
  final void Function()? onTap;
  final Uri? url;
  final TextStyle? style;
  final MouseCursor mouseCursor;
  final void Function(PointerEnterEvent)? onEnter;
  final void Function(PointerExitEvent)? onExit;
  final String? semanticsLabel;
  final Locale? locale;
  final bool? spellOut;

  /// [TextSpan] wrapper
  EzInlineLink(
    this.text, {
    this.onTap,
    this.url,
    this.style,
    this.mouseCursor = SystemMouseCursors.contextMenu,
    this.onEnter,
    this.onExit,
    this.semanticsLabel,
    this.locale,
    this.spellOut,
  })  : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.'),
        super(
          text: text,
          style: style,
          recognizer: TapGestureRecognizer()
            ..onTap = () => onTap ?? launchUrl(url!),
          mouseCursor: mouseCursor,
          onEnter: onEnter,
          onExit: onExit,
          semanticsLabel: semanticsLabel,
          locale: locale,
          spellOut: spellOut,
        );
}
