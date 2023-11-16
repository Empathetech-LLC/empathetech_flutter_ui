/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EzLinkImage extends StatelessWidget {
  final Key? key;
  final ImageProvider<Object> image;

  /// Message for screen readers
  final String semanticsLabel;

  /// Destination function
  final void Function()? onTap;

  /// Destination URL
  final Uri? url;

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
  /// Requires [semanticsLabel] for screen readers
  const EzLinkImage({
    this.key,
    required this.image,
    required this.semanticsLabel,
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
    this.filterQuality = FilterQuality.low,
  }) : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.');

  @override
  Widget build(BuildContext context) {
    return Semantics(
      image: true,
      link: true,
      hint: semanticsLabel,
      child: ExcludeSemantics(
        child: MouseRegion(
          key: key,
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onTap ?? () => launchUrl(url!),
            child: Image(
              image: image,
              frameBuilder: frameBuilder,
              loadingBuilder: loadingBuilder,
              errorBuilder: errorBuilder,
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
}
