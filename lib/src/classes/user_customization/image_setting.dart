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
  final bool allowClear;

  /// Optional [EzAlertDialog] title override
  /// Will be the same as [label] otherwise
  final String? dialogTitle;

  /// Who made this/where did it come from?
  /// [credits] will be displayed via [EzAlertDialog] on [EzImageSetting] long press
  final String? credits;

  /// Which theme this image should be used for [ColorScheme.fromImageProvider] (if any)
  final Brightness? updateTheme;

  /// [updateTheme] override
  /// Mostly for use in a/the color settings screen
  final bool hideThemeMessage;

  /// Creates a tool for updating the image at [configKey]'s path
  const EzImageSetting({
    super.key,
    required this.configKey,
    required this.label,
    required this.allowClear,
    this.dialogTitle,
    this.credits,
    this.updateTheme,
    this.hideThemeMessage = false,
  });

  @override
  State<EzImageSetting> createState() => _ImageSettingState();
}

class _ImageSettingState extends State<EzImageSetting> {
  // Gather the theme data //

  late String? currPath = EzConfig.get(widget.configKey);
  late bool updateTheme = (widget.updateTheme != null);

  final double padding = EzConfig.get(paddingKey);

  late final EzSpacer spacer = EzSpacer(EzConfig.get(spacingKey));

  late final ThemeData theme = Theme.of(context);

  late final EFUILang l10n = EFUILang.of(context)!;

  // Define button functions //

  /// Cleanup any custom [File]s
  void _cleanup() async {
    if (!EzConfig.isKeyAsset(widget.configKey)) {
      try {
        final File toDelete = File(widget.configKey);
        await toDelete.delete();
      } catch (e) {
        doNothing();
      }
    }
  }

  /// Build the list of [ImageSource] options
  List<Widget> _sourceOptions(StateSetter dialogState, BuildContext context) {
    final List<Widget> options = <Widget>[];

    // From file && camera rely on path_provider, which isn't supported by Flutter Web
    if (!kIsWeb) {
      options.addAll(<Widget>[
        // From file
        ElevatedButton.icon(
          onPressed: () async {
            final String? changed = await changeImage(
              context: context,
              prefsPath: widget.configKey,
              source: ImageSource.gallery,
            );

            popScreen(context: context, result: changed);
          },
          label: Text(l10n.isFromFile),
          icon: Icon(PlatformIcons(context).folder),
        ),
        spacer,

        // From camera
        ElevatedButton.icon(
          onPressed: () async {
            final String? changed = await changeImage(
              context: context,
              prefsPath: widget.configKey,
              source: ImageSource.camera,
            );

            popScreen(context: context, result: changed);
          },
          label: Text(l10n.isFromCamera),
          icon: Icon(PlatformIcons(context).photoCamera),
        ),
        spacer,
      ]);
    }

    // From network && reset work everywhere
    options.addAll(<Widget>[
      // From network
      ElevatedButton.icon(
        onPressed: () async {
          final String changed = await showPlatformDialog(
            context: context,
            builder: (BuildContext context) {
              String url = '';
              return StatefulBuilder(
                builder: (BuildContext context, Function setState) {
                  void onConfirm() {
                    if (isUrl(url)) {
                      EzConfig.setString(widget.configKey, url);
                      popScreen(context: context, result: url);
                    } else {
                      popScreen(context: context, result: null);
                    }
                  }

                  void onDeny() {
                    popScreen(context: context, result: null);
                  }

                  return EzAlertDialog(
                    title: Text(
                      l10n.isEnterURL,
                      textAlign: TextAlign.center,
                    ),
                    contents: <Widget>[
                      PlatformTextFormField(
                        onChanged: (String value) {
                          url = value;
                        },
                        hintText: 'https://example.com/image.jpg',
                        style: theme.dialogTheme.contentTextStyle,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          if (value == null || value.isEmpty || !isUrl(value)) {
                            return 'Enter a valid URL';
                          }
                          return null;
                        },
                      ),
                    ],
                    materialActions: ezMaterialActions(
                      context: context,
                      onConfirm: onConfirm,
                      confirmMsg: l10n.gApply,
                      onDeny: onDeny,
                      denyMsg: l10n.gCancel,
                    ),
                    cupertinoActions: ezCupertinoActions(
                      context: context,
                      onConfirm: onConfirm,
                      confirmMsg: l10n.gApply,
                      onDeny: onDeny,
                      denyMsg: l10n.gCancel,
                    ),
                    needsClose: false,
                  );
                },
              );
            },
          );

          popScreen(context: context, result: changed);
        },
        label: Text(l10n.isFromNetwork),
        icon: const Icon(Icons.computer_outlined),
      ),
      spacer,

      // Reset
      ElevatedButton.icon(
        onPressed: () {
          _cleanup();
          EzConfig.remove(widget.configKey);

          popScreen(
            context: context,
            result: EzConfig.getDefault(widget.configKey) ?? noImageValue,
          );
        },
        label: Text(l10n.isResetIt),
        icon: Icon(PlatformIcons(context).refresh),
      ),
    ]);

