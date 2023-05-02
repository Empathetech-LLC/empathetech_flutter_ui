library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

/// Overwrite the [Image] stored in [prefsPath] from [source]
Future<String?> changeImage({
  required BuildContext context,
  required String prefsPath,
  required ImageSource source,
}) async {
  // Load image picker and save the result
  try {
    XFile? picked = await ImagePicker().pickImage(source: source);
    if (picked == null) {
      logAlert(context, 'Failed to retrieve image');
      return null;
    }

    // Build the path
    Directory directory = await getApplicationDocumentsDirectory();
    String imageName = basename(picked.path);
    final image = File('${directory.path}/$imageName');

    // Save the new image
    File(picked.path).copy(image.path);
    EzConfig.preferences.setString(prefsPath, image.path);
    return image.path;
  } on Exception catch (e) {
    String errorMsg = 'Failed to update image:\n$e';
    logAlert(context, errorMsg);
    return null;
  }
}
