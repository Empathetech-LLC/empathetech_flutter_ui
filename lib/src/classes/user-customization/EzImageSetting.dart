/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
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
  /// [EzConfig.instance] key whose value is being updated
  final String prefsKey;

  /// [String] to display on the [ElevatedButton]
  final String label;

  /// Optional [EzAlertDialog] title override
  /// Will be the same as [label] otherwise
  final String? dialogTitle;

  /// Effectively whether the image is nullable
  final bool allowClear;

  /// Whether the image is intended for fullscreen use
  final bool fullscreen;

  /// Who made this/where did it come from?
  /// [credits] will be displayed via [EzAlertDialog] on [EzImageSetting] long press
  final String? credits;

  /// Which theme this image should be used for [ColorScheme.fromImageProvider] (if any)
  final Brightness? updateTheme;

  /// [updateTheme] override
  /// Mostly for use in a/the color settings screen
  final bool hideThemeMessage;

  /// Creates a tool for updating the image at [prefsKey]'s path
  const EzImageSetting({
    Key? key,
    required this.prefsKey,
    required this.label,
    this.dialogTitle,
    required this.allowClear,
    required this.fullscreen,
    this.credits,
    this.updateTheme,
    this.hideThemeMessage = false,
  }) : super(key: key);

  @override
  _ImageSettingState createState() => _ImageSettingState();
}

class _ImageSettingState extends State<EzImageSetting> {
  // Gather theme data //

  String? _updatedPath;
  bool? _updateTheme;

