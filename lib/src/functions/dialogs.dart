/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Log the passed message and display an [EzAlertDialog] to notify the user
Future<dynamic> logAlert({
  required BuildContext context,
  String? alert,
  required String message,
}) {
  log(message);
  return showPlatformDialog(
    context: context,
    builder: (context) => EzAlertDialog(
      title: EzSelectableText(alert ?? EFUIPhrases.of(context)!.attention),
      content: EzSelectableText(message),
    ),
  );
}

/// Wrap a [ColorPicker] in an [EzAlertDialog]
Future<dynamic> ezColorPicker({
  required BuildContext context,
  String? title,
  required Color startColor,
  required void Function(Color chosenColor) onColorChange,
  String? confirmMsg,
  required void Function() onConfirm,
  String? denyMsg,
  required void Function() onDeny,
}) {
  return showPlatformDialog(
    context: context,
    builder: (context) => EzAlertDialog(
      title: EzSelectableText(
        title ?? EFUIPhrases.of(context)!.pickAColor,
      ),
      content: ColorPicker(
        pickerColor: startColor,
        onColorChanged: onColorChange,

        // ignore: deprecated_member_use
        labelTextStyle: Theme.of(context).dialogTheme.contentTextStyle,
        // Necessary for Cupertino

        portraitOnly: true,
      ),
      materialActions: ezMaterialActions(
        context: context,
        onConfirm: onConfirm,
        onDeny: onDeny,
        confirmMsg: confirmMsg ?? EFUIPhrases.of(context)!.apply,
        denyMsg: denyMsg ?? EFUIPhrases.of(context)!.cancel,
      ),
      cupertinoActions: ezCupertinoActions(
        context: context,
        onConfirm: onConfirm,
        onDeny: onDeny,
        confirmMsg: confirmMsg ?? EFUIPhrases.of(context)!.apply,
        denyMsg: denyMsg ?? EFUIPhrases.of(context)!.cancel,
        confirmIsDestructive: true,
      ),
      needsClose: false,
    ),
  );
}
