/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EzLinkImage extends StatefulWidget {
  final Key? key;
  final ImageProvider<Object> image;

  /// Message for screen readers
  final String semanticLabel;

  /// Destination function
  final void Function()? onTap;

  /// Destination URL
  final Uri? url;

  /// Optional [List] of [BoxShadow]s to be drawn when a user hovers over the [EzLinkImage]
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

  /// [Image] wrapper that either opens an internal link via [onTap]
  /// Or an external link to [url]
  /// Requires [semanticLabel] for screen readers
  /// Automatically draws a [BoxShadow] which mimics button hover based on...
  /// https://m3.material.io/foundations/interaction/states/state-layers
  /// Optionally override the [shadows]
  const EzLinkImage({
    this.key,
    required this.image,
    required this.semanticLabel,
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
  })  : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.'),
        super(key: key);

  @override
  _EzLinkImageState createState() => _EzLinkImageState();
}

class _EzLinkImageState extends State<EzLinkImage> {
  bool _isHovering = false;

  late final Color _hoverColor =
      Theme.of(context).colorScheme.primary.withOpacity(0.16);
  late final List<BoxShadow> _shadows =
      widget.shadows ?? [BoxShadow(color: _hoverColor)];

  void _updateHoverState(bool isHovering) {
    setState(() {
      _isHovering = isHovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      image: true,
      link: true,
      hint: widget.semanticLabel,
      child: ExcludeSemantics(
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => _updateHoverState(true),
          onExit: (_) => _updateHoverState(false),
          child: GestureDetector(
            onTap: widget.onTap ?? () => launchUrl(widget.url!),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: _isHovering ? _shadows : [],
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
    );
  }
}
