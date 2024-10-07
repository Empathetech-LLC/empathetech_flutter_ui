/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

// EzImageSetting has not yet been verified with TalkBack or VoiceOver //

class EzImageSetting extends StatefulWidget {
  /// [EzConfig] key whose value is being updated
  final String configKey;

  /// [String] to display on the [ElevatedButton]
  final String label;

  /// Effectively whether the image is nullable
  /// Recommended to true
  /// Note: if there is no [EzConfig.defaults] value for [configKey], the reset option will not appear
  final bool allowClear;

  /// Optional [EzAlertDialog] title override
  final String? dialogTitle;

  /// Who made this/where did it come from?
  /// [credits] will be displayed via [EzAlertDialog] on [EzImageSetting] long press
  final String? credits;

  /// Which theme this image should be used for [ColorScheme.fromImageProvider] (if any)
  final Brightness? updateTheme;

  /// Whether the update theme checkbox && message should be displayed
  final bool updateThemeOption;

  /// Whether the [BoxFit] options dialog should be displayed upon successful image selection
  final bool showFitOption;

  /// Creates a tool for updating the image at [configKey]'s path
  /// [EzImageSetting] inherits styling from the [ElevatedButton] and [AlertDialog] values in your [ThemeData]
  const EzImageSetting({
    super.key,
    required this.configKey,
    required this.label,
    this.allowClear = true,
    this.dialogTitle,
    this.credits,
    this.updateTheme,
    this.updateThemeOption = true,
    this.showFitOption = true,
  });

  @override
  State<EzImageSetting> createState() => _ImageSettingState();
}

class _ImageSettingState extends State<EzImageSetting> {
  // Gather the theme data //

  static const EzSpacer spacer = EzSpacer();

  final double margin = EzConfig.get(marginKey);
  final double padding = EzConfig.get(paddingKey);

  final bool isLefty = EzConfig.get(isLeftyKey) ?? false;

  late final ThemeData theme = Theme.of(context);
  late final EFUILang l10n = EFUILang.of(context)!;

  late final TargetPlatform platform = Theme.of(context).platform;

