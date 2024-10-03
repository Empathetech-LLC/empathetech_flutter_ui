/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Log the passed message and display an [EzAlertDialog] to notify the user
Future<void> logAlert(
  BuildContext context, {
  String? title,
  required String message,
}) async {
  debugPrint(message);
  await showPlatformDialog(
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

/// Log the passed message and display a [SnackBar] to notify the user
Future<void> logSnack(
  ScaffoldMessengerState state,
  String message,
) async {
  debugPrint(message);
  state.showSnackBar(SnackBar(
    content: Text(message, textAlign: TextAlign.center),
    duration: readingTime(message),
  ));
}

/// Wrap a [ColorPicker] in an [EzAlertDialog]
Future<dynamic> ezColorPicker(
  BuildContext context, {
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
    builder: (BuildContext dialogContext) {
      final double padding = EzConfig.get(paddingKey);
      final double spacing = EzConfig.get(spacingKey);

      void confirm() {
        onConfirm();
        Navigator.of(dialogContext).pop();
      }

      void deny() {
        onDeny();
        Navigator.of(dialogContext).pop();
      }

      return EzAlertDialog(
        title: Text(
          title ?? EFUILang.of(context)!.csPickerTitle,
          textAlign: TextAlign.center,
        ),
        content: ColorPicker(
          color: startColor,
          mainAxisSize: MainAxisSize.min,
          padding: EdgeInsets.zero,
          spacing: spacing / 2,
          runSpacing: spacing / 2,
          columnSpacing: spacing,
          pickersEnabled: const <ColorPickerType, bool>{
            ColorPickerType.both: false,
            ColorPickerType.primary: false,
            ColorPickerType.accent: false,
            ColorPickerType.bw: false,
            ColorPickerType.custom: false,
            ColorPickerType.customSecondary: false,
            ColorPickerType.wheel: true
          },
          onColorChanged: onColorChange,
          showRecentColors: true,
          enableOpacity: true,
          opacityThumbRadius: padding,
          opacityTrackHeight: padding * 2,
          showColorCode: true,
          copyPasteBehavior: const ColorPickerCopyPasteBehavior(
            editFieldCopyButton: false,
          ),
        ),
        materialActions: ezMaterialActions(
          context: context,
          confirmMsg: confirmMsg ?? EFUILang.of(context)!.gApply,
          onConfirm: confirm,
          confirmIsDestructive: true,
          denyMsg: denyMsg ?? EFUILang.of(context)!.gCancel,
          onDeny: deny,
        ),
        cupertinoActions: ezCupertinoActions(
          context: context,
          confirmMsg: confirmMsg ?? EFUILang.of(context)!.gApply,
          onConfirm: confirm,
          confirmIsDestructive: true,
          denyMsg: denyMsg ?? EFUILang.of(context)!.gCancel,
          onDeny: deny,
        ),
        needsClose: false,
      );
    },
  );
}
