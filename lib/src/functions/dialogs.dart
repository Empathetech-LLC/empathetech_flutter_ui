/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Log the passed message and display an [EzAlertDialog] for the user
/// Should always return null via [popScreen]
Future<dynamic> logAlert(
  BuildContext context,
  String message,
) {
  log(message);
  return showPlatformDialog(
    context: context,
    builder: (context) => EzAlertDialog(
      title: const EzSelectableText('Attention:'),
      contents: [
        EzSelectableText(message),
      ],
    ),
  );
}

/// Wrap a [ColorPicker] in an [EzAlertDialog]
Future<dynamic> ezColorPicker({
  required BuildContext context,
  required Color startColor,
  required void Function(Color chosenColor) onColorChange,
  required void Function() apply,
  required void Function() cancel,
}) {
  final double space = EzConfig.instance.prefs[buttonSpacingKey];

  return showPlatformDialog(
    context: context,
    builder: (context) => EzAlertDialog(
      title: const EzSelectableText('Pick a color!'),
      contents: [
        // Color picker
        ColorPicker(
          pickerColor: startColor,
          onColorChanged: onColorChange,
          // ignore: deprecated_member_use
          labelTextStyle: Theme.of(context).dialogTheme.contentTextStyle,

          // Above is necessary for Cupertino
          // It is deprecated, but it points to an also deprecated solution
          // ...ain't broke...
        ),
        EzSpacer(space),

        // Apply/cancel
        EzYesNo(
          onConfirm: apply,
          confirmMsg: 'Apply',
          onDeny: cancel,
          denyMsg: 'Cancel',
        ),
      ],
      needsClose: false,
    ),
  );
}
