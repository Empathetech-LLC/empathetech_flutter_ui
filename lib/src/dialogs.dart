library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Little more concise/readable
Future<dynamic> openDialog({
  required BuildContext context,
  required EzDialog dialog,
}) {
  return showPlatformDialog(
    context: context,
    builder: (context) => dialog,
  );
}

/// Wrap a [ColorPicker] in an [EzDialog]
Future<dynamic> ezColorPicker({
  required BuildContext context,
  required Color startColor,
  required void Function(Color chosenColor) onColorChange,
  required void Function() apply,
  required void Function() cancel,
}) {
  return openDialog(
    context: context,
    dialog: EzDialog(
      title: ezText('Pick a color!'),
      contents: [
        // Color picker
        ColorPicker(
          pickerColor: startColor,
          onColorChanged: onColorChange,
        ),
        Container(height: EzConfig.prefs[dialogSpacingKey]),

        // Apply
        EzButton(
          onPressed: apply,
          child: ezText('Apply'),
        ),
        Container(height: EzConfig.prefs[dialogSpacingKey]),

        // Cancel
        EzButton(
          onPressed: cancel,
          child: ezText('Cancel'),
        ),
      ],
      needsClose: false,
    ),
  );
}
