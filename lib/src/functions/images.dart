/* empathetech_flutter_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

/// Pick an [Image] and return the path [String]
Future<String?> pickImage({
  required BuildContext context,
  required String prefsPath,
  required ImageSource source,
}) async {
  try {
    final XFile? picked = await ImagePicker().pickImage(source: source);
    if (picked == null) return null;

    await EzConfig.setString(prefsPath, picked.path);
    return picked.path;
  } on Exception catch (e) {
    if (context.mounted) {
      final String errorMsg = EFUILang.of(context)!.isSetFailed(e.toString());
      await logAlert(context, message: errorMsg);
    }
    return null;
  }
}

/// Given a [BoxFit].name, return the associated [BoxFit]
BoxFit? boxFitFromName(String? name) {
  switch (name) {
    case contain:
      return BoxFit.contain;
    case cover:
      return BoxFit.cover;
    case fill:
      return BoxFit.fill;
    case fitWidth:
      return BoxFit.fitWidth;
    case fitHeight:
      return BoxFit.fitHeight;
    case none:
      return BoxFit.none;
    case scaleDown:
      return BoxFit.scaleDown;
    default:
      return null;
  }
}