    // Clear (optional)
    if (widget.allowClear) {
      options.addAll(<Widget>[
        spacer,
        ElevatedButton.icon(
          onPressed: () {
            _cleanup();
            EzConfig.setString(widget.configKey, noImageValue);

            popScreen(context: context, result: noImageValue);
          },
          label: Text(l10n.isClearIt),
          icon: Icon(PlatformIcons(context).clear),
        ),
      ]);
    }

    // Update theme (optional)
    if (widget.updateTheme != null && !widget.hideThemeMessage) {
      options.addAll(<Widget>[
        spacer,
        EzRow(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Check box
            Checkbox(
              value: updateTheme,
              onChanged: (bool? choice) {
                setState(() {
                  dialogState(() {
                    updateTheme = (choice == null) ? false : choice;
                  });
                });
              },
            ),
            EzSpacer.row(padding),

            // Label
            Flexible(
              child: Text(
                l10n.isUseForColors,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        )
      ]);
    }

    return options;
  }

  /// Opens an [EzAlertDialog] for choosing the [ImageSource] for updating [widget.configKey]
  /// Returns the path, if any, to the new [Image]
  Future<dynamic> _chooseImage(BuildContext context) {
    return showPlatformDialog(
      context: context,
      builder: (BuildContext context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter dialogState) {
          return EzAlertDialog(
            title: Text(
              l10n.isDialogTitle(
                widget.dialogTitle ?? widget.label,
              ),
              textAlign: TextAlign.center,
            ),
            contents: _sourceOptions(dialogState, context),
          );
        },
      ),
    );
  }

  /// First-layer [ElevatedButton.onPressed]
  /// Runs the [_chooseImage] dialog and updates the state accordingly
  void _activateSetting() async {
    final dynamic newPath = await _chooseImage(context);

    if (newPath is String) {
      setState(() {
        currPath = newPath;
      });
      if (widget.updateTheme != null && newPath != noImageValue) {
        await storeImageColorScheme(
          brightness: widget.updateTheme!,
          path: newPath,
        );

        widget.updateTheme == Brightness.light
            ? EzConfig.setString(lightColorSchemeImageKey, newPath)
            : EzConfig.setString(darkColorSchemeImageKey, newPath);
      }
    }
  }

  /// Open an [EzAlertDialog] with the [Image]s source information
  Future<dynamic>? _showCredits() {
    return (widget.credits == null)
        ? null
        : showPlatformDialog(
            context: context,
            builder: (BuildContext context) => EzAlertDialog(
              title: Text(
                l10n.gCreditTo,
                textAlign: TextAlign.center,
              ),
              contents: <Widget>[
                Text(
                  widget.credits!,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          );
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      hint: l10n.isButtonHint(widget.label),
      child: ExcludeSemantics(
        child: ElevatedButton.icon(
          style: theme.elevatedButtonTheme.style!.copyWith(
            padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
              EdgeInsets.all(padding * 0.75),
            ),
            foregroundColor: MaterialStatePropertyAll<Color>(
              theme.colorScheme.onSurface,
            ),
          ),
          onPressed: _activateSetting,
          onLongPress: _showCredits,
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.colorScheme.primaryContainer,
              ),
            ),
            child: CircleAvatar(
              radius: padding * 2,
              foregroundImage: (currPath == null || currPath == noImageValue)
                  ? null
                  : provideImage(currPath!),
              backgroundColor: Colors.transparent,
              child: (currPath == null || currPath == noImageValue)
                  ? Icon(PlatformIcons(context).clear)
                  : null,
            ),
          ),
          label: Text(widget.label, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
