library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

/// Wrap a flutter_colorpicker in an [ezDialog]
Future<dynamic> ezColorPicker(
  BuildContext context, {
  required Color startColor,
  required void Function(Color chosenColor) onColorChange,
  required void Function() apply,
  required void Function() cancel,
}) {
  return ezDialog(
    context,
    title: 'Pick a color!',
    content: [
      ColorPicker(
        pickerColor: startColor,
        onColorChanged: onColorChange,
      ),
      Container(height: AppConfig.prefs[dialogSpacingKey]),
      ezYesNo(
        context,
        onConfirm: apply,
        onDeny: cancel,
        axis: Axis.vertical,
        confirmMsg: 'Apply',
        denyMsg: 'Cancel',
      ),
    ],
    needsClose: false,
  );
}

/// Returns whether the passed [path] refers to one of the stored [AppConfig.assets]
bool isAsset(String? path) {
  return AppConfig.assets.contains(path);
}

/// [Image] wrapper for handling handling [AssetImage] vs [FileImage]
/// By default, simply providing [pathKey] will return the image found at [AppConfig.prefs] value's path
/// If the image path is not expected to be in [AppConfig.prefs], provide a [AppConfig.assets] path via [backup]
/// as the fallback for a [AppConfig.preferences] getString on [pathKey]
Image ezImage({
  required String pathKey,
  BoxFit? fit,
  String? backup,
}) {
  String path;

  if (backup is String) {
    path = AppConfig.preferences.getString(pathKey) ?? backup;
  } else {
    path = AppConfig.prefs[pathKey];
  }

  if (isAsset(path)) {
    return Image(
      image: AssetImage(path),
      fit: fit,
    );
  } else {
    try {
      return Image(
        image: FileImage(File(path)),
        fit: fit,
      );
    } on FileSystemException catch (_) {
      // File not found error - wipe the setting and return the/a backup image
      AppConfig.preferences.remove(pathKey);

      try {
        if (backup != null) {
          return Image(
            image: AssetImage(backup),
            fit: fit,
          );
        }
      } catch (_) {
        // Continue on to default case
        doNothing();
      }

      // Default case, stock owl
      return Image(
        image: NetworkImage(
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
        fit: fit,
      );
    }
  }
}

/// Simpler implementation of ezImage
/// Only call with [path] being the literal asset/file path
Image buildImage({
  required String path,
  BoxFit? fit,
}) {
  if (isAsset(path)) {
    return Image(
      image: AssetImage(path),
      fit: fit,
    );
  } else {
    try {
      return Image(
        image: FileImage(File(path)),
        fit: fit,
      );
    } on FileSystemException catch (_) {
      // Something went wrong, return stock owl
      return Image(
        image: NetworkImage(
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
        fit: fit,
      );
    }
  }
}

/// [DecorationImage] wrapper for setting the background image in [EZScaffold]s and the like
DecorationImage? buildDecoration(String? path) {
  if (path == null || path == noImageKey) {
    return null;
  } else if (isAsset(path)) {
    return DecorationImage(
      image: AssetImage(path),
      fit: BoxFit.fill,
    );
  } else {
    return DecorationImage(
      image: FileImage(File(path)),
      fit: BoxFit.fill,
    );
  }
}

/// Overwrite the [Image] stored in [prefsPath] from [source]
Future<String?> changeImage(
  BuildContext context, {
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
    AppConfig.preferences.setString(prefsPath, image.path);
    return image.path;
  } on Exception catch (e) {
    String errorMsg = 'Failed to update image:\n$e';
    logAlert(context, errorMsg);
    return null;
  }
}
