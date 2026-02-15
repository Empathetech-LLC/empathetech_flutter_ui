/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// Returns and [AssetImage], [NetworkImage], or [FileImage] based on the [path]
ImageProvider ezImageProvider(String path) {
  if (EzConfig.isPathAsset(path)) {
    return efuiAssetPaths.contains(path)
        ? efuiImageLookup[path]!
        : AssetImage(path);
  } else if (ezUrlCheck(path)) {
    return NetworkImage(path);
  } else {
    return FileImage(File(path));
  }
}

/// Wraps an [ImagePicker] in a try/catch
/// Provide [prefsPath] to auto save successful results to [EzConfig]
Future<String?> ezImagePicker({
  required BuildContext context,
  required ImageSource source,
  String? prefsPath,
}) async {
  try {
    final XFile? picked = await ImagePicker().pickImage(source: source);
    if (picked == null) return null;

    if (prefsPath != null) await EzConfig.setString(prefsPath, picked.path);
    return picked.path;
  } on Exception catch (e) {
    if (context.mounted) {
      final String errorMsg =
          '${EzConfig.l10n.dsImgSetFailed}\n${e.toString()}';
      await ezLogAlert(context, message: errorMsg);
    }
    return null;
  }
}
