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
  final String? semanticsLabel;

  /// Optional tooltip override
  final String? tooltip;

  /// [WidgetSpan] wrapper with an [EzLink] for a [WidgetSpan.child]
  EzInlineLink(
    this.text, {
    this.key,
    this.style,
    this.onTap,
    this.url,
    this.semanticsLabel,
    this.tooltip,
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
            tooltip: tooltip,
          ),
          alignment: PlaceholderAlignment.baseline,
          baseline: TextBaseline.alphabetic,
          style: style,
        );
}
