/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Log the passed message and display an [EzAlertDialog] to notify the user
Future<dynamic> logAlert({
  required BuildContext context,
  String? title,
  required String message,
}) {
  debugPrint(message);
  return showPlatformDialog(
    context: context,
    builder: (BuildContext context) => EzAlertDialog(
      title: Text(
        title ?? EFUILang.of(context)!.gAttention,
        textAlign: TextAlign.center,
      ),
      contents: <Widget>[
        Text(
          message,
          textAlign: TextAlign.center,
        )
      ],
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
    builder: (BuildContext context) => EzAlertDialog(
      title: Text(
        title ?? EFUILang.of(context)!.csPickerTitle,
        textAlign: TextAlign.center,
      ),
      contents: <Widget>[
        ColorPicker(
          pickerColor: startColor,
          onColorChanged: onColorChange,
          portraitOnly: true,

          // ignore: deprecated_member_use
          labelTextStyle: Theme.of(context).dialogTheme.contentTextStyle,
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
