/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Custom implementation of a removeAll() style method for [SharedPreferences]
void removeKeys(Set<String> keys) {
  for (String key
      in keys.intersection(EzConfig.instance.preferences.getKeys())) {
    EzConfig.remove(key);
  }
}

/// Can this [path] build an [AssetImage]?
bool isPathAsset(String? path) {
  return EzConfig.instance.assets.contains(path);
}

/// Does the value at the end of this [key]'s [EzConfig.instance] tunnel lead to an [AssetImage] path?
bool isKeyAsset(String? key) {
  return EzConfig.instance.assets.contains(EzConfig.instance.prefs[key]);
}

/// Provide the [path] to an [Image] and we'll handle the rest
ImageProvider provideImage(String path) {
  if (isPathAsset(path)) {
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
      logAlert(
        context: context,
        message: EFUILang.of(context)!.isGetFailed,
      );
      return null;
    }

    // Build the path
    final Directory directory = await getApplicationDocumentsDirectory();
    final String imageName = basename(picked.path);
    final image = File('${directory.path}/$imageName');

    // Save the new image
    File(picked.path).copy(image.path);
    EzConfig.instance.preferences.setString(prefsPath, image.path);
    return image.path;
  } on Exception catch (e) {
    final String errorMsg = EFUILang.of(context)!.isSetFailed(e.toString());
    logAlert(context: context, message: errorMsg);
    return null;
  }
}
