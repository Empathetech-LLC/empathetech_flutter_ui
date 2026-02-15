/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class EzImageLink extends StatelessWidget {
  /// [Image.image] passthrough
  final ImageProvider<Object> image;

  /// Destination function
  /// Provide [onTap] or [url], but not both
  final void Function()? onTap;

  /// Destination URL
  /// Provide [onTap] or [url], but not both
  final Uri? url;

  /// [Semantics] label; What is it?
  final String label;

  /// [Semantics] hint; what does it do?
  final String hint;

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
  const EzImageLink({
    super.key,
    required this.label,
    required this.hint,
    required this.tooltip,
    this.onTap,
    this.url,

    // Image
    required this.image,
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
  Widget build(BuildContext context) {
    final Color focusColor =
        EzConfig.colors.primary.withValues(alpha: focusOpacity);

    final Image child = Image(
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
    );

    return Tooltip(
      message: tooltip,
      excludeFromSemantics: true,
      child: Semantics(
        label: label,
        link: true,
        image: true,
        hint: hint,
        child: ExcludeSemantics(
          child: (onTap != null)
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
