library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

////// Colors //////

// Show custom color picker dialog
void colorPicker(
    BuildContext context,
    Color startColor,
    void Function(Color chosenColor) onColorChange,
    void Function() apply,
    void Function() cancel) {
  double dialogSpacer = AppConfig.prefs[dialogSpacingKey];

  ezDialog(
    context,
    'Pick a color!',
    [
      ezScrollView(
        [
          // Main event
          ColorPicker(
            pickerColor: startColor,
            onColorChanged: onColorChange,
          ),
          Container(height: dialogSpacer),

          // Apply
          ezTextIconButton(
            apply,
            () {},
            'Done',
            Icon(Icons.check),
            Icon(CupertinoIcons.check_mark),
          ),
          Container(height: dialogSpacer),

          // Cancel
          ezTextIconButton(
            cancel,
            () {},
            'Cancel',
            Icon(Icons.cancel),
            Icon(CupertinoIcons.xmark),
          ),
          Container(height: dialogSpacer),
        ],
      ),
    ],
  );
}

////// Images //////

// Returns an image from a path, handling the image type
Image buildImage(String path, bool isAsset, [BoxFit? fit]) {
  if (isAsset) {
    return Image(
      image: AssetImage(path),
      fit: fit,
    );
  } else {
    return Image(
      image: FileImage(File(path)),
      fit: fit,
    );
  }
}

// Ditto but returns an image provider
ImageProvider provideImage(String path, bool isAsset) {
  if (isAsset) {
    return AssetImage(path);
  } else {
    return FileImage(File(path));
  }
}

// Saves the passed image to the passed path
Future<bool> changeImage(
    BuildContext context, String prefsPath, ImageSource source) async {
  // Load image picker and save the result
  try {
    XFile? picked = await ImagePicker().pickImage(source: source);
    if (picked == null) {
      popNLog(context, 'Failed to retrieve image');
      return false;
    }

    // Build path
    Directory directory = await getApplicationDocumentsDirectory();
    String imageName = basename(picked.path);
    final image = File('${directory.path}/$imageName');

    // Save new image
    File(picked.path).copy(image.path);
    AppConfig.preferences.setString(prefsPath, image.path);
    return true;
  } on Exception catch (e) {
    String errorMsg = 'Failed to update image:\n$e';
    popNLog(context, errorMsg);
    return false;
  }
}
