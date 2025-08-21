/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';

class EzImageEditor extends StatefulWidget {
  final String imagePath;

  /// Allows the user to crop/zoom/rotate the image
  /// Has it's own [Scaffold], so it can (should) be used as a standalone screen
  const EzImageEditor(this.imagePath, {super.key});

  @override
  State<EzImageEditor> createState() => _EzImageEditorState();
}

class _EzImageEditorState extends State<EzImageEditor> {
  @override
  Widget build(BuildContext context) {
    return EzAdaptiveScaffold(
      small: ExtendedImage.file(
        File(widget.imagePath),
        fit: BoxFit.contain,
        mode: ExtendedImageMode.editor,
        initEditorConfigHandler: (ExtendedImageState? state) {
          return EditorConfig(
            maxScale: 8.0,
            cropRectPadding: const EdgeInsets.all(20.0),
            hitTestSize: 20.0,
            cropAspectRatio: 1.0,
          );
        },
      ),
    );
  }
}
