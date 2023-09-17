/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'dart:io';
import 'package:flutter/material.dart';

class EzStoredImage extends Image {
  final Key? key;

  /// [EzConfig] key that contains the path to the image you wish to load
  final String prefsKey;

  final Widget Function(BuildContext, Widget, int?, bool)? frameBuilder;
  final Widget Function(BuildContext, Widget, ImageChunkEvent?)? loadingBuilder;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;
  final String semanticLabel;
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

  /// [Image] wrapper for when [prefsKey] can resolve to either an [AssetImage] or [FileImage]
  /// If the [ImageProvider] is known, it is preferred to called the standard const [Image] constructor
  /// Also requires a [semanticLabel] for encforcing accessibility
  EzStoredImage({
    this.key,
    required this.prefsKey,
    this.frameBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    required this.semanticLabel,
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
  }) : super(
          image: getProvider(prefsKey),
          key: key,
          frameBuilder: frameBuilder,
          loadingBuilder: loadingBuilder,
          errorBuilder: errorBuilder,
          semanticLabel: semanticLabel,
          excludeFromSemantics: false,
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
}

/// Automatically handles [AssetImage] vs [FileImage]
/// Technically supports [NetworkImage], but at this time it isn't recommended
/// Will use [EzConfig] preferences as a backup if the [EzConfig] prefs call fails
/// In a total failure event, a stock owl image will be shown
ImageProvider getProvider(String prefsKey) {
  // Something went wrong, return watchful owl
  const String errorURL =
      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg';

  dynamic prefsValue = EzConfig.instance.prefs[prefsKey];

  final String path = (prefsValue is String)
      ? prefsValue
      : (EzConfig.instance.preferences.getString(prefsKey) ?? errorURL);

  if (isAsset(path)) {
    return AssetImage(path);
  } else {
    try {
      return FileImage(File(path));
    } on FileSystemException catch (_) {
      // File not found error - wipe the setting and return the/a backup image
      EzConfig.instance.preferences.remove(prefsKey);

      // Default case, stock owl
      return NetworkImage(path);
    }
  }
}
