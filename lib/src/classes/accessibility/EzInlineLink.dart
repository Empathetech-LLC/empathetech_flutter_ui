/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzInlineLink extends WidgetSpan {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final String? semanticsLabel;
  final void Function()? onTap;
  final Uri? url;
  final PlaceholderAlignment alignment;
  final TextBaseline? basline;

  /// [WidgetSpan] wrapper that either opens an internal link via [onTap]
  /// Or an external link to [url]
  /// Requires [semanticsLabel] for screen readers
  EzInlineLink(
    this.text, {
    this.style,
    this.textAlign,
    required this.semanticsLabel,
    this.onTap,
    this.url,
    this.alignment = PlaceholderAlignment.middle,
    this.basline,
  })  : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.'),
        super(
          child: EzLink(
            text,
            style: style,
            textAlign: textAlign,
            semanticsLabel: semanticsLabel,
            onTap: onTap,
            url: url,
          ),
          alignment: alignment,
          baseline: basline,
        );
}
