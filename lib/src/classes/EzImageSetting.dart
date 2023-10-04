/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../l10n/app_localizations.dart';
import '../../empathetech_flutter_ui.dart';

import 'dart:io';
import 'package:flutter/material.dart';
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

  /// Who made this/where'd ya get it?
  /// Credits [String] will be displayed via [EzAlertDialog] when holding the [ElevatedButton]
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

  /// Opens an [EzAlertDialog] for choosing the [ImageSource] for updating the prefsKey
  /// Selection is sent to [changeImage]
  Future<dynamic> _chooseImage(BuildContext context) {
    // Build the dialog opitions //

    List<Widget> options = [
      // Chose from file
      ElevatedButton.icon(
        onPressed: () async {
          String? changed = await changeImage(
            context: context,
            prefsPath: widget.prefsKey,
            source: ImageSource.gallery,
          );

          popScreen(context: context, pass: changed);
        },
        label: Text(AppLocalizations.of(context)!.fromFile),
        icon: Icon(PlatformIcons(context).folder),
      ),
      EzSpacer(_buttonSpacer),

      // Chose from camera
      ElevatedButton.icon(
        onPressed: () async {
          String? changed = await changeImage(
            context: context,
            prefsPath: widget.prefsKey,
            source: ImageSource.camera,
          );

          popScreen(context: context, pass: changed);
        },
        label: Text(AppLocalizations.of(context)!.fromCamera),
        icon: Icon(PlatformIcons(context).photoCamera),
      ),
      EzSpacer(_buttonSpacer),

      // Reset image
      ElevatedButton.icon(
        onPressed: () {
          _cleanup();

          EzConfig.instance.preferences.remove(widget.prefsKey);

          popScreen(
            context: context,
            pass: EzConfig.instance.defaults[widget.prefsKey],
          );
        },
        label: Text(AppLocalizations.of(context)!.resetIt),
        icon: Icon(PlatformIcons(context).refresh),
      ),
    ];

    // Clear image (optional)
    if (widget.allowClear)
      options.addAll([
        EzSpacer(_buttonSpacer),
        ElevatedButton.icon(
          onPressed: () {
            _cleanup();

            EzConfig.instance.preferences.setString(widget.prefsKey, noImageKey);

            popScreen(context: context, pass: noImageKey);
          },
          label: Text(AppLocalizations.of(context)!.clearIt),
          icon: Icon(PlatformIcons(context).clear),
        ),
      ]);

    // Return the dialog //

    return showPlatformDialog(
      context: context,
      builder: (context) => EzAlertDialog(
        title: EzSelectableText(
          AppLocalizations.of(context)!.imageSettingDialogTitle(widget.title),
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
      hint: AppLocalizations.of(context)!.imageSettingHint(widget.title),
      child: ExcludeSemantics(
        child: ElevatedButton(
          // On pressed -> choose image
          onPressed: () async {
            dynamic newPath = await _chooseImage(context);
            if (newPath is String)
              setState(() {
                _updatedPath = newPath;
              });
          },

          // On long press -> show credits
          onLongPress: () => showPlatformDialog(
            context: context,
            builder: (context) => EzAlertDialog(
              title: EzSelectableText(AppLocalizations.of(context)!.creditTo),
              contents: [EzSelectableText(widget.credits)],
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
                  height: widget.fullscreen ? 160 : 75,
                  width: widget.fullscreen ? 90 : 75,
                  child: (_updatedPath is String)
                      ? // user made a change
                      (_updatedPath == noImageKey)
                          ? // user cleared the image
                          Icon(PlatformIcons(context).clear)
                          : // user set a custom image
                          EzImage(
                              image: provideStoredImage(_updatedPath!),
                              semanticLabel: widget.title + AppLocalizations.of(context)!.image,
                            )
                      : // user has not made a change
                      (EzConfig.instance.prefs[widget.prefsKey] == null ||
                              EzConfig.instance.prefs[widget.prefsKey] == noImageKey)
                          ? // there is no current image
                          Icon(PlatformIcons(context).clear)
                          : // there is an image stored
                          EzImage(
                              image: provideStoredImage(EzConfig.instance.prefs[widget.prefsKey]),
                              semanticLabel: widget.title + AppLocalizations.of(context)!.image,
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
