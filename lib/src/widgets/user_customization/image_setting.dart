/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';
import 'images/image_editor_io.dart'
    if (dart.library.html) 'images/image_editor_web.dart';

import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzImageSetting extends StatefulWidget {
  /// [EzConfig] key whose value is being updated
  final String configKey;

  /// [EzElevatedIconButton.label] passthrough
  final String label;

  /// [EzElevatedButton.style] passthrough
  /// If provided, recommended to include the default settings...
  ///   padding: EdgeInsets.all(padding * 0.75),
  final ButtonStyle? style;

  /// If true, opens an [ezColorPicker] for the user, and saves the hex value (string) as the image path
  final bool allowSolidColor;

  /// Effectively whether the image is nullable
  /// true is recommended
  /// Note: if there is no [EzConfig.defaults] value for [configKey], the reset option will not appear
  final bool allowClear;

  /// Who made this/where did it come from?
  /// [credits] will be displayed via [EzAlertDialog] on long press
  final String? credits;

  /// For [ColorScheme.fromImageProvider]
  /// If provided and [updateThemeOption] is true, the user will have the final say
  /// If provided and [updateThemeOption] is false, it will be automatic
  /// If null, no theme will be updated
  final Brightness? updateTheme;

  /// Whether the update theme checkbox && message should be displayed
  final bool updateThemeOption;

  /// Whether the [EzImageEditor] should be displayed upon successful image selection
  /// By current design, [AssetImage]s cannot be edited/will be skipped
  final bool showEditor;

  /// Optional default [BoxFit] for the image
  /// Recommended if [showFitOption] is false
  /// Note: If the user makes edits, the default will always be [BoxFit.contain]
  final BoxFit? defaultFit;

  /// Whether the [BoxFit] options dialog should be displayed upon successful image selection
  final bool showFitOption;

  /// [EzElevatedIconButton] for updating the image at [configKey]'s path
  const EzImageSetting({
    super.key,
    required this.configKey,
    required this.label,
    this.style,
    this.allowSolidColor = false,
    this.allowClear = true,
    this.credits,
    this.updateTheme,
    this.updateThemeOption = true,
    this.showEditor = true,
    this.defaultFit,
    this.showFitOption = true,
  });

  @override
  State<EzImageSetting> createState() => _ImageSettingState();
}

class _ImageSettingState extends State<EzImageSetting> {
  // Gather the fixed theme data //

  late final EFUILang l10n = ezL10n(context);

  // Define the build data //

  late String? currPath = EzConfig.get(widget.configKey);
  bool inProgress = false;

  bool fromLocal = false;
  late bool updateTheme = (widget.updateTheme != null);
  late BoxFit? selectedFit = widget.defaultFit;

  late final TextEditingController urlController = TextEditingController();

  // Define custom widgets && functions //

  /// Open an [EzAlertDialog] with the [Image]s source information
  Future<dynamic>? showCredits() {
    final bool hasChanged = currPath != EzConfig.getDefault(widget.configKey);
    final bool showCredits = !hasChanged && (widget.credits != null);

    return showCredits
        ? showPlatformDialog(
            context: context,
            builder: (_) => EzAlertDialog(
              title: Text(l10n.gCreditTo, textAlign: TextAlign.center),
              content: Text(widget.credits!, textAlign: TextAlign.center),
            ),
          )
        : null;
  }

  /// Cleanup any custom [File]s
  Future<void> fileCleanup() async {
    if (!EzConfig.isKeyAsset(widget.configKey)) {
      try {
        final File toDelete = File(widget.configKey);
        await toDelete.delete();
      } catch (e) {
        ezLog(e.toString());
      }
    }
  }

  /// Validate a URL
  String? validateUrl(String? value) {
    return (value == null || value.isEmpty || !ezUrlCheck(value))
        ? l10n.gValidURL
        : null;
  }