  final double _padding = EzConfig.get(paddingKey);
  final double _buttonSpacer = EzConfig.get(buttonSpacingKey);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      _updateTheme = (widget.updateTheme != null);
    });
  }

  // Define button functions //

  /// Cleanup any custom files
  void _cleanup() async {
    if (!EzConfig.isKeyAsset(widget.prefsKey)) {
      try {
        File toDelete = File(widget.prefsKey);
        await toDelete.delete();
      } catch (e) {
        doNothing();
      }
    }
  }

  /// Opens an [EzAlertDialog] for choosing the [ImageSource] for updating [widget.prefsKey]
  /// Selection is sent to [changeImage]
  Future<dynamic> _chooseImage(BuildContext context) {
    // Build the dialog options //

    List<Widget> options = [];

    // From file && camera rely on path provider, which isn't supported by Flutter Web
    if (!kIsWeb) {
      options.addAll([
        // From file
        ElevatedButton.icon(
          onPressed: () async {
            String? changed = await changeImage(
              context: context,
              prefsPath: widget.prefsKey,
              source: ImageSource.gallery,
            );

            popScreen(context: context, pass: changed);
          },
          label: Text(EFUILang.of(context)!.isFromFile),
          icon: Icon(PlatformIcons(context).folder),
        ),
        EzSpacer(_buttonSpacer),

        // From camera
        ElevatedButton.icon(
          onPressed: () async {
            String? changed = await changeImage(
              context: context,
              prefsPath: widget.prefsKey,
              source: ImageSource.camera,
            );

            popScreen(context: context, pass: changed);
          },
          label: Text(EFUILang.of(context)!.isFromCamera),
          icon: Icon(PlatformIcons(context).photoCamera),
        ),
        EzSpacer(_buttonSpacer),
      ]);
    }

    // From network && reset work everywhere
    options.addAll([
      // From network
      ElevatedButton.icon(
        onPressed: () async {
          String changed = await showPlatformDialog(
            context: context,
            builder: (context) {
              String url = '';
              return StatefulBuilder(
                builder: (context, setState) {
                  return EzAlertDialog(
                    title: Text(
                      EFUILang.of(context)!.isEnterURL,
                      textAlign: TextAlign.center,
                    ),
                    contents: [
                      PlatformTextFormField(
                        onChanged: (value) {
                          url = value;
                        },
                        hintText: 'https://example.com/image.jpg',
                        style: Theme.of(context).dialogTheme.contentTextStyle,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty || !isUrl(value)) {
                            return 'Enter a valid URL';
                          }
                          return null;
                        },
                      ),
                    ],
                    materialActions: ezMaterialActions(
                      context: context,
                      onConfirm: () {
                        EzConfig.setString(widget.prefsKey, url);
                        popScreen(context: context, pass: url);
                      },
                      confirmMsg: EFUILang.of(context)!.gApply,
                      onDeny: () => popScreen(context: context, pass: null),
                      denyMsg: EFUILang.of(context)!.gCancel,
                    ),
                    cupertinoActions: ezCupertinoActions(
                      context: context,
                      onConfirm: () {
                        EzConfig.setString(widget.prefsKey, url);
                        popScreen(context: context, pass: url);
                      },
                      confirmMsg: EFUILang.of(context)!.gApply,
                      onDeny: () => popScreen(context: context, pass: null),
                      denyMsg: EFUILang.of(context)!.gCancel,
                    ),
                    needsClose: false,
                  );
                },
              );
            },
          );

          popScreen(context: context, pass: changed);
        },
        label: Text(EFUILang.of(context)!.isFromNetwork),
        icon: const Icon(Icons.computer_outlined),
      ),
      EzSpacer(_buttonSpacer),

      // Reset
      ElevatedButton.icon(
        onPressed: () {
          _cleanup();

          EzConfig.remove(widget.prefsKey);

          popScreen(
            context: context,
            pass: EzConfig.getDefault(widget.prefsKey),
          );
        },
        label: Text(EFUILang.of(context)!.isResetIt),
        icon: Icon(PlatformIcons(context).refresh),
      ),
    ]);

    // Clear (optional)
    if (widget.allowClear)
      options.addAll([
        EzSpacer(_buttonSpacer),
        ElevatedButton.icon(
          onPressed: () {
            _cleanup();

            EzConfig.setString(widget.prefsKey, noImageValue);

            popScreen(context: context, pass: noImageValue);
          },
          label: Text(EFUILang.of(context)!.isClearIt),
          icon: Icon(PlatformIcons(context).clear),
        ),
      ]);

    // Update theme (optional)
    if (widget.updateTheme != null && !widget.hideThemeMessage)
      options.addAll([
        EzSpacer(_buttonSpacer),
        EzRow(children: [
          Checkbox(
              value: _updateTheme,
              onChanged: (bool? choice) {
                setState(() {
                  _updateTheme = (choice == null) ? false : choice;
                });
              }),
          EzSpacer.row(_padding),
          Flexible(
            child: Text(
              EFUILang.of(context)!.isUseForColors,
              textAlign: TextAlign.center,
            ),
          ),
        ])
      ]);

    // Return the dialog //

    return showPlatformDialog(
      context: context,
      builder: (context) => EzAlertDialog(
        title: Text(
          EFUILang.of(context)!
              .isDialogTitle(widget.dialogTitle ?? widget.label),
          textAlign: TextAlign.center,
        ),
        contents: options,
      ),
    );
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      hint: EFUILang.of(context)!.isButtonHint(widget.label),
      child: ExcludeSemantics(
        child: TextButton(
          // On pressed -> choose image
          onPressed: () async {
            dynamic newPath = await _chooseImage(context);

            if (newPath is String) {
              setState(() {
                _updatedPath = newPath;
              });
              if (widget.updateTheme != null) {
                await storeColorScheme(
                  brightness: widget.updateTheme!,
                  path: newPath,
                );

                widget.updateTheme == Brightness.light
                    ? EzConfig.setString(lightColorSchemeImageKey, newPath)
                    : EzConfig.setString(darkColorSchemeImageKey, newPath);
              }
            }
          },

          // On long press -> show credits
          onLongPress: (widget.credits == null)
              ? null
              : () => showPlatformDialog(
                    context: context,
                    builder: (context) => EzAlertDialog(
                      title: Text(
                        EFUILang.of(context)!.isCreditTo,
                        textAlign: TextAlign.center,
                      ),
                      contents: [
                        Text(
                          widget.credits!,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),

          // Set custom style
          style: Theme.of(context).textButtonTheme.style?.copyWith(
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),

          // Button body
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Label on the left
              Text(widget.label, textAlign: TextAlign.center),
              EzSpacer.row(_padding),

              // Preview on the right
              // 16:9 for backgrounds, 1:1 for the rest
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    width: 1,
                  ),
                ),
                child: SizedBox(
                  width: widget.fullscreen ? 90 : 75,
                  height: widget.fullscreen ? 160 : 75,
                  child: (_updatedPath is String)
                      ? // user made a change
                      (_updatedPath == noImageValue)
                          ? // user cleared the image
                          Icon(PlatformIcons(context).clear)
                          : // user set a custom image
                          EzImage(
                              image: provideImage(_updatedPath!),
                              semanticLabel:
                                  widget.label + EFUILang.of(context)!.isImage,
                            )
                      : // user has not made a change
                      (EzConfig.get(widget.prefsKey) == null ||
                              EzConfig.get(widget.prefsKey) == noImageValue)
                          ? // there is no current image
                          Icon(PlatformIcons(context).clear)
                          : // there is an image stored
                          EzImage(
                              image:
                                  provideImage(EzConfig.get(widget.prefsKey)),
                              semanticLabel:
                                  widget.label + EFUILang.of(context)!.isImage,
                            ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
