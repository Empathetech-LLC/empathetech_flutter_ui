/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
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

/// Save (and/or overwrite) the [Image] stored in [prefsPath] from [source]
Future<String?> saveImage({
  required BuildContext context,
  required String prefsPath,
  required ImageSource source,
}) async {
  // Load image picker and save the result
  try {
    final XFile? picked = await ImagePicker().pickImage(source: source);
    if (picked == null) return null;

    // Build the path
    final Directory directory = await getApplicationDocumentsDirectory();
    final String imageName = basename(picked.path);
    final File image = File('${directory.path}/$imageName');

    // Save the new image
    await File(picked.path).copy(image.path);
    await EzConfig.setString(prefsPath, image.path);
    return image.path;
  } on Exception catch (e) {
    if (context.mounted) {
      final String errorMsg = EFUILang.of(context)!.isSetFailed(e.toString());
      await logAlert(context, message: errorMsg);
    }
    return null;
  }
}

/// Given a [BoxFit].name, return the associated [BoxFit]
BoxFit? boxFitFromName(String name) {
  switch (name) {
    case 'contain':
      return BoxFit.contain;
    case 'cover':
      return BoxFit.cover;
    case 'fill':
      return BoxFit.fill;
    case 'fitWidth':
      return BoxFit.fitWidth;
    case 'fitHeight':
      return BoxFit.fitHeight;
    case 'none':
      return BoxFit.none;
    case 'scaleDown':
      return BoxFit.scaleDown;
    default:
      return null;
  }
}
