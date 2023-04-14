library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

enum ImageType {
  asset,
  network,
  file,
}

class EzImage extends Image {
  final Key? key;
  final String prefsKey;
  final Widget Function(BuildContext, Widget, int?, bool)? frameBuilder;
  final Widget Function(BuildContext, Widget, ImageChunkEvent?)? loadingBuilder;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;
  final String? semanticLabel;

  /// Default:
  /// false
  final bool excludeFromSemantics;
  final double? width;
  final double? height;
  final Color? color;
  final Animation<double>? opacity;
  final BlendMode? colorBlendMode;
  final BoxFit? fit;

  /// Default:
  /// [Alignment.center]
  final AlignmentGeometry alignment;

  /// Default:
  /// [ImageRepeat.noRepeat]
  final ImageRepeat repeat;
  final Rect? centerSlice;

  /// Default:
  /// false
  final bool matchTextDirection;

  /// Default:
  /// false
  final bool gaplessPlayback;

  /// Default:
  /// false
  final bool isAntiAlias;

  /// Default:
  /// [FilterQuality.low]
  final FilterQuality filterQuality;

  /// [Image] wrapper for quickly handling [ImageType]
  EzImage({
    this.key,
    required this.prefsKey,
    this.frameBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.semanticLabel,
    this.excludeFromSemantics = false,
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
  });

  ImageProvider _selectImageProvider(String pathKey) {
    String path;

    if (backup is String) {
      path = EzConfig.preferences.getString(pathKey) ?? backup;
    } else {
      path = EzConfig.prefs[pathKey];
    }

    if (isAsset(path)) {
      return AssetImage(path);
    } else {
      try {
        return FileImage(File(path));
      } on FileSystemException catch (_) {
        // File not found error - wipe the setting and return the/a backup image
        EzConfig.preferences.remove(pathKey);

        try {
          if (backup != null) {
            return AssetImage(backup);
          }
        } catch (_) {
          // Continue on to default case
          doNothing();
        }

        // Default case, stock owl
        return NetworkImage(
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Image(
      image: _selectImageProvider(prefsKey),
      key: key,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
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
}
