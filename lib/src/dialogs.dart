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
      title: EzText.simple(
        'Pick a color!',
        style: ezTextStyle(context, MaterialStyles.titleSmall),
      ),
      contents: [
        ColorPicker(
          pickerColor: startColor,
          onColorChanged: onColorChange,
          // ignore: deprecated_member_use
          labelTextStyle: ezTextStyle(context, MaterialStyles.bodyMedium),
          // above is required for iOS
        ),
        Container(height: EzConfig.prefs[dialogSpacingKey]),
        ezYesNo(
          context: context,
          onConfirm: apply,
          onDeny: cancel,
          axis: Axis.vertical,
          confirmMsg: 'Apply',
          denyMsg: 'Cancel',
        ),
      ],
      needsClose: false,
    ),
  );
}
