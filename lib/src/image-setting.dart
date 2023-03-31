library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Creates a tool for updating the image at [prefsKey]'s path
/// Take in the [isAsset] bool so an image preview can be built
class ImageSetting extends StatefulWidget {
  const ImageSetting({
    Key? key,
    required this.prefsKey,
    required this.fullscreen,
    required this.title,
    required this.credits,
  }) : super(key: key);

  final String prefsKey;
  final bool fullscreen;
  final String title;
  final String credits;

  @override
  _ImageSettingState createState() => _ImageSettingState();
}

class _ImageSettingState extends State<ImageSetting> {
  // Initialize state

  late String currPath = AppConfig.prefs[widget.prefsKey];
  late TextStyle buttonTextStyle = getTextStyle(buttonStyleKey);
  late double buttonSpacer = AppConfig.prefs[buttonSpacingKey];
  late double dialogSpacer = AppConfig.prefs[dialogSpacingKey];

  /// Opens an [ezDialog] for choosing the [ImageSource] for updating [prefsKey]
  /// Selection is sent to [changeImage]
  void chooseImage() {
    ezDialog(
      context,
      title: 'Update background',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // From file
          EZButton.icon(
            action: () async {
              await changeImage(
                context,
                prefsPath: widget.prefsKey,
                source: ImageSource.gallery,
              );

              Navigator.of(context).pop();
            },
            icon: ezIcon(PlatformIcons(context).folder),
            message: 'File',
          ),
          Container(height: buttonSpacer),

          // From camera
          EZButton.icon(
            action: () async {
              await changeImage(
                context,
                prefsPath: widget.prefsKey,
                source: ImageSource.camera,
              );

              Navigator.of(context).pop();
            },
            icon: ezIcon(PlatformIcons(context).photoCamera),
            message: 'Camera',
          ),
          Container(height: buttonSpacer),

          // Reset
          EZButton.icon(
            action: () {
              AppConfig.preferences.remove(widget.prefsKey);
              setState(() {
                currPath = AppConfig.defaults[widget.prefsKey];
              });
              Navigator.of(context).pop();
            },
            icon: ezIcon(PlatformIcons(context).refresh),
            message: 'Reset',
          ),
          Container(height: buttonSpacer),

          // Clear
          EZButton.icon(
            action: () {
              AppConfig.preferences.setString(widget.prefsKey, noImageKey);
              setState(() {
                currPath = noImageKey;
              });
              Navigator.of(context).pop();
            },
            icon: ezIcon(PlatformIcons(context).clear),
            message: 'Clear',
          ),
          Container(height: buttonSpacer),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return EZButton(
      action: chooseImage,
      longAction: () => ezDialog(
        context,
        title: 'Credit to:',
        content: ezText(widget.credits, style: getTextStyle(dialogContentStyleKey)),
      ),
      body: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Title on the left
          Text(widget.title, style: getTextStyle(imageSettingStyleKey)),

          // Preview on the right
          // 16:9 for backgrounds, 1:1 for the rest
          SizedBox(
            height: widget.fullscreen ? 160 : 75,
            width: widget.fullscreen ? 90 : 75,
            child: currPath == noImageKey
                ? ezIcon(PlatformIcons(context).clear)
                : buildImage(
                    path: currPath,
                    fit: BoxFit.fill,
                  ),
          ),
        ],
      ),
    );
  }
}
