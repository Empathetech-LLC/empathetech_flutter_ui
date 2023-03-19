library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
  // Initialize state

  // Gather theme data
  late double buttonSpacer = AppConfig.prefs[buttonSpacingKey];
  late double dialogSpacer = AppConfig.prefs[dialogSpacingKey];

  late String currPath = widget.prefsKey;

  // Define interactions

  // Top-level button onPressed: display the image source/update options
  void chooseImage() {
    ezDialog(
      context,

      // Title
      'Update background',

      // Body

      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // From file
          ezTextIconButton(
            () async {
              await changeImage(
                context,
                widget.prefsKey,
                ImageSource.gallery,
              );

              Navigator.of(context).pop();
            },
            () {},
            'File',
            Icon(PlatformIcons(context).folder),
          ),
          Container(height: buttonSpacer),

          // From camera
          ezTextIconButton(
            () async {
              await changeImage(
                context,
                widget.prefsKey,
                ImageSource.camera,
              );

              Navigator.of(context).pop();
            },
            () {},
            'Camera',
            Icon(PlatformIcons(context).photoCamera),
          ),
          Container(height: buttonSpacer),

          // Reset
          ezTextIconButton(
            () {
              AppConfig.preferences.remove(widget.prefsKey);
              setState(() {
                currPath = AppConfig.defaults[widget.prefsKey];
              });
              Navigator.of(context).pop();
            },
            () {},
            'Reset',
            Icon(PlatformIcons(context).refresh),
          ),
          Container(height: buttonSpacer),

          // Clear
          ezTextIconButton(
            () {
              AppConfig.preferences.setString(widget.prefsKey, noImageKey);
              setState(() {
                currPath = noImageKey;
              });
              Navigator.of(context).pop();
            },
            () {},
            'Clear',
            Icon(PlatformIcons(context).clear),
          ),
          Container(height: buttonSpacer),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ezButton(
      chooseImage,
      () => ezDialog(context, 'Credit to:', paddedText(widget.credits)),
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
