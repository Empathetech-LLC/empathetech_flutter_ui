/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

// TODO: Actually update the image path on completion

import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzImageEditor extends StatefulWidget {
  /// File path of the image being edited
  final String imagePath;

  /// [ExtendedImageMode.editor] cropAspectRatio passthrough
  /// If null, it will mirror the window's aspect ratio
  /// Use [CropAspectRatios.custom] for freeform
  final double? cropAspectRatio;

  /// [ExtendedImageMode.editor] initialCropAspectRatio passthrough
  /// If null, it will mirror the window's aspect ratio
  /// Use [CropAspectRatios.custom] for freeform
  final double? initialCropAspectRatio;

  /// [ExtendedImageMode.editor] initCropRectType passthrough
  final InitCropRectType initCropRectType;

  /// Allows the user to crop/zoom/rotate the image
  /// Has it's own [Scaffold], so it can (should) be used as a standalone screen
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
  State<EzImageEditor> createState() => _EzImageEditorState();
}

class _EzImageEditorState extends State<EzImageEditor> {
  // Gather the fixed theme data //

  static const EzSpacer spacer = EzSpacer(vertical: false);

  final double padding = EzConfig.get(paddingKey);
  final double spacing = EzConfig.get(spacingKey);
  final double iconSize = EzConfig.get(iconSizeKey);

  late final EFUILang l10n = ezL10n(context);

  // Define the build data //

  final ImageEditorController _editorController = ImageEditorController();

  // Define custom functions && widgets //

  double liveAspectRatio() {
    final Size size = MediaQuery.of(context).size;
    return size.width / size.height;
  }

  Widget keyIcon({
    required IconData icon,
    required Color color,
    required String name,
    required String tooltip,
  }) =>
      Tooltip(
        message: tooltip,
        excludeFromSemantics: false,
        child: ExcludeSemantics(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              EzIcon(icon, color: color),
              EzMargin(),
              EzText(
                name,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: color),
              )
            ],
          ),
        ),
      );

  // Init //

  void updateState() => setState(() {});

  @override
  void initState() {
    super.initState();
    _editorController.addListener(updateState);
  }

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
                cropAspectRatio: widget.cropAspectRatio ?? liveAspectRatio(),
                initialCropAspectRatio:
                    widget.initialCropAspectRatio ?? liveAspectRatio(),
                initCropRectType: widget.initCropRectType,
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
                keyIcon(
                  icon: Icons.touch_app,
                  color: colorScheme.outline,
                  name: l10n.isDrag,
                  tooltip: l10n.isDragHint,
                ),
                spacer,

                // Swipe
                keyIcon(
                  icon: Icons.swipe,
                  color: colorScheme.outline,
                  name: l10n.isSwipe,
                  tooltip: l10n.isSwipeHint,
                ),
                spacer,

                // Scroll
                keyIcon(
                  icon: Icons.mouse,
                  color: colorScheme.outline,
                  name: l10n.isScroll,
                  tooltip: l10n.isScrollHint,
                ),
                spacer,

                // Pinch
                keyIcon(
                  icon: Icons.pinch,
                  color: colorScheme.outline,
                  name: l10n.isPinch,
                  tooltip: l10n.isPinchHint,
                ),
                spacer,

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
                  tooltip: l10n.gApply,
                  onPressed: () => Navigator.pop(context, widget.imagePath),
                  icon: EzIcon(Icons.check),
                ),
                spacer,

                // Undo
                EzIconButton(
                  tooltip: l10n.isUndo,
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
                  tooltip: l10n.isRedo,
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
                  tooltip: l10n.gReset,
                  onPressed: () {
                    _editorController.reset();
                    setState(() {});
                  },
                  icon: EzIcon(PlatformIcons(context).refresh),
                ),
                spacer,

                // Cancel
                EzIconButton(
                  tooltip: l10n.gCancel,
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

  @override
  void dispose() {
    _editorController.removeListener(updateState);
    _editorController.dispose();
    super.dispose();
  }
}
