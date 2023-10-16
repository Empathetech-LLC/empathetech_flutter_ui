/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EzWebLink extends WidgetSpan {
  /// Link message
  final String text;

  /// Link destination
  final Uri url;

  /// Link style
  final TextStyle? style;

  /// Hint for screen readers
  /// Where does this link go?
  final String? semanticsLabel;

  final PlaceholderAlignment alignment;
  final TextBaseline? baseline;

  /// Custom [WidgetSpan] to pair with [EzTextBlock]
  /// Creates an external link to [url] via [launchUrl] and [EzText.onTap]
  /// Requires [semanticsLabel] for screen readers
  /// See [EzLink] for making internal links
  EzWebLink(
    this.text, {
    required this.url,
    this.style,
    required this.semanticsLabel,
    this.alignment = PlaceholderAlignment.middle,
    this.baseline,
  }) : super(
          child: EzText(
            text,
            style: style,
            onTap: () => launchUrl(url),
            semanticsLabel: semanticsLabel,
          ),
          alignment: alignment,
          baseline: baseline,
        );
}
