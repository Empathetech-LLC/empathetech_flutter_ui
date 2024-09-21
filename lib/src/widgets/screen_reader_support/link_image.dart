/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EzLinkImage extends StatefulWidget {
  final Widget image;

  /// Message for screen readers
  final String semanticLabel;

  /// Tooltip for on hover/focus
  final String tooltip;

  /// Destination function
  final void Function()? onTap;

  /// Destination URL
  final Uri? url;

  /// Optional [List] of [BoxShadow]s to be drawn when a user hovers over the [EzLinkImage]
  final List<BoxShadow>? shadows;

  /// [Image] wrapper that either opens an internal link via [onTap]
  /// Or an external link to [url]
  /// Requires [semanticLabel] for screen readers
  /// Automatically draws a [BoxShadow] which mimics button hover based on...
  /// https://m3.material.io/foundations/interaction/states/state-layers
  /// The [shadows] can be overridden
  const EzLinkImage({
    super.key,
    required this.image,
    required this.semanticLabel,
    required this.tooltip,
    this.onTap,
    this.url,
    this.shadows,
  }) : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.');

  @override
  State<EzLinkImage> createState() => _EzLinkImageState();
}

class _EzLinkImageState extends State<EzLinkImage> {
  // Gather the theme data //

  bool _shadow = false;

  late final List<BoxShadow> _shadows = widget.shadows ??
      <BoxShadow>[
        BoxShadow(
          color: Theme.of(context)
              .colorScheme
              .primary
              .withOpacity(highlightOpacity),
        ),
      ];

  // Define the styling function(s) //

  void _showShadow(bool showIt) => setState(() => _shadow = showIt);

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      excludeFromSemantics: true,
      child: Semantics(
        image: true,
        link: true,
        hint: widget.semanticLabel,
        child: ExcludeSemantics(
          child: Focus(
            focusNode: FocusNode(),
            onFocusChange: (bool hasFocus) => _showShadow(hasFocus),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => _showShadow(true),
              onExit: (_) => _showShadow(false),
              child: GestureDetector(
                onTap: widget.onTap ?? () => launchUrl(widget.url!),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: _shadow ? _shadows : <BoxShadow>[],
                  ),
                  child: widget.image,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
