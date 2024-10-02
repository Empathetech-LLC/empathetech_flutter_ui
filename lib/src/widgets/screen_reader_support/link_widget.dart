/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EzLinkWidget extends StatefulWidget {
  final Widget child;

  /// Optional [BoxShadow]s to be drawn on hover/focus the [EzLinkWidget]
  final List<BoxShadow>? shadows;

  /// Destination function
  final void Function()? onTap;

  /// Destination URL
  final Uri? url;

  /// Message for screen readers
  final String semanticLabel;

  /// Defaults to false
  /// Is this an image?
  final bool isImage;

  /// [Semantics] defaults to type link
  /// Set true to be a button
  final bool button;

  /// Tooltip for on hover/focus
  final String tooltip;

  /// [Widget] wrapper that either opens an internal link via [onTap]
  /// Or an external link to [url]
  /// Automatically draws a [BoxShadow] which mimics button hover based on...
  /// https://m3.material.io/foundations/interaction/states/state-layers
  /// The [shadows] can be overridden
  const EzLinkWidget({
    super.key,
    required this.child,
    this.shadows,
    this.onTap,
    this.url,
    required this.semanticLabel,
    this.isImage = false,
    this.button = false,
    required this.tooltip,
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
        image: widget.isImage,
        link: !widget.button,
        button: widget.button,
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
