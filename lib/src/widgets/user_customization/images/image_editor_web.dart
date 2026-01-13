/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';

class EzImageEditor extends StatelessWidget {
  /// Unsupported in web
  final String imagePath;

  /// Unsupported in web
  final double? cropAspectRatio;

  /// Unsupported in web
  final double? initialCropAspectRatio;

  /// Unsupported in web
  final InitCropRectType initCropRectType;

  /// Unsupported in web
  const EzImageEditor(
    this.imagePath, {
    super.key,
    this.initCropRectType = InitCropRectType.imageRect,
    this.cropAspectRatio,
    this.initialCropAspectRatio,
  }) : assert(
          cropAspectRatio == null ||
              initialCropAspectRatio == null ||
              cropAspectRatio == initialCropAspectRatio,
          'If both cropAspectRatio and initialCropAspectRatio are provided, they must be equal.',
        );

  @override
  Widget build(BuildContext context) => Text(
        EzConfig.l10n.dsNoWeb,
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.center,
      );
}
