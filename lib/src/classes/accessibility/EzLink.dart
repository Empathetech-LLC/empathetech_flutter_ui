/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EzLink extends StatelessWidget {
  /// Link message
  final String text;

  /// Internal link destination
  final void Function()? onTap;

  /// External link destination
  final Uri? url;

  /// Hint for screen readers
  /// What does this link do?
  final String? semanticsLabel;

  /// Link style
  final TextStyle? style;

  /// [TextButton] wrapper that either opens an internal link via [onTap]
  /// Or an external link to [url]
  /// Requires [semanticsLabel] for screen readers
  EzLink(
    this.text, {
    this.onTap,
    this.url,
    required this.semanticsLabel,
    this.style,
  }) : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.');

  @override
  Widget build(BuildContext context) {
    return Semantics(
      link: true,
      hint: semanticsLabel,
      child: ExcludeSemantics(
        child: TextButton(
          child: Text(text, style: style),
          onPressed: onTap ?? () => launchUrl(url!),
        ),
      ),
    );
  }
}
