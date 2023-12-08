/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzInlineLink extends WidgetSpan {
  final String text;
  final Key? key;
  final TextStyle? style;

  /// Destination function
  final void Function()? onTap;

  /// Destination URL
  final Uri? url;

  /// Message for screen readers
  final String semanticsLabel;

  /// [TextSpan] wrapper that either opens an internal link via [onTap]
  /// Or an external link to [url]
  /// Requires [semanticsLabel] for screen readers
  EzInlineLink(
    this.text, {
    this.key,
    this.style,
    this.onTap,
    this.url,
    required this.semanticsLabel,
  })  : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.'),
        super(
          child: EzLink(
            text,
            key: key,
            style: style,
            onTap: onTap,
            url: url,
            semanticsLabel: semanticsLabel,
          ),
          alignment: PlaceholderAlignment.baseline,
          baseline: TextBaseline.alphabetic,
          style: style,
        );
}
