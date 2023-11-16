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
  final String title;

  /// Effectively whether the image is nullable
  final bool allowClear;

  /// Whether the image is intended for fullscreen use
  final bool fullscreen;

  /// Who made this/where did it come from?
  /// [credits] will be displayed via [EzAlertDialog] on [EzImageSetting] long press
  final String credits;

  /// Creates a tool for updating the image at [prefsKey]'s path
  const EzImageSetting({
    Key? key,
    required this.prefsKey,
    required this.title,
    required this.allowClear,
    required this.fullscreen,
    required this.credits,
  }) : super(key: key);

  @override
  _ImageSettingState createState() => _ImageSettingState();
}

class _ImageSettingState extends State<EzImageSetting> {
  // Gather theme data //

  String? _updatedPath;

  final double _padding = EzConfig.instance.prefs[paddingKey];
  final double _buttonSpacer = EzConfig.instance.prefs[buttonSpacingKey];

  // Define button functions //

  /// Cleanup any custom files
  void _cleanup() async {
    if (!isKeyAsset(widget.prefsKey)) {
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
                    title: EzText(EFUILang.of(context)!.isEnterURL),
                    contents: [
                      TextFormField(
                        onChanged: (value) {
                          url = value;
                        },
                        decoration: InputDecoration(
                          labelText: 'Enter URL',
                          hintText: 'https://example.com/image.jpg',
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty || !isUrl(value)) {
                            return 'Enter a valid URL';
                          }
                          return null;
                        },
                      ),
                      if (isUrl(url))
                        EzImage(
                          image: NetworkImage(url),
                          width: widget.fullscreen ? 160 : 75,
                          height: widget.fullscreen ? 160 : 75,
                          semanticLabel: EFUILang.of(context)!.isNetworkPreview,
                        ),
                    ],
                    materialActions: ezMaterialActions(
                      context: context,
                      onConfirm: () {
                        EzConfig.instance.preferences
                            .setString(widget.prefsKey, url);
                        popScreen(context: context, pass: url);
                      },
                      onDeny: () => popScreen(context: context, pass: null),
                    ),
                    cupertinoActions: ezCupertinoActions(
                      context: context,
                      onConfirm: () {
                        EzConfig.instance.preferences
                            .setString(widget.prefsKey, url);
                        popScreen(context: context, pass: url);
                      },
                      onDeny: () => popScreen(context: context, pass: null),
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

          EzConfig.instance.preferences.remove(widget.prefsKey);

          popScreen(
            context: context,
            pass: EzConfig.instance.defaults[widget.prefsKey],
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

            EzConfig.instance.preferences
                .setString(widget.prefsKey, noImageKey);

            popScreen(context: context, pass: noImageKey);
          },
          label: Text(EFUILang.of(context)!.isClearIt),
          icon: Icon(PlatformIcons(context).clear),
        ),
      ]);

    // Return the dialog //

    return showPlatformDialog(
      context: context,
      builder: (context) => EzAlertDialog(
        title: EzText(EFUILang.of(context)!.isDialogTitle(widget.title)),
        contents: options,
      ),
    );
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      hint: EFUILang.of(context)!.isButtonHint(widget.title),
      child: ExcludeSemantics(
        child: ElevatedButton(
          // On pressed -> choose image
          onPressed: () async {
            dynamic newPath = await _chooseImage(context);

            if (newPath is String) {
              setState(() {
                _updatedPath = newPath;
              });
            }
          },

          // On long press -> show credits
          onLongPress: () => showPlatformDialog(
            context: context,
            builder: (context) => EzAlertDialog(
              title: EzText(EFUILang.of(context)!.isCreditTo),
              contents: [EzText(widget.credits)],
            ),
          ),

          // Button body
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Title on the left
              Text(widget.title),
              EzSpacer.row(_padding),

              // Preview on the right
              // 16:9 for backgrounds, 1:1 for the rest
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 1,
                  ),
                ),
                child: SizedBox(
                  width: widget.fullscreen ? 90 : 75,
                  height: widget.fullscreen ? 160 : 75,
                  child: (_updatedPath is String)
                      ? // user made a change
                      (_updatedPath == noImageKey)
                          ? // user cleared the image
                          Icon(PlatformIcons(context).clear)
                          : // user set a custom image
                          EzImage(
                              image: provideImage(_updatedPath!),
                              semanticLabel:
                                  widget.title + EFUILang.of(context)!.isImage,
                            )
                      : // user has not made a change
                      (EzConfig.instance.prefs[widget.prefsKey] == null ||
                              EzConfig.instance.prefs[widget.prefsKey] ==
                                  noImageKey)
                          ? // there is no current image
                          Icon(PlatformIcons(context).clear)
                          : // there is an image stored
                          EzImage(
                              image: provideImage(
                                  EzConfig.instance.prefs[widget.prefsKey]),
                              semanticLabel:
                                  widget.title + EFUILang.of(context)!.isImage,
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
