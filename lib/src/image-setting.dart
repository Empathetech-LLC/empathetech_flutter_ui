library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Creates a tool for updating the image at [prefsKey]'s path
class ImageSetting extends StatefulWidget {
  const ImageSetting({
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

class _ImageSettingState extends State<ImageSetting> {
  late String title = widget.title;
  late String currPathKey = widget.prefsKey;
  String? updatedPath; // Only used when the user makes a change

  late TextStyle buttonTextStyle = getTextStyle(buttonStyleKey);

  late double buttonSpacer = AppConfig.prefs[buttonSpacingKey];
  late double dialogSpacer = AppConfig.prefs[dialogSpacingKey];

  /// Cleanup any custom files
  void cleanup() async {
    if (!isAsset(widget.prefsKey)) {
      try {
        File toDelete = File(widget.prefsKey);
        await toDelete.delete();
      } catch (e) {
        doNothing();
      }
    }
  }

  /// Opens an [ezDialog] for choosing the [ImageSource] for updating [prefsKey]
  /// Selection is sent to [changeImage]
  Future<dynamic> chooseImage() async {
    List<Widget> options = [
      // From file
      EZButton.icon(
        action: () async {
          String? changed = await changeImage(
            context,
            prefsPath: widget.prefsKey,
            source: ImageSource.gallery,
          );

          popScreen(context, pass: changed);
        },
        message: 'File',
        icon: ezIcon(PlatformIcons(context).folder),
      ),
      Container(height: buttonSpacer),

      // From camera
      EZButton.icon(
        action: () async {
          String? changed = await changeImage(
            context,
            prefsPath: widget.prefsKey,
            source: ImageSource.camera,
          );

          popScreen(context, pass: changed);
        },
        message: 'Camera',
        icon: ezIcon(PlatformIcons(context).photoCamera),
      ),
      Container(height: buttonSpacer),

      // Reset
      EZButton.icon(
        action: () async {
          cleanup();

          AppConfig.preferences.remove(widget.prefsKey);
          popScreen(context, pass: AppConfig.defaults[widget.prefsKey]);
        },
        message: 'Reset',
        icon: ezIcon(PlatformIcons(context).refresh),
      ),
    ];

    if (widget.allowClear)
      options.addAll([
        Container(height: buttonSpacer),
        EZButton.icon(
          action: () async {
            cleanup();

            AppConfig.preferences.setString(widget.prefsKey, noImageKey);
            popScreen(context);
          },
          message: 'Clear',
          icon: ezIcon(PlatformIcons(context).clear),
        ),
      ]);

    return ezDialog(context, title: 'Update $title', content: options);
  }

  @override
  Widget build(BuildContext context) {
    return EZButton(
      action: () async {
        dynamic newPath = await chooseImage();
        if (newPath is String)
          setState(() {
            updatedPath = newPath;
          });
      },
      longAction: () => ezDialog(
        context,
        title: 'Credit to:',
        content: [ezText(widget.credits, style: getTextStyle(dialogContentStyleKey))],
      ),
      body: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Title on the left
          Text(title, style: getTextStyle(imageSettingStyleKey)),

          // Preview on the right
          // 16:9 for backgrounds, 1:1 for the rest
          SizedBox(
            height: widget.fullscreen ? 160 : 75,
            width: widget.fullscreen ? 90 : 75,
            child: currPathKey == noImageKey
                ? ezIcon(PlatformIcons(context).clear)
                : (updatedPath is String)
                    ? buildImage(
                        path: updatedPath as String,
                        fit: BoxFit.fill,
                      )
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
