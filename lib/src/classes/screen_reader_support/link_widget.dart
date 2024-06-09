/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EzLinkWidget extends StatefulWidget {
  final Widget child;

  /// Message for screen readers
  final String semanticLabel;

  final bool isImage;

  /// Tooltip for on hover/focus
  final String tooltip;

  /// Destination function
  final void Function()? onTap;

  /// Destination URL
  final Uri? url;

  /// Optional [List] of [BoxShadow]s to be drawn when a user hovers over the [EzLinkWidget]
  final List<BoxShadow>? shadows;

  /// [Widget] wrapper that either opens an internal link via [onTap]
  /// Or an external link to [url]
  /// Requires [semanticLabel] for screen readers
  /// Automatically draws a [BoxShadow] which mimics button hover based on...
  /// https://m3.material.io/foundations/interaction/states/state-layers
  /// The [shadows] can be overridden
  const EzLinkWidget({
    super.key,
    required this.child,
    required this.semanticLabel,
    this.isImage = false,
    required this.tooltip,
    this.onTap,
    this.url,
    this.shadows,
  }) : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.');

  @override
  State<EzLinkWidget> createState() => _EzLinkWidgetState();
}

class _EzLinkWidgetState extends State<EzLinkWidget> {
  // Gather the theme data //

  bool _shadow = false;

  late final List<BoxShadow> _shadows = widget.shadows ??
      <BoxShadow>[
        BoxShadow(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.10),
        ),
      ];

  // Define the styling function(s) //

  void _showShadow(bool showIt) {
    _shadow = showIt;
    setState(() {});
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      excludeFromSemantics: true,
      child: Semantics(
        image: widget.isImage,
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
                  child: widget.child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
