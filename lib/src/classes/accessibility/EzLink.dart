/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EzLink extends EzText {
  /// Link message
  final String text;

  final TextStyle? style;
  final TextAlign? textAlign;

  /// Hint for screen readers
  /// What does this link do?
  final String? semanticsLabel;

  /// Internal link destination
  final void Function()? onTap;

  /// External link destination
  final Uri? url;

  /// [TextButton] wrapper that either opens an internal link via [onTap]
  /// Or an external link to [url]
  /// Requires [semanticsLabel] for screen readers
  EzLink(
    this.text, {
    this.style,
    this.textAlign,
    required this.semanticsLabel,
    this.onTap,
    this.url,
  })  : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.'),
        super(
          text,
          style: style,
          textAlign: textAlign,
          semanticsLabel: semanticsLabel,
          onTap: onTap ?? () => launchUrl(url!),
          showCursor: true,
        );
}
