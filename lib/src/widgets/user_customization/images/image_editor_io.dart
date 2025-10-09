/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzImageEditor extends StatefulWidget {
  /// [File] path of the image being edited
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
  /// Intended to be used in a full-screen modal
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

  final double padding = EzConfig.get(paddingKey);
  final double spacing = EzConfig.get(spacingKey);
  final double iconSize = EzConfig.get(iconSizeKey);

  final Duration rotateDuration = ezAnimDuration(mod: 0.5);

  late final EFUILang l10n = ezL10n(context);

  // Define the build data //

  final ImageEditorController _editorController = ImageEditorController();
  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();

  late String fileExt;
  bool processing = false;

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
              ezMargin,
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

    // Get the file extension
    final String path = widget.imagePath;
    final int dot = path.lastIndexOf('.');

    fileExt = (dot != -1 && dot < path.length - 1)
        ? path.substring(dot + 1).toLowerCase()
        : 'jpg';
    if (fileExt == 'jpeg') fileExt = 'jpg';

    if (!<String>['bmp', 'gif', 'jpg', 'png'].contains(fileExt)) {
      fileExt = 'jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Return the build //

    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final Widget vertDiv = SizedBox(
      height: iconSize + padding,
      child: VerticalDivider(
        width: spacing * 2,
        color: colorScheme.secondary,
      ),
    );

    return SafeArea(
      child: Column(children: <Widget>[
        // Preview
        Expanded(
          child: ExtendedImage.file(
            File(widget.imagePath),
            fit: BoxFit.contain,
            mode: ExtendedImageMode.editor,
            extendedImageEditorKey: editorKey,
            enableLoadState: true,
            cacheRawData: true,
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
            showScrollHint: true,
            children: <Widget>[
              // Drag
              keyIcon(
                icon: Icons.touch_app,
                color: colorScheme.outline,
                name: l10n.dsDrag,
                tooltip: l10n.dsDragHint,
              ),
              ezRowSpacer,

              // Swipe
              keyIcon(
                icon: Icons.swipe,
                color: colorScheme.outline,
                name: l10n.dsSwipe,
                tooltip: l10n.dsSwipeHint,
              ),
              ezRowSpacer,

              // Scroll
              keyIcon(
                icon: Icons.mouse,
                color: colorScheme.outline,
                name: l10n.dsScroll,
                tooltip: l10n.dsScrollHint,
              ),
              ezRowSpacer,

              // Pinch
              keyIcon(
                icon: Icons.pinch,
                color: colorScheme.outline,
                name: l10n.dsPinch,
                tooltip: l10n.dsPinchHint,
              ),
              vertDiv,

              // Rotate left
              EzIconButton(
                tooltip: l10n.dsRotateLeft,
                enabled: !processing,
                onPressed: () {
                  _editorController.rotate(
                    degree: -90.0,
                    rotateCropRect: false,
                    animation: rotateDuration.inMilliseconds > 0 ? true : false,
                    duration: rotateDuration,
                  );
                  setState(() {});
                },
                icon: EzIcon(Icons.rotate_left),
              ),
              ezRowSpacer,

              // Rotate right
              EzIconButton(
                tooltip: l10n.dsRotateRight,
                enabled: !processing,
                onPressed: () {
                  _editorController.rotate(
                    degree: 90.0,
                    rotateCropRect: false,
                    animation: rotateDuration.inMilliseconds > 0 ? true : false,
                    duration: rotateDuration,
                  );
                  setState(() {});
                },
                icon: EzIcon(Icons.rotate_right),
              ),
              ezRowSpacer,

              // Undo
              EzIconButton(
                tooltip: l10n.dsUndo,
                enabled: !processing && _editorController.canUndo,
                onPressed: () {
                  _editorController.undo();
                  setState(() {});
                },
                icon: EzIcon(Icons.undo),
              ),
              ezRowSpacer,

              // Redo
              EzIconButton(
                tooltip: l10n.dsRedo,
                enabled: !processing && _editorController.canRedo,
                onPressed: () {
                  _editorController.redo();
                  setState(() {});
                },
                icon: EzIcon(Icons.redo),
              ),
              ezRowSpacer,

              // Reset
              EzIconButton(
                tooltip: l10n.gReset,
                enabled: !processing,
                onPressed: () {
                  _editorController.reset();
                  setState(() {});
                },
                icon: EzIcon(PlatformIcons(context).refresh),
              ),
              vertDiv,

              // Done
              EzIconButton(
                tooltip: l10n.gApply,
                onPressed: () async {
                  // Check exit cases
                  if (processing) return;

                  final ExtendedImageEditorState? state =
                      editorKey.currentState;
                  if (state == null) return;

                  setState(() => processing = true);

                  try {
                    // Get image data
                    final Uint8List imgData = state.rawImageData;
                    img.Image? src = img.decodeImage(imgData);

                    if (src == null) {
                      setState(() => processing = false);
                      return;
                    }

                    // Get the edits
                    final EditActionDetails? editAction = state.editAction;
                    final Rect? cropRect = state.getCropRect();

                    // Apply the edits
                    if (editAction != null) {
                      src = img.bakeOrientation(src);

                      if (editAction.hasRotateDegrees) {
                        src = img.copyRotate(
                          src,
                          angle: editAction.rotateDegrees,
                        );
                      }

                      if (editAction.needCrop && cropRect != null) {
                        src = img.copyCrop(
                          src,
                          x: cropRect.left.toInt(),
                          y: cropRect.top.toInt(),
                          width: cropRect.width.toInt(),
                          height: cropRect.height.toInt(),
                        );
                      }
                    }

                    // Encode the image
                    late final Uint8List fileData;
                    switch (fileExt) {
                      case 'bmp':
                        fileData = await compute(img.encodeBmp, src);
                        break;
                      case 'gif':
                        fileData = await compute(img.encodeGif, src);
                        break;
                      case 'png':
                        fileData = await compute(img.encodePng, src);
                        break;
                      default:
                        fileExt = 'jpg';
                        fileData = await compute(img.encodeJpg, src);
                        break;
                    }

                    // Save to a new file
                    final Directory tempDir = await getTemporaryDirectory();
                    final String newPath =
                        '${tempDir.path}/edited_${DateTime.now().millisecondsSinceEpoch}.$fileExt';
                    final File newFile = File(newPath)
                      ..writeAsBytesSync(fileData);

                    // Return the new file path
                    setState(() => processing = false);
                    if (context.mounted) {
                      Navigator.pop(context, newFile.path);
                    }
                  } catch (e) {
                    if (context.mounted) {
                      await ezLogAlert(context, message: e.toString());
                    }
                    setState(() => processing = false);
                  }
                },
                icon: processing
                    ? const CircularProgressIndicator()
                    : EzIcon(Icons.check),
              ),
              ezRowSpacer,

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
    );
  }

  @override
  void dispose() {
    _editorController.removeListener(updateState);
    _editorController.dispose();
    super.dispose();
  }
}
