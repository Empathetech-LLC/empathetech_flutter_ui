/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class EzLinkWidget extends StatelessWidget {
  /// Destination function
  /// Provide [onTap] or [url], but not both
  final void Function()? onTap;

  /// Destination URL
  /// Provide [onTap] or [url], but not both
  final Uri? url;

  /// [Semantics] label; What is it?
  final String label;

  /// Is this an image?
  final bool isImage;

  /// [Semantics] hint; what does it do?
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
    this.isImage = false,
    required this.hint,
    required this.child,
  }) : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.');

  @override
  Widget build(BuildContext context) {
    final Color focusColor =
        EzConfig.colors.primary.withValues(alpha: focusOpacity);

    return Tooltip(
      message: tooltip,
      excludeFromSemantics: true,
      child: Semantics(
        label: label,
        link: true,
        image: isImage,
        hint: hint,
        child: ExcludeSemantics(
          child: onTap != null
              ? InkWell(focusColor: focusColor, onTap: onTap, child: child)
              : Link(
                  uri: url,
                  builder: (_, FollowLink? followLink) => InkWell(
                    focusColor: focusColor,
                    onTap: followLink,
                    child: child,
                  ),
                ),
        ),
      ),
    );
  }
}
