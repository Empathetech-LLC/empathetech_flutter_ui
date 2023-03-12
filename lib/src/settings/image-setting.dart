library empathetech_flutter_ui;

import '../text.dart';
import '../app-config.dart';
import '../storage.dart';
import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ImageSetting extends StatefulWidget {
  const ImageSetting({
    Key? key,
    required this.prefsKey,
    required this.title,
    required this.isAssetImage,
    required this.rollCredits,
  }) : super(key: key);

  final String prefsKey;
  final String title;
  final bool Function(String path) isAssetImage;
  final void Function() rollCredits;

  @override
  _ImageSettingState createState() => _ImageSettingState();
}

class _ImageSettingState extends State<ImageSetting> {
  //// Initialize state

  // Gather theme data
  late double buttonSpacer = AppConfig.prefs[buttonSpacingKey];
  late double dialogSpacer = AppConfig.prefs[dialogSpacingKey];

  late String currPath = widget.prefsKey;

  //// Define interaction methods

  // Top-level button onPressed: display the image source/update options
  void chooseImage() {
    ezDialog(
      context,

      // Title
      'Update background',

      // Body
      [
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // From file
            ezIconButton(
              () async {
                await changeImage(
                  context,
                  widget.prefsKey,
                  ImageSource.gallery,
                );

                Navigator.of(context).pop();
              },
              () {},
              Icon(PlatformIcons(context).folderOpen),
              Icon(PlatformIcons(context).folderOpen),
              PlatformText('File'),
            ),
            Container(height: buttonSpacer),

            // From camera
            ezIconButton(
              () async {
                await changeImage(
                  context,
                  widget.prefsKey,
                  ImageSource.camera,
                );

                Navigator.of(context).pop();
              },
              () {},
              Icon(PlatformIcons(context).photoCamera),
              Icon(PlatformIcons(context).photoCamera),
              PlatformText('Camera'),
            ),
            Container(height: buttonSpacer),

            // Reset
            ezIconButton(
              () {
                AppConfig.preferences.remove(widget.prefsKey);
                setState(() {
                  currPath = AppConfig.defaults[widget.prefsKey];
                });
                Navigator.of(context).pop();
              },
              () {},
              Icon(PlatformIcons(context).refresh),
              Icon(PlatformIcons(context).refresh),
              PlatformText('Reset'),
            ),
            Container(height: buttonSpacer),

            // Clear
            ezIconButton(
              () {
                AppConfig.preferences.setString(widget.prefsKey, noImageKey);
                setState(() {
                  currPath = noImageKey;
                });
                Navigator.of(context).pop();
              },
              () {},
              Icon(PlatformIcons(context).clear),
              Icon(PlatformIcons(context).clear),
              PlatformText('Clear'),
            ),
            Container(height: buttonSpacer),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String path = AppConfig.prefs[widget.prefsKey];
    bool isAsset = widget.isAssetImage(path);

    return ezButton(
      chooseImage,
      widget.rollCredits,
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          PlatformText(widget.title, style: getTextStyle(imageSettingStyleKey)),
          SizedBox(
            height: widget.prefsKey == backImageKey ? 160 : 75,
            width: widget.prefsKey == backImageKey ? 90 : 75,
            child: currPath == noImageKey
                ? Icon(PlatformIcons(context).clear)
                : buildImage(currPath, isAsset, BoxFit.fill),
          ),
        ],
      ),
    );
  }
}
