/* empathetech_flutter_ui
 * Copyright (c) 2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

/// Provide the [path] to an [Image] and we'll handle the rest
ImageProvider provideImage(String path) {
  if (EzConfig.isPathAsset(path)) {
    return AssetImage(path);
  } else if (isUrl(path)) {
    return NetworkImage(path);
  } else {
    return FileImage(File(path));
  }
}

/// Overwrite the [Image] stored in [prefsPath] from [source]
Future<String?> changeImage({
  required BuildContext context,
  required String prefsPath,
  required ImageSource source,
}) async {
  // Load image picker and save the result
  try {
    final XFile? picked = await ImagePicker().pickImage(source: source);
    if (picked == null) {
      return null;
    }

    // Build the path
    final Directory directory = await getApplicationDocumentsDirectory();
    final String imageName = basename(picked.path);
    final File image = File('${directory.path}/$imageName');

    // Save the new image
    File(picked.path).copy(image.path);
    EzConfig.setString(prefsPath, image.path);
    return image.path;
  } on Exception catch (_) {
    return null;
  }
}
