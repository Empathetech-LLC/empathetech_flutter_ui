// ignore_for_file: avoid_web_libraries_in_flutter

/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// [saveImage] for web
Future<String?> saveImageWeb({
  required BuildContext context,
  required String prefsPath,
  required ImageSource source,
}) async {
  // Load image picker and save the result
  try {
    final XFile? picked = await ImagePicker().pickImage(source: source);
    if (picked == null) return null;

    final String imagePath = picked.path;
    html.window.localStorage[prefsPath] = imagePath;
    return imagePath;
  } on Exception catch (e) {
    if (context.mounted) {
      final String errorMsg = EFUILang.of(context)!.isSetFailed(e.toString());
      await logAlert(context, message: errorMsg);
    }
    return null;
  }
}
