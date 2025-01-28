/* empathetech_flutter_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EzLinkWidget extends StatefulWidget {
  final Widget child;

  /// Optional [BoxShadow] override
  /// Drawn on hover/focus
  final List<BoxShadow>? shadows;

  /// Destination function
  /// Provide [onTap] or [url], but not both
  final void Function()? onTap;

  /// Destination URL
  /// Provide [onTap] or [url], but not both
  final Uri? url;

  /// What is it?
  final String semanticLabel;

  /// What does it do?
  final String hint;

  /// Is it unique?
  final String? semanticValue;

  /// Is this an image?
  final bool isImage;

  /// [Tooltip.message] for on hover/focus
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
    required this.hint,
    this.semanticValue,
    this.isImage = false,
    required this.tooltip,
  }) : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.');

  @override
  State<EzLinkWidget> createState() => _EzLinkWidgetState();
}

class _EzLinkWidgetState extends State<EzLinkWidget> {
  // Gather the theme data //

  List<BoxShadow> boxShadow = <BoxShadow>[];

  late final List<BoxShadow> shadows = widget.shadows ??
      <BoxShadow>[
        BoxShadow(
          color: Theme.of(context)
              .colorScheme
              .primary
              .withValues(alpha: highlightOpacity),
        ),
      ];

  // Define the styling function(s) //

  void showShadow(bool sun) =>
      setState(() => boxShadow = sun ? shadows : <BoxShadow>[]);

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      excludeFromSemantics: true,
      child: Semantics(
        label: widget.semanticLabel,
        value: widget.semanticValue,
        link: true,
        image: widget.isImage,
        hint: widget.hint,
        child: ExcludeSemantics(
          child: Focus(
            focusNode: FocusNode(),
            onFocusChange: (bool hasFocus) => showShadow(hasFocus),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => showShadow(true),
              onExit: (_) => showShadow(false),
              child: GestureDetector(
                onTap: widget.onTap ?? () => launchUrl(widget.url!),
                child: Container(
                  decoration: BoxDecoration(boxShadow: boxShadow),
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
