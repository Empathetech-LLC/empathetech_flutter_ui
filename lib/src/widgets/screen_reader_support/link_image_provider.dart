/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EzLinkImageProvider extends StatelessWidget {
  /// [Image.image] passthrough
  final ImageProvider<Object> image;

  /// Destination function
  /// Provide [onTap] or [url], but not both
  final void Function()? onTap;

  /// Destination URL
  /// Provide [onTap] or [url], but not both
  final Uri? url;

  /// What is it?
  final String label;

  /// What does it do?
  final String hint;

  /// Is it unique?
  final String? value;

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
  const EzLinkImageProvider({
    super.key,
    required this.image,
    required this.label,
    required this.hint,
    this.value,
    required this.tooltip,
    this.onTap,
    this.url,
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
  Widget build(BuildContext context) => Tooltip(
        message: tooltip,
        excludeFromSemantics: true,
        child: Semantics(
          label: label,
          value: value,
          link: true,
          image: true,
          hint: hint,
          child: ExcludeSemantics(
            child: InkWell(
              focusColor: Theme.of(context)
                  .colorScheme
                  .primary
                  .withValues(alpha: focusOpacity),
              onTap: onTap ?? () => launchUrl(url!),
              child: Image(
                image: image,
                frameBuilder: frameBuilder,
                loadingBuilder: loadingBuilder,
                errorBuilder: errorBuilder,
                semanticLabel: null,
                excludeFromSemantics: true,
                width: width,
                height: height,
                color: color,
                opacity: opacity,
                colorBlendMode: colorBlendMode,
                fit: fit,
                alignment: alignment,
                repeat: repeat,
                centerSlice: centerSlice,
                matchTextDirection: matchTextDirection,
                gaplessPlayback: gaplessPlayback,
                isAntiAlias: isAntiAlias,
                filterQuality: filterQuality,
              ),
            ),
          ),
        ),
      );
}
