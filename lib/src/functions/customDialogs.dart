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
      title: EzText(alert ?? EFUILang.of(context)!.dAttention),
      contents: [EzText(message)],
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
      title: EzText(
        title ?? EFUILang.of(context)!.csPickerTitle,
      ),
      contents: [
        ColorPicker(
          pickerColor: startColor,
          onColorChanged: onColorChange,

          // ignore: deprecated_member_use
          labelTextStyle: Theme.of(context).dialogTheme.contentTextStyle,
          // Necessary for Cupertino

          portraitOnly: true,
        ),
      ],
      materialActions: ezMaterialActions(
        context: context,
        onConfirm: onConfirm,
        onDeny: onDeny,
        confirmMsg: confirmMsg ?? EFUILang.of(context)!.gApply,
        denyMsg: denyMsg ?? EFUILang.of(context)!.gCancel,
      ),
      cupertinoActions: ezCupertinoActions(
        context: context,
        onConfirm: onConfirm,
        onDeny: onDeny,
        confirmMsg: confirmMsg ?? EFUILang.of(context)!.gApply,
        denyMsg: denyMsg ?? EFUILang.of(context)!.gCancel,
        confirmIsDestructive: true,
      ),
      needsClose: false,
    ),
  );
}
