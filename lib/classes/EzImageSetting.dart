/// empathetech_flutter_ui
/// Copyright (c) 2023 Empathetech LLC. All rights reserved.
/// See LICENSE for distribution and usage details.

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzImageSetting extends StatefulWidget {
  /// [EzConfig] key whose path value is being updated
  final String prefsKey;

  /// [String] label for the [Image.semanticsLabel]
  final String semantics;

  /// Whether the image is intended for fullscreen use
  /// For example: [lightBackgroundImageKey]
  final bool fullscreen;

  /// [String] to display on the [ElevatedButton]
  final String title;

  /// Who made this/where'd ya get it?
  /// Credits [String] will be displayed via [EzDialog] when holding the [ElevatedButton]
  final String credits;

  /// Effectively whether the image is nullable
  final bool allowClear;

  /// Creates a tool for updating the image at [prefsKey]'s path
  const EzImageSetting({
    Key? key,
    required this.semantics,
    required this.prefsKey,
    required this.fullscreen,
    required this.title,
    required this.credits,
    required this.allowClear,
  }) : super(key: key);

  @override
  _ImageSettingState createState() => _ImageSettingState();
}

class _ImageSettingState extends State<EzImageSetting> {
  late String title = widget.title;
  late String currPathKey = widget.prefsKey;

  String? updatedPath; // Only used when the user makes a change

  final double space = EzConfig.instance.prefs[buttonSpacingKey];

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

  /// Opens an [EzDialog] for choosing the [ImageSource] for updating the prefsKey
  /// Selection is sent to [changeImage]
  Future<dynamic> _chooseImage() {
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
      EzSpacer(space),

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
      EzSpacer(space),

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
        EzSpacer(space),
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
      builder: (context) => EzDialog(
        title: EzSelectableText('Update $title'),
        contents: options,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // Choose image
      onPressed: () async {
        dynamic newPath = await _chooseImage();
        if (newPath is String)
          setState(() {
            updatedPath = newPath;
          });
      },

      // Show credits
      onLongPress: () => showPlatformDialog(
        context: context,
        builder: (context) => EzDialog(
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
          Text(title),

          // Preview on the right
          // 16:9 for backgrounds, 1:1 for the rest
          SizedBox(
            height: widget.fullscreen ? 160 : 75,
            width: widget.fullscreen ? 90 : 75,
            child: (updatedPath is String) // user made a change
                ? (updatedPath == noImageKey)
                    ? Icon(PlatformIcons(context).clear)
                    : EzImage(
                        image: AssetImage(updatedPath as String),
                        semanticLabel: widget.semantics,
                      )
                : (currPathKey == noImageKey) // using app's current state
                    ? Icon(PlatformIcons(context).clear)
                    : EzStoredImage(
                        prefsKey: currPathKey,
                        semanticLabel: widget.semantics,
                      ),
          ),
        ],
      ),
    );
  }
}