  /// First-layer [ElevatedButton.onPressed]
  /// Opens an options modal and updates the state accordingly
  Future<void> activateSetting(ThemeData theme) async {
    String? newPath = await ezModal<String?>(
      context: context,
      builder: (BuildContext mContext) => StatefulBuilder(
        builder: (_, StateSetter setModal) => EzScrollView(
          mainAxisSize: MainAxisSize.min,
          children: sourceOptions(
            theme: theme,
            mContext: mContext,
            setModal: setModal,
          ),
        ),
      ),
    );
    if (newPath == null || newPath.isEmpty || newPath == noImageValue) return;
    final bool isInt = (int.tryParse(newPath) != null);

    // Choose fit and/or edit image
    if (!isInt &&
        fromLocal &&
        widget.showEditor &&
        !kIsWeb &&
        !EzConfig.isPathAsset(newPath)) {
      if (mounted) {
        final Future<dynamic> Function(String path, ThemeData theme) toDo =
            await showPlatformDialog(
          context: context,
          builder: (BuildContext dContext) {
            void useFull() => Navigator.of(dContext).pop((_, __) async => true);
            void crop() => Navigator.of(dContext).pop(editImage);
            void cancel() => Navigator.of(dContext).pop((_, __) async => null);

            return EzAlertDialog(
              title: Text(l10n.dsUseFull, textAlign: TextAlign.center),
              materialActions: <EzMaterialAction>[
                EzMaterialAction(text: l10n.gYes, onPressed: useFull),
                EzMaterialAction(text: l10n.dsCrop, onPressed: crop),
                EzMaterialAction(text: l10n.gCancel, onPressed: cancel),
              ],
              cupertinoActions: <EzCupertinoAction>[
                EzCupertinoAction(text: l10n.gYes, onPressed: useFull),
                EzCupertinoAction(text: l10n.dsCrop, onPressed: crop),
                EzCupertinoAction(text: l10n.gCancel, onPressed: cancel),
              ],
              needsClose: false,
            );
          },
        );

        final dynamic result = await toDo(newPath, theme);
        switch (result.runtimeType) {
          case const (bool):
            break;
          case const (String):
            newPath = result;
            selectedFit = BoxFit.contain;
          default:
            return;
        }
      }
    }

    if (newPath == null || newPath.isEmpty || newPath == noImageValue) return;
    if (!isInt && widget.showFitOption) {
      final bool canceled = (await chooseFit(newPath, theme) == null);
      if (canceled) return;
    }

    // Set the new path
    final bool setPath = await EzConfig.setString(widget.configKey, newPath);
    if (!setPath) {
      if (mounted) ezLogAlert(context, message: l10n.dsImgSetFailed);
    } else {
      currPath = newPath;

      // If there is little/no text background opacity, set it to 50%
      // It will be more annoying to have to turn it down, than turn it up without being able to read
      if (widget.updateTheme == Brightness.dark) {
        final double? opacity = EzConfig.get(darkTextBackgroundOpacityKey);
        if (opacity == null || opacity <= 0.05) {
          await EzConfig.setDouble(darkTextBackgroundOpacityKey, 0.50);
        }
      }
      if (widget.updateTheme == Brightness.light) {
        final double? opacity = EzConfig.get(lightTextBackgroundOpacityKey);
        if (opacity == null || opacity <= 0.05) {
          await EzConfig.setDouble(lightTextBackgroundOpacityKey, 0.50);
        }
      }

      // Update the theme (conditionally)
      if (!isInt && widget.updateTheme != null && updateTheme) {
        final String result = await storeImageColorScheme(
          brightness: widget.updateTheme!,
          path: newPath,
        );

        if (result != success && mounted) {
          await ezLogAlert(
            context,
            title: l10n.dsImgGetFailed,
            message:
                '$result${ezUrlCheck(newPath) ? '\n\n${l10n.dsImgPermission}' : ''}',
          );
        } else {
          widget.updateTheme == Brightness.light
              ? await EzConfig.setString(lightColorSchemeImageKey, newPath)
              : await EzConfig.setString(darkColorSchemeImageKey, newPath);
        }
      }
    }
  }

