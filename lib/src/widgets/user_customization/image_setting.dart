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

  /// Whether the [BoxFit] options dialog should be displayed upon successful image selection
  final bool showFitOption;

  /// [EzElevatedIconButton] for updating the image at [configKey]'s path
  const EzImageSetting({
    super.key,
    required this.configKey,
    required this.label,
    this.allowClear = true,
    this.credits,
    this.updateTheme,
    this.updateThemeOption = true,
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

  late final TargetPlatform platform = Theme.of(context).platform;

  // Define the build data //

  late String? currPath = EzConfig.get(widget.configKey);

  late bool updateTheme = (widget.updateTheme != null);
  bool inProgress = false;
  BoxFit? selected;

  late final TextEditingController urlText = TextEditingController();

  /// Creates a mini-[Scaffold] to preview the [BoxFit] option(s)
  Widget fitPreview({
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

    final Widget selectButton = ExcludeSemantics(
      child: EzRadio<BoxFit>(
        groupValue: selected,
        value: fit,
        onChanged: (BoxFit? value) {
          selected = value;
          setState(() {});
          modalState(() {});
        },
      ),
    );

    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            selected = fit;
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
                      image: ezImageProvider(currPath!),
                      fit: fit,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        selectButton,
      ],
    );
  }

  // Define button functions //

  /// Cleanup any custom [File]s
  void cleanup() async {
    if (!EzConfig.isKeyAsset(widget.configKey)) {
      try {
        final File toDelete = File(widget.configKey);
        await toDelete.delete();
      } catch (e) {
        doNothing();
      }
    }
  }

  /// Validate a URL
  String? validateUrl(String? value) {
    return (value == null || value.isEmpty || !ezUrlCheck(value))
        ? l10n.gValidURL
        : null;
  }

  /// Build the list of [ImageSource] options
  List<Widget> sourceOptions({
    required BuildContext dialogContext,
    required StateSetter dialogState,
  }) {
    final List<Widget> options = <Widget>[];
    final String? defaultPath = EzConfig.getDefault(widget.configKey);

    // From camera
    // Only works on mobile
    if (!kIsWeb &&
        (platform == TargetPlatform.android ||
            platform == TargetPlatform.iOS)) {
      options.add(Padding(
        padding: colInsets,
        child: EzElevatedIconButton(
          onPressed: () async {
            final String? changed = await ezImagePicker(
              context: context,
              prefsPath: widget.configKey,
              source: ImageSource.camera,
            );

            if (dialogContext.mounted) {
              Navigator.of(dialogContext).pop(changed);
            }
          },
          icon: EzIcon(PlatformIcons(context).photoCamera),
          label: l10n.isFromCamera,
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
            final String? changed = await ezImagePicker(
              context: context,
              prefsPath: widget.configKey,
              source: ImageSource.gallery,
            );

            if (dialogContext.mounted) {
              Navigator.of(dialogContext).pop(changed);
            }
          },
          icon: EzIcon(PlatformIcons(context).folder),
          label: l10n.isFromFile,
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
          builder: (BuildContext networkDialogContext) {
            void onConfirm() async {
              closeKeyboard(networkDialogContext);

              // Validate the URL
              final String url = urlText.text.trim();

              if (validateUrl(url) != null) return;

              // Verify that the image is accessible
              late final NetworkImage image;
              try {
                image = NetworkImage(urlText.text);
              } catch (e) {
                await ezLogAlert(
                  context,
                  title: l10n.isGetFailed,
                  message: '${e.toString()}\n\n${l10n.isPermission}',
                );

                if (networkDialogContext.mounted) {
                  Navigator.of(networkDialogContext).pop(null);
                }
                return;
              }

              // Save the URL
              await EzConfig.setString(widget.configKey, image.url);

              // Pop dialogs
              if (networkDialogContext.mounted) {
                Navigator.of(networkDialogContext).pop(image.url);
              }

              if (dialogContext.mounted) {
                Navigator.of(dialogContext).pop(image.url);
              }
            }

            void onDeny() => Navigator.of(networkDialogContext).pop(null);

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
                l10n.isEnterURL,
                textAlign: TextAlign.center,
              ),
              content: Form(
                child: TextFormField(
                  controller: urlText,
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
        label: l10n.isFromNetwork,
      ),
    ));

    // Reset
    if (defaultPath != null && defaultPath != noImageValue) {
      options.add(Padding(
        padding: colInsets,
        child: EzElevatedIconButton(
          onPressed: () async {
            cleanup();
            await EzConfig.remove(widget.configKey);

            if (dialogContext.mounted) {
              Navigator.of(dialogContext).pop(defaultPath);
            }
          },
          icon: EzIcon(PlatformIcons(context).refresh),
          label: l10n.isResetIt,
        ),
      ));
    }

    // Clear (optional)
    if (widget.allowClear) {
      options.add(Padding(
        padding: colInsets,
        child: EzElevatedIconButton(
          onPressed: () async {
            cleanup();
            await EzConfig.setString(widget.configKey, noImageValue);

            if (dialogContext.mounted) {
              Navigator.of(dialogContext).pop(noImageValue);
            }
          },
          icon: EzIcon(PlatformIcons(context).clear),
          label: l10n.isClearIt,
        ),
      ));
    }

    // Update theme (optional)
    if (widget.updateTheme != null && widget.updateThemeOption) {
      options.add(Padding(
        padding: EzInsets.wrap(spacing),
        child: EzSwitchPair(
          key: ValueKey<bool>(updateTheme),
          text: l10n.isUseForColors,
          value: updateTheme,
          onChanged: (bool? choice) {
            updateTheme = (choice == null) ? false : choice;
            dialogState(() {});
            setState(() {});
          },
        ),
      ));
    }

    return options;
  }

  /// Opens an [BottomSheet] to pick the [ImageSource] for updating [widget.configKey]
  /// Returns the path, if any, to the new [Image]
  Future<dynamic> chooseImage(BuildContext context) => showModalBottomSheet(
        context: context,
        builder: (BuildContext modalContext) => StatefulBuilder(
          builder: (_, StateSetter modalState) => EzScrollView(
            mainAxisSize: MainAxisSize.min,
            children: sourceOptions(
              dialogContext: modalContext,
              dialogState: modalState,
            ),
          ),
        ),
      );

  /// Opens a preview [EzAlertDialog] for choosing the desired [BoxFit]
  Future<void> chooseFit(ThemeData theme) {
    final double width = widthOf(context) * 0.25;
    final double height = heightOf(context) * 0.25;

    return showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (_) => StatefulBuilder(
        builder: (BuildContext fitContext, StateSetter fitState) {
          return EzScrollView(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                l10n.isFit,
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              separator,
              EzScrollView(
                scrollDirection: Axis.horizontal,
                primary: false,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  rowSpacer,
                  fitPreview(
                    fit: BoxFit.contain,
                    width: width,
                    height: height,
                    modalState: fitState,
                    theme: theme,
                  ),
                  rowSpacer,
                  fitPreview(
                    fit: BoxFit.cover,
                    width: width,
                    height: height,
                    modalState: fitState,
                    theme: theme,
                  ),
                  rowSpacer,
                  fitPreview(
                    fit: BoxFit.fill,
                    width: width,
                    height: height,
                    modalState: fitState,
                    theme: theme,
                  ),
                  rowSpacer,
                  fitPreview(
                    fit: BoxFit.fitWidth,
                    width: width,
                    height: height,
                    modalState: fitState,
                    theme: theme,
                  ),
                  rowSpacer,
                  fitPreview(
                    fit: BoxFit.fitHeight,
                    width: width,
                    height: height,
                    modalState: fitState,
                    theme: theme,
                  ),
                  rowSpacer,
                  fitPreview(
                    fit: BoxFit.none,
                    width: width,
                    height: height,
                    modalState: fitState,
                    theme: theme,
                  ),
                  rowSpacer,
                  fitPreview(
                    fit: BoxFit.scaleDown,
                    width: width,
                    height: height,
                    modalState: fitState,
                    theme: theme,
                  ),
                  rowSpacer,
                ],
              ),
              separator,
              EzRow(
                mainAxisAlignment:
                    isLefty ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: <Widget>[
                  rowSpacer,
                  EzTextButton(
                    onPressed: () => Navigator.of(fitContext).pop(),
                    text: l10n.gCancel,
                    textStyle: theme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  rowSpacer,
                  EzTextButton(
                    onPressed: () async {
                      if (selected != null) {
                        await EzConfig.setString(
                          '${widget.configKey}$boxFitSuffix',
                          selected!.name,
                        );
                      }

                      if (fitContext.mounted) Navigator.of(fitContext).pop();
                    },
                    text: l10n.gApply,
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

  /// First-layer [ElevatedButton.onPressed]
  /// Runs the [chooseImage] dialog and updates the state accordingly
  Future<void> activateSetting(ThemeData theme) async {
    final dynamic newPath = await chooseImage(context);

    if (newPath is String) {
      currPath = newPath;
      final String? defaultPath = EzConfig.getDefault(widget.configKey);

      if (widget.updateTheme != null &&
          updateTheme &&
          newPath != noImageValue &&
          newPath != defaultPath) {
        setState(() => inProgress = true);

        final String result = await storeImageColorScheme(
          brightness: widget.updateTheme!,
          path: newPath,
        );

        if (result != success) {
          await EzConfig.remove(widget.configKey);
          currPath = null;

          setState(() => inProgress = false);

          if (mounted) {
            await ezLogAlert(
              context,
              title: l10n.isGetFailed,
              message:
                  '$result${ezUrlCheck(newPath) ? '\n\n${l10n.isPermission}' : ''}',
            );
          }
          return;
        }

        widget.updateTheme == Brightness.light
            ? await EzConfig.setString(lightColorSchemeImageKey, newPath)
            : await EzConfig.setString(darkColorSchemeImageKey, newPath);
      }

      if (currPath != noImageValue) {
        if (widget.showFitOption) await chooseFit(theme);

        // If the user set a background image and doesn't have text opacity, quickly set it to 50% so they will have a chance to read things
        final double? lightOpacity =
            EzConfig.get(lightTextBackgroundOpacityKey);
        final double? darkOpacity = EzConfig.get(darkTextBackgroundOpacityKey);

        if (widget.updateTheme == Brightness.light) {
          if (lightOpacity == null || lightOpacity == 0.0) {
            await EzConfig.setDouble(lightTextBackgroundOpacityKey, 0.5);
          }
        } else {
          if (darkOpacity == null || darkOpacity == 0.0) {
            await EzConfig.setDouble(lightTextBackgroundOpacityKey, 0.5);
          }
        }
      }
    }

    // Here to act as a a "default" for clearing and/or resetting the image
    setState(() => inProgress = false);
  }

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

  @override
  Widget build(BuildContext context) {
    // Gather the dynamic theme data //

    late final ThemeData theme = Theme.of(context);

    // Return the build //
    return Semantics(
      label: widget.label,
      button: true,
      hint: l10n.isButtonHint(widget.label),
      child: ExcludeSemantics(
        child: EzElevatedIconButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(padding * 0.75),
          ),
          onPressed: () => inProgress ? doNothing() : activateSetting(theme),
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
    urlText.dispose();
    super.dispose();
  }
}
