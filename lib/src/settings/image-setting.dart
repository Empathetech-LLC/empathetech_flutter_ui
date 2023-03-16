library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ImageSetting extends StatefulWidget {
  const ImageSetting({
    Key? key,
    required this.prefsKey,
    required this.isAssetImage,
    required this.title,
    required this.credits,
  }) : super(key: key);

  final String prefsKey;
  final bool isAssetImage;
  final String title;
  final String credits;

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
              Text('File'),
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
              Text('Camera'),
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
              Text('Reset'),
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
              Text('Clear'),
            ),
            Container(height: buttonSpacer),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ezButton(
      chooseImage,
      () => ezDialog(context, 'Credit to:', [paddedText(widget.credits)]),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(widget.title, style: getTextStyle(imageSettingStyleKey)),
          SizedBox(
            height: widget.prefsKey == backImageKey ? 160 : 75,
            width: widget.prefsKey == backImageKey ? 90 : 75,
            child: currPath == noImageKey
                ? Icon(PlatformIcons(context).clear)
                : buildImage(currPath, widget.isAssetImage, BoxFit.fill),
          ),
        ],
      ),
    );
  }
}
