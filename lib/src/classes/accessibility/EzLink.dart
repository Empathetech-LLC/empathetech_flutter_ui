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

  /// Internal link destination
  final void Function()? onTap;

  /// External link destination
  final Uri? url;

  /// Link style
  final TextStyle? style;

  /// Hint for screen readers
  /// What does this link do?
  final String? semanticsLabel;

  /// [EzText] wrapper that opens either an internal link via [onTap]
  /// Or an external link to [url]
  /// Requires [semanticsLabel] for screen readers
  EzLink(
    this.text, {
    this.onTap,
    this.url,
    this.style,
    this.semanticsLabel,
  })  : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.'),
        super(
          text,
          style: style,
          semanticsLabel: semanticsLabel,
          onTap: onTap ?? () => launchUrl(url!),
        );
}
