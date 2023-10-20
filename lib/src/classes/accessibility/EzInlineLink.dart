/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EzInlineLink extends WidgetSpan {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final void Function()? onTap;
  final Uri? url;
  final String? semanticsLabel;
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
          child: Semantics(
            link: true,
            hint: semanticsLabel,
            child: ExcludeSemantics(
              child: TextButton(
                child: Text(
                  text,
                  style: style,
                  textAlign: textAlign,
                ),
                onPressed: onTap ?? () => launchUrl(url!),
              ),
            ),
          ),
          alignment: alignment,
          baseline: basline,
        );
}
