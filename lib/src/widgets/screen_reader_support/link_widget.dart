/* empathetech_flutter_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EzLinkWidget extends StatelessWidget {
  /// Destination function
  /// Provide [onTap] or [url], but not both
  final void Function()? onTap;

  /// Destination URL
  /// Provide [onTap] or [url], but not both
  final Uri? url;

  /// What is it?
  final String label;

  /// Is it unique?
  final String? value;

  /// Is this an image?
  final bool isImage;

  /// What does it do?
  final String hint;

  /// [Tooltip.message] passthrough
  final String tooltip;

  /// [InkWell.child] passthrough
  final Widget child;

  /// [InkWell] wrapper that either opens an internal link via [onTap]
  /// Or an external link to [url]
  const EzLinkWidget({
    super.key,
    this.onTap,
    this.url,
    required this.tooltip,
    required this.label,
    this.value,
    this.isImage = false,
    required this.hint,
    required this.child,
  }) : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.');

  @override
  Widget build(BuildContext context) => Tooltip(
        message: tooltip,
        excludeFromSemantics: true,
        child: Semantics(
          label: label,
          value: value,
          link: true,
          image: isImage,
          hint: hint,
          child: ExcludeSemantics(
            child: InkWell(
              focusColor: Theme.of(context)
                  .colorScheme
                  .primary
                  .withValues(alpha: focusOpacity),
              onTap: onTap ?? () => launchUrl(url!),
              child: child,
            ),
          ),
        ),
      );
}
