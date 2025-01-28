/* empathetech_flutter_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EzLinkImageProvider extends StatefulWidget {
  /// [Image.image] passthrough
  final ImageProvider<Object> image;

  /// Optional [List] of [BoxShadow]s to be drawn on hover/focus
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

  /// [Tooltip.message] for on hover/focus
  final String tooltip;

  /// [Image.frameBuilder] passthrough
  final Widget Function(BuildContext, Widget, int?, bool)? frameBuilder;

  /// [Image.loadingBuilder] passthrough
  final Widget Function(BuildContext, Widget, ImageChunkEvent?)? loadingBuilder;

  /// [Image.errorBuilder] passthrough
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  /// [Image.width] passthrough
  final double? width;

  /// [Image.height] passthrough
  final double? height;

  /// [Image.color] passthrough
  final Color? color;

  /// [Image.opacity] passthrough
  final Animation<double>? opacity;

  /// [Image.colorBlendMode] passthrough
  final BlendMode? colorBlendMode;

  /// [Image.fit] passthrough
  final BoxFit? fit;

  /// [Image.alignment] passthrough
  final AlignmentGeometry alignment;

  /// [Image.repeat] passthrough
  final ImageRepeat repeat;

  /// [Image.centerSlice] passthrough
  final Rect? centerSlice;

  /// [Image.matchTextDirection] passthrough
  final bool matchTextDirection;

  /// [Image.gaplessPlayback] passthrough
  final bool gaplessPlayback;

  /// [Image.isAntiAlias] passthrough
  final bool isAntiAlias;

  /// [Image.filterQuality] passthrough
  final FilterQuality filterQuality;

  /// [Image] wrapper that either opens an internal link via [onTap]
  /// Or an external link to [url]
  /// Automatically draws a [BoxShadow] which mimics button hover based on...
  /// https://m3.material.io/foundations/interaction/states/state-layers
  /// The [shadows] can be overridden
  const EzLinkImageProvider({
    super.key,
    required this.image,
    required this.semanticLabel,
    required this.hint,
    this.semanticValue,
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
    this.filterQuality = FilterQuality.medium,
  }) : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.');

  @override
  State<EzLinkImageProvider> createState() => _EzLinkImageProviderState();
}

class _EzLinkImageProviderState extends State<EzLinkImageProvider> {
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
        image: true,
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
                  child: Image(
                    image: widget.image,
                    frameBuilder: widget.frameBuilder,
                    loadingBuilder: widget.loadingBuilder,
                    errorBuilder: widget.errorBuilder,
                    semanticLabel: null,
                    excludeFromSemantics: true,
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
