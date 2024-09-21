/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EzLinkImageProvider extends StatefulWidget {
  final ImageProvider<Object> image;

  /// Message for screen readers
  final String semanticLabel;

  /// Tooltip for on hover/focus
  final String tooltip;

  /// Destination function
  final void Function()? onTap;

  /// Destination URL
  final Uri? url;

  /// Optional [List] of [BoxShadow]s to be drawn when a user hovers over the [EzLinkImageProvider]
  final List<BoxShadow>? shadows;

  final Widget Function(BuildContext, Widget, int?, bool)? frameBuilder;
  final Widget Function(BuildContext, Widget, ImageChunkEvent?)? loadingBuilder;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;
  final double? width;
  final double? height;
  final Color? color;
  final Animation<double>? opacity;
  final BlendMode? colorBlendMode;
  final BoxFit? fit;
  final AlignmentGeometry alignment;
  final ImageRepeat repeat;
  final Rect? centerSlice;
  final bool matchTextDirection;
  final bool gaplessPlayback;
  final bool isAntiAlias;
  final FilterQuality filterQuality;

  /// [ImageProvider] wrapper that either opens an internal link via [onTap]
  /// Or an external link to [url]
  /// Requires [semanticLabel] for screen readers
  /// Automatically draws a [BoxShadow] which mimics button hover based on...
  /// https://m3.material.io/foundations/interaction/states/state-layers
  /// The [shadows] can be overridden
  const EzLinkImageProvider({
    super.key,
    required this.image,
    required this.semanticLabel,
    required this.tooltip,
    this.onTap,
    this.url,
    this.shadows,
    this.frameBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.width,
    this.height,
    this.color,
    this.opacity,
    this.colorBlendMode,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.matchTextDirection = false,
    this.gaplessPlayback = false,
    this.isAntiAlias = false,
    this.filterQuality = FilterQuality.low,
  }) : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.');

  @override
  State<EzLinkImageProvider> createState() => _EzLinkImageProviderState();
}

class _EzLinkImageProviderState extends State<EzLinkImageProvider> {
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
                  child: Image(
                    image: widget.image,
                    frameBuilder: widget.frameBuilder,
                    loadingBuilder: widget.loadingBuilder,
                    errorBuilder: widget.errorBuilder,
                    width: widget.width,
                    height: widget.height,
                    color: widget.color,
                    opacity: widget.opacity,
                    colorBlendMode: widget.colorBlendMode,
                    fit: widget.fit,
                    alignment: widget.alignment,
                    repeat: widget.repeat,
                    centerSlice: widget.centerSlice,
                    matchTextDirection: widget.matchTextDirection,
                    gaplessPlayback: widget.gaplessPlayback,
                    isAntiAlias: widget.isAntiAlias,
                    filterQuality: widget.filterQuality,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
