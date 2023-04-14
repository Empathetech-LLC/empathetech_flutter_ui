library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzImageSetting extends StatefulWidget {
  /// Creates a tool for updating the image at [prefsKey]'s path
  const EzImageSetting({
    Key? key,
    required this.prefsKey,
    required this.fullscreen,
    required this.title,
    required this.credits,
    required this.allowClear,
  }) : super(key: key);

  final String prefsKey;
  final bool fullscreen;
  final String title;
  final String credits;
  final bool allowClear;

  @override
  _ImageSettingState createState() => _ImageSettingState();
}

class _ImageSettingState extends State<EzImageSetting> {
  late String title = widget.title;
  late String currPathKey = widget.prefsKey;
  String? updatedPath; // Only used when the user makes a change

  late TextStyle buttonTextStyle = buildTextStyle(style: buttonStyleKey);

  late double buttonSpacer = EzConfig.prefs[buttonSpacingKey];
  late double dialogSpacer = EzConfig.prefs[dialogSpacingKey];

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

  /// Opens an [ezDialog] for choosing the [ImageSource] for updating the prefsKey
  /// Selection is sent to [changeImage]
  Future<dynamic> _chooseImage() {
    List<Widget> options = [
      // From file
      EzButton.icon(
        action: () async {
          String? changed = await changeImage(
            context: context,
            prefsPath: widget.prefsKey,
            source: ImageSource.gallery,
          );

          popScreen(context: context, pass: changed);
        },
        message: 'File',
        icon: EzIcon(PlatformIcons(context).folder),
      ),
      Container(height: buttonSpacer),

      // From camera
      EzButton.icon(
        action: () async {
          String? changed = await changeImage(
            context: context,
            prefsPath: widget.prefsKey,
            source: ImageSource.camera,
          );

          popScreen(context: context, pass: changed);
        },
        message: 'Camera',
        icon: EzIcon(PlatformIcons(context).photoCamera),
      ),
      Container(height: buttonSpacer),

      // Reset
      EzButton.icon(
        action: () {
          _cleanup();

          EzConfig.preferences.remove(widget.prefsKey);
          popScreen(context: context, pass: EzConfig.defaults[widget.prefsKey]);
        },
        message: 'Reset',
        icon: EzIcon(PlatformIcons(context).refresh),
      ),
    ];

    if (widget.allowClear)
      options.addAll([
        Container(height: buttonSpacer),
        EzButton.icon(
          action: () {
            _cleanup();

            EzConfig.preferences.setString(widget.prefsKey, noImageKey);
            popScreen(context: context, pass: noImageKey);
          },
          message: 'Clear',
          icon: EzIcon(PlatformIcons(context).clear),
        ),
      ]);

    return openDialog(
      context: context,
      dialog: EzDialog(
        title: Text(
          'Update $title',
          style: buildTextStyle(style: dialogTitleStyleKey),
          textAlign: TextAlign.center,
        ),
        contents: options,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return EzButton(
      action: () async {
        dynamic newPath = await _chooseImage();
        if (newPath is String)
          setState(() {
            updatedPath = newPath;
          });
      },
      longAction: () => openDialog(
        context: context,
        dialog: EzDialog(
          title: Text(
            'Credit to:',
            style: buildTextStyle(style: dialogTitleStyleKey),
            textAlign: TextAlign.center,
          ),
          contents: [
            ezText(widget.credits, style: buildTextStyle(style: dialogContentStyleKey))
          ],
        ),
      ),
      body: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Title on the left
          Text(title, style: buildTextStyle(style: imageSettingStyleKey)),

          // Preview on the right
          // 16:9 for backgrounds, 1:1 for the rest
          SizedBox(
            height: widget.fullscreen ? 160 : 75,
            width: widget.fullscreen ? 90 : 75,
            child: (updatedPath is String) // user made a change
                ? (updatedPath == noImageKey)
                    ? EzIcon(PlatformIcons(context).clear)
                    : buildImage(
                        path: updatedPath as String,
                        fit: BoxFit.fill,
                      )
                : (currPathKey == noImageKey) // using app's current state
                    ? EzIcon(PlatformIcons(context).clear)
                    : ezImage(
                        pathKey: currPathKey,
                        fit: BoxFit.fill,
                        backup: updatedPath,
                      ),
          ),
        ],
      ),
    );
  }
}
