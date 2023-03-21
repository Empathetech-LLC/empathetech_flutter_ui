library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

/// Show color picker dialog, built from [flutter_colorpicker]
void ezColorPicker({
  required BuildContext context,
  required Color startColor,
  required void Function(Color chosenColor) onColorChange,
  required void Function() apply,
  required void Function() cancel,
}) {
  ezDialog(
    context: context,
    title: 'Pick a color!',
    content: ezScrollView(
      children: [
        // Main event
        ColorPicker(
          pickerColor: startColor,
          onColorChanged: onColorChange,
        ),
        Container(height: AppConfig.prefs[dialogSpacingKey]),

        // Apply
        ezYesNo(
          context: context,
          onConfirm: apply,
          onDeny: cancel,
          axis: Axis.vertical,
          confirmMsg: 'Apply',
          denyMsg: 'Cancel',
        ),
      ],
    ),
  );
}

/// [Image] wrapper for handling handling [AssetImage] vs [FileImage]
Image buildImage({
  required String path,
  required bool isAsset,
  BoxFit? fit,
}) {
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

/// [ImageProvider] wrapper for handling handling [AssetImage] vs [FileImage]
ImageProvider provideImage({
  required String path,
  required bool isAsset,
}) {
  if (isAsset) {
    return AssetImage(path);
  } else {
    return FileImage(File(path));
  }
}

/// Overwrite the [Image] stored in [prefsPath] from [source]
Future<bool> changeImage({
  required BuildContext context,
  required String prefsPath,
  required ImageSource source,
}) async {
  // Load image picker and save the result
  try {
    XFile? picked = await ImagePicker().pickImage(source: source);
    if (picked == null) {
      popNLog(context, 'Failed to retrieve image');
      return false;
    }

    // Build the path
    Directory directory = await getApplicationDocumentsDirectory();
    String imageName = basename(picked.path);
    final image = File('${directory.path}/$imageName');

    // Save the new image
    File(picked.path).copy(image.path);
    AppConfig.preferences.setString(prefsPath, image.path);
    return true;
  } on Exception catch (e) {
    String errorMsg = 'Failed to update image:\n$e';
    popNLog(context, errorMsg);
    return false;
  }
}
