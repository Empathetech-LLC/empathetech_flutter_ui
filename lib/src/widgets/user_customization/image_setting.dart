/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'dart:io';
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

  static const EzSpacer spacer = EzSpacer();
  static const EzSpacer rowSpacer = EzSpacer(vertical: false);
  static const EzSeparator separator = EzSeparator();

  final double margin = EzConfig.get(marginKey);
  final double padding = EzConfig.get(paddingKey);
  final double spacing = EzConfig.get(spacingKey);
  final double iconSize = EzConfig.get(iconSizeKey);

  late final EdgeInsets colInsets = EzInsets.col(spacing);

  final bool isLefty = EzConfig.get(isLeftyKey) ?? false;

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
    String? newPath = await showModalBottomSheet<String?>(
      context: context,
      builder: (BuildContext modalContext) => StatefulBuilder(
        builder: (_, StateSetter modalState) => EzScrollView(
          mainAxisSize: MainAxisSize.min,
          children: sourceOptions(
            modalContext: modalContext,
            modalState: modalState,
          ),
        ),
      ),
    );
    if (newPath == null || newPath.isEmpty || newPath == noImageValue) return;

    // Choose fit and/or edit image
    if (fromLocal &&
        widget.showEditor &&
        !kIsWeb &&
        !EzConfig.isPathAsset(newPath)) {
      if (mounted) {
        final Future<dynamic> Function(String path, ThemeData theme) toDo =
            await showPlatformDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            void useFull() =>
                Navigator.of(dialogContext).pop((_, __) async => true);
            void crop() => Navigator.of(dialogContext).pop(editImage);
            void cancel() =>
                Navigator.of(dialogContext).pop((_, __) async => null);

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
            setState(() => selectedFit = BoxFit.contain);
          default:
            return;
        }
      }
    }

    if (newPath == null || newPath.isEmpty || newPath == noImageValue) return;
    if (widget.showFitOption) {
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
          await EzConfig.setDouble(lightTextBackgroundOpacityKey, 0.5);
        }
      }
      if (widget.updateTheme == Brightness.light) {
        final double? opacity = EzConfig.get(lightTextBackgroundOpacityKey);
        if (opacity == null || opacity <= 0.05) {
          await EzConfig.setDouble(lightTextBackgroundOpacityKey, 0.5);
        }
      }

      // Update the theme (conditionally)
      if (widget.updateTheme != null && updateTheme) {
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
    required BuildContext modalContext,
    required StateSetter modalState,
  }) {
    final List<Widget> options = <Widget>[];
    final String? defaultPath = EzConfig.getDefault(widget.configKey);

    // From camera
    // Only works on mobile
    if (!kIsWeb && isMobile()) {
      options.add(Padding(
        padding: colInsets,
        child: EzElevatedIconButton(
          onPressed: () async {
            final String? picked = await ezImagePicker(
              context: context,
              source: ImageSource.camera,
            );

            if (modalContext.mounted) {
              setState(() => fromLocal = true);
              Navigator.of(modalContext).pop(picked);
            }
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
        padding: colInsets,
        child: EzElevatedIconButton(
          onPressed: () async {
            final String? picked = await ezImagePicker(
              context: context,
              source: ImageSource.gallery,
            );

            if (modalContext.mounted) {
              setState(() => fromLocal = true);
              Navigator.of(modalContext).pop(picked);
            }
          },
          icon: EzIcon(PlatformIcons(context).folder),
          label: l10n.dsFromFile,
        ),
      ));
    }

    // From network
    // Works everywhere
    options.add(Padding(
      padding: colInsets,
      child: EzElevatedIconButton(
        onPressed: () => showPlatformDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            void onConfirm() async {
              closeKeyboard(dialogContext);

              // Validate the URL
              final String url = urlController.text.trim();
              if (validateUrl(url) != null) return;

              // Verify that the image is accessible
              late final NetworkImage image;
              try {
                image = NetworkImage(url);
              } catch (e) {
                await ezLogAlert(
                  context,
                  title: l10n.dsImgGetFailed,
                  message: '${e.toString()}\n\n${l10n.dsImgPermission}',
                );

                if (dialogContext.mounted) {
                  Navigator.of(dialogContext).pop(null);
                }
                return;
              }

              // Pop dialogs
              if (dialogContext.mounted) {
                Navigator.of(dialogContext).pop(image.url);
              }

              if (modalContext.mounted) {
                Navigator.of(modalContext).pop(image.url);
              }
            }

            void onDeny() => Navigator.of(dialogContext).pop(null);

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

    // Reset
    if (defaultPath != null && defaultPath != noImageValue) {
      options.add(Padding(
        padding: colInsets,
        child: EzElevatedIconButton(
          onPressed: () async {
            await fileCleanup();
            await EzConfig.remove(widget.configKey);

            if (modalContext.mounted) {
              Navigator.of(modalContext).pop(defaultPath);
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
        padding: colInsets,
        child: EzElevatedIconButton(
          onPressed: () async {
            await fileCleanup();
            await EzConfig.setString(widget.configKey, noImageValue);

            if (modalContext.mounted) {
              Navigator.of(modalContext).pop(noImageValue);
            }
          },
          icon: EzIcon(PlatformIcons(context).clear),
          label: l10n.dsClearIt,
        ),
      ));
    }

    // Update theme (optional)
    if (widget.updateTheme != null && widget.updateThemeOption) {
      options.add(Padding(
        padding: EzInsets.wrap(spacing),
        child: EzSwitchPair(
          key: ValueKey<bool>(updateTheme),
          text: l10n.dsUseForColors,
          value: updateTheme,
          onChanged: (bool? choice) {
            updateTheme = (choice == null) ? false : choice;
            modalState(() {});
            setState(() {});
          },
        ),
      ));
    }

    return options;
  }

  /// Opens [EzImageEditor] and overrides the image as necessary
  Future<String?> editImage(String path, ThemeData theme) async {
    final String? editResult = await Navigator.of(context).push(
      platformPageRoute(
        context: context,
        builder: (_) => EzImageEditor(path),
      ),
    );
    return (editResult != null && editResult.isNotEmpty) ? editResult : null;
  }

  /// Opens a preview modal for choosing the desired [BoxFit]
  Future<bool?> chooseFit(String path, ThemeData theme) {
    final double width = widthOf(context) * 0.25;
    final double height = heightOf(context) * 0.25;

    return showModalBottomSheet<bool?>(
      context: context,
      useSafeArea: true,
      constraints: const BoxConstraints(minWidth: double.infinity),
      isScrollControlled: true,
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
              separator,
              RadioGroup<BoxFit>(
                groupValue: selectedFit,
                onChanged: (BoxFit? value) {
                  selectedFit = value;
                  setState(() {});
                  fitState(() {});
                },
                child: EzScrollView(
                  scrollDirection: Axis.horizontal,
                  primary: false,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    rowSpacer,
                    fitPreview(
                      path: path,
                      fit: BoxFit.contain,
                      width: width,
                      height: height,
                      modalState: fitState,
                      theme: theme,
                    ),
                    rowSpacer,
                    fitPreview(
                      path: path,
                      fit: BoxFit.cover,
                      width: width,
                      height: height,
                      modalState: fitState,
                      theme: theme,
                    ),
                    rowSpacer,
                    fitPreview(
                      path: path,
                      fit: BoxFit.fill,
                      width: width,
                      height: height,
                      modalState: fitState,
                      theme: theme,
                    ),
                    rowSpacer,
                    fitPreview(
                      path: path,
                      fit: BoxFit.fitWidth,
                      width: width,
                      height: height,
                      modalState: fitState,
                      theme: theme,
                    ),
                    rowSpacer,
                    fitPreview(
                      path: path,
                      fit: BoxFit.fitHeight,
                      width: width,
                      height: height,
                      modalState: fitState,
                      theme: theme,
                    ),
                    rowSpacer,
                    fitPreview(
                      path: path,
                      fit: BoxFit.none,
                      width: width,
                      height: height,
                      modalState: fitState,
                      theme: theme,
                    ),
                    rowSpacer,
                    fitPreview(
                      path: path,
                      fit: BoxFit.scaleDown,
                      width: width,
                      height: height,
                      modalState: fitState,
                      theme: theme,
                    ),
                    rowSpacer,
                  ],
                ),
              ),
              separator,
              EzRow(
                mainAxisAlignment:
                    isLefty ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: <Widget>[
                  rowSpacer,
                  EzTextButton(
                    onPressed: () => Navigator.of(fitContext).pop(null),
                    text: l10n.gCancel,
                    textStyle: theme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  rowSpacer,
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
                  rowSpacer,
                ],
              ),
              spacer,
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
    required StateSetter modalState,
    required ThemeData theme,
  }) {
    final double scaleMargin = margin * 0.25;

    final String name = fit.name;

    final double toolbarHeight = ezTextSize(
          name,
          style: theme.textTheme.bodyLarge,
          context: context,
        ).height +
        scaleMargin;

    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            selectedFit = fit;
            setState(() {});
            modalState(() {});
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
    // Gather the dynamic theme data //

    late final ThemeData theme = Theme.of(context);

    // Return the build //
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
              foregroundImage:
                  (inProgress || currPath == null || currPath == noImageValue)
                      ? null
                      : ezImageProvider(currPath!),
              backgroundColor: Colors.transparent,
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
