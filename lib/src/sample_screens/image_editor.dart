/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

// TODO: l10n && tooltips
// TODO: Get the preview space to be a live ratio of the window
// TODO: Actually update the image path on completion

import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzImageEditor extends StatefulWidget {
  final String imagePath;

  /// Allows the user to crop/zoom/rotate the image
  /// Has it's own [Scaffold], so it can (should) be used as a standalone screen
  const EzImageEditor(this.imagePath, {super.key});

  @override
  State<EzImageEditor> createState() => _EzImageEditorState();
}

class _EzImageEditorState extends State<EzImageEditor> {
  // Gather the fixed theme data //

  static const EzSpacer spacer = EzSpacer(vertical: false);

  final double padding = EzConfig.get(paddingKey);
  final double spacing = EzConfig.get(spacingKey);
  final double iconSize = EzConfig.get(iconSizeKey);

  // Define the build data //

  final ImageEditorController _editorController = ImageEditorController();

  // Define custom functions //

  Widget keyIcon(IconData icon, Color color, String name) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          EzIcon(icon, color: color),
          EzMargin(),
          EzText(
            name,
            textAlign: TextAlign.center,
            style:
                Theme.of(context).textTheme.labelLarge?.copyWith(color: color),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    // Gather the dynamic theme data //

    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    // Return the build //

    return Scaffold(
      body: EzScreen(
        Column(children: <Widget>[
          // Preview
          Expanded(
            child: ExtendedImage.file(
              File(widget.imagePath),
              fit: BoxFit.contain,
              mode: ExtendedImageMode.editor,
              enableLoadState: true,
              initEditorConfigHandler: (_) => EditorConfig(
                cropRectPadding: EdgeInsets.only(
                  top: spacing,
                  left: spacing,
                  right: spacing,
                ),
                hitTestSize: max(padding, kMinInteractiveDimension),
                controller: _editorController,
              ),
            ),
          ),

          // Key && controls
          Padding(
            padding: EdgeInsets.all(spacing),
            child: EzScrollView(
              mainAxisSize: MainAxisSize.min,
              scrollDirection: Axis.horizontal,
              startCentered: true,
              children: <Widget>[
                // Drag
                keyIcon(Icons.touch_app, colorScheme.outline, 'Drag'),
                spacer,

                // Pinch
                keyIcon(Icons.pinch, colorScheme.outline, 'Pinch'),
                spacer,

                // Swipe
                keyIcon(Icons.swipe, colorScheme.outline, 'Swipe'),

                // Divider
                SizedBox(
                  height: iconSize + padding,
                  child: VerticalDivider(
                    width: spacing * 4,
                    color: colorScheme.secondary,
                  ),
                ),

                // Done
                EzIconButton(
                  onPressed: () => Navigator.pop(context, widget.imagePath),
                  icon: EzIcon(Icons.check),
                ),
                spacer,

                // Undo
                EzIconButton(
                  enabled: _editorController.canUndo,
                  onPressed: () {
                    _editorController.undo();
                    setState(() {});
                  },
                  icon: EzIcon(Icons.undo),
                ),
                spacer,

                // Redo
                EzIconButton(
                  enabled: _editorController.canRedo,
                  onPressed: () {
                    _editorController.redo();
                    setState(() {});
                  },
                  icon: EzIcon(Icons.redo),
                ),
                spacer,

                // Reset
                EzIconButton(
                  onPressed: () {
                    _editorController.reset();
                    setState(() {});
                  },
                  icon: EzIcon(PlatformIcons(context).refresh),
                ),
                spacer,

                // Cancel
                EzIconButton(
                  onPressed: () => Navigator.pop(context, null),
                  icon: EzIcon(PlatformIcons(context).delete),
                ),
              ],
            ),
          )
        ]),
        margin: EdgeInsets.zero,
        useImageDecoration: false,
      ),
    );
  }
}
