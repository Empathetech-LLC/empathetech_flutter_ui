/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Log the passed message and display an [EzAlertDialog] to notify the user
Future<dynamic> logAlert({
  required BuildContext context,
  String alert = 'Attention',
  required String message,
}) {
  log(message);
  return showPlatformDialog(
    context: context,
    builder: (context) => Semantics(
      button: false,
      readOnly: true,
      child: ExcludeSemantics(
        child: EzAlertDialog(
          title: EzSelectableText(alert),
          contents: [EzSelectableText(message)],
        ),
      ),
    ),
  );
}

/// Wrap a [ColorPicker] in an [EzAlertDialog]
Future<dynamic> ezColorPicker({
  required BuildContext context,
  String title = 'Pick a color!',
  required Color startColor,
  required void Function(Color chosenColor) onColorChange,
  String confirmMsg = 'Apply',
  required void Function() onConfirm,
  String denyMsg = 'Cancel',
  required void Function() onDeny,
}) {
  final TextStyle? contentStyle = Theme.of(context).dialogTheme.contentTextStyle;

  return showPlatformDialog(
    context: context,
    builder: (context) => EzAlertDialog(
      title: EzSelectableText(title),
      contents: [
        // Color picker
        ColorPicker(
          pickerColor: startColor,
          onColorChanged: onColorChange,

          // ignore: deprecated_member_use
          labelTextStyle: contentStyle,
          // Necessary for Cupertino

          portraitOnly: true,
        ),
      ],
      materialActions: ezMaterialActions(
        onConfirm: onConfirm,
        onDeny: onDeny,
        confirmMsg: confirmMsg,
        denyMsg: denyMsg,
      ),
      cupertinoActions: ezCupertinoActions(
        onConfirm: onConfirm,
        onDeny: onDeny,
        confirmMsg: confirmMsg,
        denyMsg: denyMsg,
        confirmIsDestructive: true,
      ),
      needsClose: false,
    ),
  );
}
