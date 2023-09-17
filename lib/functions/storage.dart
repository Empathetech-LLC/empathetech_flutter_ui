/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

part of empathetech_flutter_ui;

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
      logAlert(context, 'Failed to retrieve image');
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
    final String errorMsg = 'Failed to update image:\n$e';
    logAlert(context, errorMsg);
    return null;
  }
}