  /// Build the list of [ImageSource] options
  List<Widget> sourceOptions({
    required ThemeData theme,
    required BuildContext mContext,
    required StateSetter setModal,
  }) {
    final List<Widget> options = <Widget>[];
    final String? defaultPath = EzConfig.getDefault(widget.configKey);

    final double spacing = EzConfig.spacing;
    final EdgeInsets wrapPadding = EzInsets.wrap(spacing);

    // From camera
    // Only works on mobile
    if (!kIsWeb && isMobile()) {
      options.add(Padding(
        padding: wrapPadding,
        child: EzElevatedIconButton(
          onPressed: () async {
            final String? picked = await ezImagePicker(
              context: context,
              source: ImageSource.camera,
            );

            fromLocal = true;
            if (mContext.mounted) Navigator.of(mContext).pop(picked);
          },
          icon: EzIcon(PlatformIcons(context).photoCamera),
          label: l10n.dsFromCamera,
        ),
      ));
    }

    // From file
    // Doesn't work on Web
    if (!kIsWeb) {
      options.add(Padding(
        padding: wrapPadding,
        child: EzElevatedIconButton(
          onPressed: () async {
            final String? picked = await ezImagePicker(
              context: context,
              source: ImageSource.gallery,
            );

            fromLocal = true;
            if (mContext.mounted) Navigator.of(mContext).pop(picked);
          },
          icon: EzIcon(PlatformIcons(context).folder),
          label: l10n.dsFromFile,
        ),
      ));
    }

    // From network
    // Works everywhere
    options.add(Padding(
      padding: wrapPadding,
      child: EzElevatedIconButton(
        onPressed: () => showPlatformDialog(
          context: context,
          builder: (BuildContext dContext) {
            void onConfirm() async {
              closeKeyboard(dContext);

              // Validate the URL
              final String url = urlController.text.trim();
              if (validateUrl(url) != null) return;

              // Verify that the image is accessible
              try {
                final Completer<void> completer = Completer<void>();
                final ImageStream stream =
                    NetworkImage(url).resolve(const ImageConfiguration());

                late ImageStreamListener listener;
                listener = ImageStreamListener(
                  // onImage (onSuccess)
                  (_, __) {
                    completer.complete();
                    stream.removeListener(listener);
                  },
                  onError: (Object error, StackTrace? stackTrace) {
                    completer.completeError(error, stackTrace);
                    stream.removeListener(listener);
                  },
                );

                stream.addListener(listener);
                await completer.future;
              } catch (e) {
                if (dContext.mounted) {
                  Navigator.of(dContext).pop(null);
                }
                if (mContext.mounted) {
                  Navigator.of(mContext).pop(null);
                }

                if (mounted) {
                  await ezLogAlert(
                    context,
                    title: l10n.dsImgGetFailed,
                    message: '${e.toString()}\n\n${l10n.dsImgPermission}',
                  );
                }
                return;
              }

              // Pop dialogs
              if (dContext.mounted) {
                Navigator.of(dContext).pop(url);
              }

              if (mContext.mounted) {
                Navigator.of(mContext).pop(url);
              }
            }

            void onDeny() => Navigator.of(dContext).pop(null);

            late final List<Widget> materialActions;
            late final List<Widget> cupertinoActions;

            (materialActions, cupertinoActions) = ezActionPairs(
              context: context,
              confirmMsg: l10n.gApply,
              onConfirm: onConfirm,
              confirmIsDestructive: true,
              denyMsg: l10n.gCancel,
              onDeny: onDeny,
            );

            return EzAlertDialog(
              title: Text(
                l10n.gEnterURL,
                textAlign: TextAlign.center,
              ),
              content: Form(
                child: TextFormField(
                  controller: urlController,
                  maxLines: 1,
                  autofillHints: const <String>[AutofillHints.url],
                  decoration: const InputDecoration(hintText: webImgHint),
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  validator: validateUrl,
                ),
              ),
              materialActions: materialActions,
              cupertinoActions: cupertinoActions,
              needsClose: false,
            );
          },
        ),
        icon: EzIcon(Icons.computer_outlined),
        label: l10n.dsFromNetwork,
      ),
    ));

    // Solid color (optional)
    if (widget.allowSolidColor) {
      options.add(Padding(
        padding: wrapPadding,
        child: EzElevatedIconButton(
          onPressed: () async {
            final int? pathARGB =
                (currPath == null) ? null : int.tryParse(currPath!);
            Color currColor = pathARGB == null
                ? theme.colorScheme.surfaceContainer
                : Color(pathARGB);

            await ezColorPicker(
              context,
              startColor: currColor,
              onColorChange: (Color color) => setModal(() => currColor = color),
              onConfirm: () async {
                await EzConfig.setString(
                  widget.configKey,
                  currColor.toARGB32().toString(),
                );

                if (mContext.mounted) {
                  Navigator.of(mContext).pop(currColor.toARGB32().toString());
                }
              },
              onDeny: doNothing,
            );
          },
          icon: EzIcon(Icons.color_lens),
          label: l10n.dsSolidColor,
        ),
      ));
    }

    // Reset
    if (defaultPath != null && defaultPath != noImageValue) {
      options.add(Padding(
        padding: wrapPadding,
        child: EzElevatedIconButton(
          onPressed: () async {
            await fileCleanup();
            await EzConfig.remove(widget.configKey);

            if (mContext.mounted) {
              Navigator.of(mContext).pop(defaultPath);
            }
          },
          icon: EzIcon(PlatformIcons(context).refresh),
          label: l10n.dsResetIt,
        ),
      ));
    }

    // Clear (optional)
    if (widget.allowClear) {
      options.add(Padding(
        padding: wrapPadding,
        child: EzElevatedIconButton(
          onPressed: () async {
            await fileCleanup();
            await EzConfig.setString(widget.configKey, noImageValue);

            if (mContext.mounted) {
              Navigator.of(mContext).pop(noImageValue);
            }
          },
          icon: EzIcon(PlatformIcons(context).clear),
          label: l10n.dsClearIt,
        ),
      ));
    }

    // Return the options, with the conditional update theme switch
    return <Widget>[
      Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: options,
      ),
      if (widget.updateTheme != null && widget.updateThemeOption)
        Padding(
          padding: EdgeInsets.symmetric(vertical: spacing / 2),
          child: EzSwitchPair(
            key: ValueKey<bool>(updateTheme),
            text: l10n.dsUseForColors,
            value: updateTheme,
            onChanged: (bool? choice) {
              updateTheme = (choice == null) ? false : choice;
              setModal(() {});
              setState(() {});
            },
          ),
        ),
      const EzSpacer(),
    ];
  }

  /// Opens [EzImageEditor] and overrides the image as necessary
  Future<String?> editImage(String path, ThemeData theme) async {
    final String? editResult = await ezModal<String?>(
      context: context,
      enableDrag: false,
      useSafeArea: false,
      isDismissible: false,
      showDragHandle: false,
      builder: (_) => EzImageEditor(path),
      constraints: const BoxConstraints(
        minWidth: double.infinity,
        minHeight: double.infinity,
      ),
    );

    return (editResult != null && editResult.isNotEmpty) ? editResult : null;
  }

  /// Opens a preview modal for choosing the desired [BoxFit]
  Future<bool?> chooseFit(String path, ThemeData theme) {
    const EzSpacer ezRowSpacer = EzSpacer(vertical: false);

    final double width = widthOf(context) * 0.25;
    final double height = heightOf(context) * 0.25;

    return ezModal<bool?>(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (BuildContext fitContext, StateSetter fitState) {
          return EzScrollView(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                l10n.dsFit,
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              EzMargin(),
              RadioGroup<BoxFit>(
                groupValue: selectedFit,
                onChanged: (BoxFit? value) {
                  selectedFit = value;
                  fitState(() {});
                },
                child: EzScrollView(
                  scrollDirection: Axis.horizontal,
                  primary: false,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ezRowSpacer,
                    fitPreview(
                      path: path,
                      fit: BoxFit.contain,
                      width: width,
                      height: height,
                      setModal: fitState,
                      theme: theme,
                    ),
                    ezRowSpacer,
                    fitPreview(
                      path: path,
                      fit: BoxFit.cover,
                      width: width,
                      height: height,
                      setModal: fitState,
                      theme: theme,
                    ),
                    ezRowSpacer,
                    fitPreview(
                      path: path,
                      fit: BoxFit.fill,
                      width: width,
                      height: height,
                      setModal: fitState,
                      theme: theme,
                    ),
                    ezRowSpacer,
                    fitPreview(
                      path: path,
                      fit: BoxFit.fitWidth,
                      width: width,
                      height: height,
                      setModal: fitState,
                      theme: theme,
                    ),
                    ezRowSpacer,
                    fitPreview(
                      path: path,
                      fit: BoxFit.fitHeight,
                      width: width,
                      height: height,
                      setModal: fitState,
                      theme: theme,
                    ),
                    ezRowSpacer,
                    fitPreview(
                      path: path,
                      fit: BoxFit.none,
                      width: width,
                      height: height,
                      setModal: fitState,
                      theme: theme,
                    ),
                    ezRowSpacer,
                    fitPreview(
                      path: path,
                      fit: BoxFit.scaleDown,
                      width: width,
                      height: height,
                      setModal: fitState,
                      theme: theme,
                    ),
                    ezRowSpacer,
                  ],
                ),
              ),
              const EzSpacer(),
              EzRow(
                mainAxisAlignment: EzConfig.isLefty
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
                children: <Widget>[
                  ezRowSpacer,
                  EzTextButton(
                    onPressed: () => Navigator.of(fitContext).pop(null),
                    text: l10n.gCancel,
                    textStyle: theme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  ezRowSpacer,
                  EzTextButton(
                    onPressed: () async {
                      if (selectedFit != null) {
                        await EzConfig.setString(
                          '${widget.configKey}$boxFitSuffix',
                          selectedFit!.name,
                        );
                      }

                      if (fitContext.mounted) {
                        Navigator.of(fitContext).pop(true);
                      }
                    },
                    text: selectedFit == null ? l10n.gSkip : l10n.gApply,
                    textStyle: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  ezRowSpacer,
                ],
              ),
              const EzSeparator(),
            ],
          );
        },
      ),
    );
  }

  /// Creates a mini-[Scaffold] to preview the [BoxFit] option(s)
  Widget fitPreview({
    required String path,
    required BoxFit fit,
    required double width,
    required double height,
    required StateSetter setModal,
    required ThemeData theme,
  }) {
    final double scaleMargin = EzConfig.margin * 0.25;

    final String name = fit.name;

    final double toolbarHeight = ezTextSize(
          name,
          style: theme.textTheme.bodyLarge,
          context: context,
        ).height +
        scaleMargin;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            selectedFit = fit;
            setModal(() {});
          },
          child: Semantics(
            hint: name,
            image: true,
            button: true,
            child: ExcludeSemantics(
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.onSurface),
                  borderRadius: ezRoundEdge,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: toolbarHeight,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: textFieldRadius,
                      ),
                      child: Text(
                        name,
                        style: theme.textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Image(
                      width: width - scaleMargin,
                      height: height - toolbarHeight - scaleMargin,
                      image: ezImageProvider(path),
                      fit: fit,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        ExcludeSemantics(child: EzRadio<BoxFit>(value: fit)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final double padding = EzConfig.padding;
    final double iconSize = EzConfig.iconSize;

    late final ThemeData theme = Theme.of(context);

    // Return the build //

    final int? pathARGB = (currPath == null) ? null : int.tryParse(currPath!);

    return Semantics(
      label: widget.label,
      button: true,
      hint: l10n.dsImgSettingHint(widget.label),
      child: ExcludeSemantics(
        child: EzElevatedIconButton(
          style: widget.style ??
              ElevatedButton.styleFrom(padding: EdgeInsets.all(padding * 0.75)),
          onPressed: () async {
            if (inProgress) return;

            setState(() {
              inProgress = true;
              fromLocal = false;
            });
            await activateSetting(theme);
            setState(() => inProgress = false);
          },
          onLongPress: () => inProgress ? doNothing() : showCredits(),
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: theme.colorScheme.onSurface),
            ),
            child: CircleAvatar(
              radius: iconSize + padding,
              foregroundImage: (inProgress ||
                      currPath == null ||
                      currPath == noImageValue ||
                      pathARGB != null)
                  ? null
                  : ezImageProvider(currPath!),
              backgroundColor:
                  (pathARGB != null) ? Color(pathARGB) : Colors.transparent,
              foregroundColor: theme.colorScheme.onSurface,
              child: inProgress
                  ? const CircularProgressIndicator()
                  : (currPath == null || currPath == noImageValue)
                      ? EzIcon(
                          PlatformIcons(context).edit,
                          color: theme.colorScheme.primary,
                        )
                      : null,
            ),
          ),
          label: widget.label,
          textAlign: TextAlign.center,
          labelPadding: false,
        ),
      ),
    );
  }

  @override
  void dispose() {
    urlController.dispose();
    super.dispose();
  }
}