  // Define build data //

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
    required StateSetter dialogState,
  }) {
    final String name = fit.name;
    final double toolbarHeight = measureText(
          name,
          style: theme.textTheme.bodyLarge,
          context: context,
        ).height +
        (margin * 0.25);

    final Widget selectButton = Radio<BoxFit>(
      groupValue: selected,
      value: fit,
      onChanged: (BoxFit? value) {
        selected = value;
        setState(() {});
        dialogState(() {});
      },
    );

    return SizedBox(
      width: width,
      height: height,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, toolbarHeight),
          child: AppBar(
            excludeHeaderSemantics: true,
            toolbarHeight: toolbarHeight,

            // Leading (aka left)
            leading: isLefty ? selectButton : const SizedBox.shrink(),

            // Title
            title: Text(
              name,
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
            titleSpacing: 0,

            // Actions (aka trailing aka right)
            actions: isLefty ? null : <Widget>[selectButton],
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainer,
            image: DecorationImage(
              image: provideImage(currPath!),
              fit: fit,
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
      ),
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
  String? urlValidator(String? value) {
    if (value == null || value.isEmpty || !isUrl(value)) {
      return 'Enter a valid URL';
    }
    return null;
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
      options.addAll(<Widget>[
        EzElevatedIconButton(
          onPressed: () async {
            final String? changed = await saveImage(
              context: context,
              prefsPath: widget.configKey,
              source: ImageSource.camera,
            );

            if (dialogContext.mounted) {
              Navigator.of(dialogContext).pop(changed);
            }
          },
          icon: Icon(PlatformIcons(context).photoCamera),
          label: l10n.isFromCamera,
        ),
        spacer,
      ]);
    }

    // From file
    // Doesn't work on web
    if (!kIsWeb) {
      options.addAll(<Widget>[
        EzElevatedIconButton(
          onPressed: () async {
            final String? changed = await saveImage(
              context: context,
              prefsPath: widget.configKey,
              source: ImageSource.gallery,
            );

            if (dialogContext.mounted) {
              Navigator.of(dialogContext).pop(changed);
            }
          },
          icon: Icon(PlatformIcons(context).folder),
          label: l10n.isFromFile,
        ),
        spacer,
      ]);
    }

    // From network
    // Works everywhere
    options.addAll(<Widget>[
      EzElevatedIconButton(
        onPressed: () => showPlatformDialog(
          context: context,
          builder: (BuildContext networkDialogContext) {
            void onConfirm() async {
              closeKeyboard(networkDialogContext);

              // Validate the URL
              final String url = urlText.text.trim();

              if (urlValidator(url) != null) return;

              // Verify that the image is accessible
              late final NetworkImage image;
              try {
                image = NetworkImage(urlText.text);
              } catch (e) {
                await logAlert(
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
                  validator: urlValidator,
                ),
              ),
              materialActions: ezMaterialActions(
                context: context,
                confirmMsg: l10n.gApply,
                onConfirm: onConfirm,
                confirmIsDestructive: true,
                denyMsg: l10n.gCancel,
                onDeny: onDeny,
              ),
              cupertinoActions: ezCupertinoActions(
                context: context,
                confirmMsg: l10n.gApply,
                onConfirm: onConfirm,
                confirmIsDestructive: true,
                denyMsg: l10n.gCancel,
                onDeny: onDeny,
              ),
              needsClose: false,
            );
          },
        ),
        icon: const Icon(Icons.computer_outlined),
        label: l10n.isFromNetwork,
      ),
    ]);

    // Reset
    if (defaultPath != null) {
      options.addAll(<Widget>[
        spacer,
        EzElevatedIconButton(
          onPressed: () async {
            cleanup();
            await EzConfig.remove(widget.configKey);

            if (dialogContext.mounted) {
              Navigator.of(dialogContext).pop(defaultPath);
            }
          },
          icon: Icon(PlatformIcons(context).refresh),
          label: l10n.isResetIt,
        ),
      ]);
    }

    // Clear (optional)
    if (widget.allowClear) {
      options.addAll(<Widget>[
        spacer,
        EzElevatedIconButton(
          onPressed: () async {
            cleanup();
            await EzConfig.setString(widget.configKey, noImageValue);

            if (dialogContext.mounted) {
              Navigator.of(dialogContext).pop(noImageValue);
            }
          },
          icon: Icon(PlatformIcons(context).clear),
          label: l10n.isClearIt,
        ),
      ]);
    }

    // Update theme (optional)
    if (widget.updateTheme != null && widget.updateThemeOption) {
      options.addAll(<Widget>[
        spacer,
        EzRow(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Label
            Flexible(
              child: Text(
                l10n.isUseForColors,
                textAlign: TextAlign.center,
              ),
            ),

            // Check box
            Checkbox(
              value: updateTheme,
              onChanged: (bool? choice) {
                updateTheme = (choice == null) ? false : choice;
                dialogState(() {});
                setState(() {});
              },
            ),
          ],
        )
      ]);
    }

    return options;
  }

  /// Opens an [EzAlertDialog] for choosing the [ImageSource] for updating [widget.configKey]
  /// Returns the path, if any, to the new [Image]
  Future<dynamic> chooseImage(BuildContext context) {
    return showPlatformDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (BuildContext dialogContext, StateSetter dialogState) {
          return EzAlertDialog(
            title: Text(
              widget.dialogTitle ??
                  l10n.isDialogTitle(widget.label.toLowerCase()),
              textAlign: TextAlign.center,
            ),
            contents: sourceOptions(
              dialogContext: dialogContext,
              dialogState: dialogState,
            ),
          );
        },
      ),
    );
  }

  /// Opens a preview [EzAlertDialog] for choosing the desired [BoxFit]
  Future<void> chooseFit() {
    return showPlatformDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (BuildContext fitContext, StateSetter fitState) {
          void onConfirm() async {
            if (selected != null) {
              await EzConfig.setString(
                '${widget.configKey}$boxFitSuffix',
                selected!.name,
              );
            }

            if (fitContext.mounted) Navigator.of(fitContext).pop();
          }

          void onDeny() => Navigator.of(fitContext).pop();

          final double width = widthOf(context) * 0.25;
          final double height = heightOf(context) * 0.25;

          return EzAlertDialog(
            title: Text(l10n.isFit, textAlign: TextAlign.center),
            contents: <Widget>[
              fitPreview(
                fit: BoxFit.contain,
                width: width,
                height: height,
                dialogState: fitState,
              ),
              spacer,
              fitPreview(
                fit: BoxFit.cover,
                width: width,
                height: height,
                dialogState: fitState,
              ),
              spacer,
              fitPreview(
                fit: BoxFit.fill,
                width: width,
                height: height,
                dialogState: fitState,
              ),
              spacer,
              fitPreview(
                fit: BoxFit.fitWidth,
                width: width,
                height: height,
                dialogState: fitState,
              ),
              spacer,
              fitPreview(
                fit: BoxFit.fitHeight,
                width: width,
                height: height,
                dialogState: fitState,
              ),
              spacer,
              fitPreview(
                fit: BoxFit.none,
                width: width,
                height: height,
                dialogState: fitState,
              ),
              spacer,
              fitPreview(
                fit: BoxFit.scaleDown,
                width: width,
                height: height,
                dialogState: fitState,
              ),
            ],
            materialActions: ezMaterialActions(
              context: context,
              confirmMsg: l10n.gApply,
              onConfirm: onConfirm,
              confirmIsDestructive: true,
              denyMsg: l10n.gCancel,
              onDeny: onDeny,
            ),
            cupertinoActions: ezCupertinoActions(
              context: context,
              confirmMsg: l10n.gApply,
              onConfirm: onConfirm,
              confirmIsDestructive: true,
              denyMsg: l10n.gCancel,
              onDeny: onDeny,
            ),
            needsClose: false,
          );
        },
      ),
    );
  }

  /// First-layer [ElevatedButton.onPressed]
  /// Runs the [chooseImage] dialog and updates the state accordingly
  Future<void> activateSetting() async {
    final dynamic newPath = await chooseImage(context);

    if (newPath is String) {
      currPath = newPath;

      if (widget.updateTheme != null &&
          updateTheme &&
          newPath != noImageValue) {
        setState(() => inProgress = true);

        final String result = await storeImageColorScheme(
          brightness: widget.updateTheme!,
          path: newPath,
        );

        if (result != success) {
          await EzConfig.remove(widget.configKey);
          currPath = null;

          setState(() => inProgress = false);

          if (context.mounted) {
            await logAlert(
              // ignore: use_build_context_synchronously
              context,
              title: l10n.isGetFailed,
              message: '$result\n\n${l10n.isPermission}',
            );
          }
          return;
        }

        widget.updateTheme == Brightness.light
            ? await EzConfig.setString(lightColorSchemeImageKey, newPath)
            : await EzConfig.setString(darkColorSchemeImageKey, newPath);
      }
    }

    if (widget.showFitOption && currPath != null && currPath != noImageValue) {
      await chooseFit();
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

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      hint: l10n.isButtonHint(widget.label),
      child: ExcludeSemantics(
        child: EzElevatedIconButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(padding * 0.75),
          ),
          onPressed: inProgress ? doNothing : activateSetting,
          onLongPress: inProgress ? doNothing : showCredits,
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: theme.colorScheme.onSurface),
            ),
            child: CircleAvatar(
              radius: padding * 2 + margin * 0.5,
              foregroundImage:
                  (inProgress || currPath == null || currPath == noImageValue)
                      ? null
                      : provideImage(currPath!),
              backgroundColor: Colors.transparent,
              foregroundColor: theme.colorScheme.onSurface,
              child: inProgress
                  ? const CircularProgressIndicator()
                  : (currPath == null || currPath == noImageValue)
                      ? Icon(
                          PlatformIcons(context).edit,
                          color: theme.colorScheme.primary,
                          size: theme.textTheme.headlineLarge?.fontSize,
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
