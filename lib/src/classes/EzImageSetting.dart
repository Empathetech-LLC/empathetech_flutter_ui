/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

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

  /// [String] label for the [Image.semanticLabel]
  final String semantics;

  /// Creates a tool for updating the image at [prefsKey]'s path
  const EzImageSetting({
    Key? key,
    required this.prefsKey,
    required this.title,
    required this.allowClear,
    required this.fullscreen,
    required this.credits,
    required this.semantics,
  }) : super(key: key);

  @override
  _ImageSettingState createState() => _ImageSettingState();
}

class _ImageSettingState extends State<EzImageSetting> {
  // Gather theme data //

  String? _updatedPath;

  final double _buttonSpacer = EzConfig.instance.prefs[buttonSpacingKey];

  // Define button functions //

  /// Cleanup any custom files
  void _cleanup() async {
    if (!isAsset(widget.prefsKey)) {
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
    List<Widget> options = [
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
        label: const Text('File'),
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
        label: const Text('Camera'),
        icon: Icon(PlatformIcons(context).photoCamera),
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
        label: const Text('Reset'),
        icon: Icon(PlatformIcons(context).refresh),
      ),
    ];

    if (widget.allowClear)
      options.addAll([
        EzSpacer(_buttonSpacer),
        ElevatedButton.icon(
          onPressed: () {
            _cleanup();

            EzConfig.instance.preferences.setString(
              widget.prefsKey,
              noImageKey,
            );

            popScreen(context: context, pass: noImageKey);
          },
          label: const Text('Clear'),
          icon: Icon(PlatformIcons(context).clear),
        ),
      ]);

    return showPlatformDialog(
      context: context,
      builder: (context) => EzAlertDialog(
        title: EzSelectableText("Update ${widget.title}"),
        contents: options,
      ),
    );
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // Choose image
      onPressed: () async {
        dynamic newPath = await _chooseImage(context);
        if (newPath is String)
          setState(() {
            _updatedPath = newPath;
          });
      },

      // Show credits
      onLongPress: () => showPlatformDialog(
        context: context,
        builder: (context) => EzAlertDialog(
          title: const EzSelectableText('Credit to:'),
          contents: [EzSelectableText(widget.credits)],
        ),
      ),

      // UI
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Title on the left
          Text(widget.title),

          // Preview on the right
          // 16:9 for backgrounds, 1:1 for the rest
          SizedBox(
            height: widget.fullscreen ? 160 : 75,
            width: widget.fullscreen ? 90 : 75,
            child: (_updatedPath is String) // user made a change
                ? (_updatedPath == noImageKey)
                    ? Icon(PlatformIcons(context).clear)
                    : EzImage(
                        image: AssetImage(_updatedPath as String),
                        semanticLabel: widget.semantics,
                      )
                : (widget.prefsKey == noImageKey) // using app's current state
                    ? Icon(PlatformIcons(context).clear)
                    : EzStoredImage(
                        prefsKey: widget.prefsKey,
                        semanticLabel: widget.semantics,
                      ),
          ),
        ],
      ),
    );
  }
}
