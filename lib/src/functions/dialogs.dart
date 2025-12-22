/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// [ezLog] the passed message and display an [EzAlertDialog] to notify the user
Future<dynamic> ezLogAlert(
  BuildContext context, {
  String? title,
  required String message,
  (List<Widget> materialActions, List<Widget> cupertinoActions)? customActions,
}) async {
  ezLog(message);

  return showPlatformDialog(
    context: context,
    builder: (_) => EzAlertDialog(
      title: Text(
        title ?? EzConfig.l10n.gAttention,
        textAlign: TextAlign.center,
      ),
      contents: <Widget>[Text(message, textAlign: TextAlign.center)],
      materialActions: customActions?.$1,
      cupertinoActions: customActions?.$2,
      needsClose: customActions == null,
    ),
  );
}

/// Wraps a [ColorPicker] in an [EzAlertDialog]
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
    builder: (BuildContext dContext) {
      final double padding = EzConfig.padding;
      final double spacing = EzConfig.spacing;

      void confirm() {
        onConfirm();
        Navigator.of(dContext).pop();
      }

      void deny() {
        onDeny();
        Navigator.of(dContext).pop();
      }

      late final List<Widget> materialActions;
      late final List<Widget> cupertinoActions;

      (materialActions, cupertinoActions) = ezActionPairs(
        context: context,
        confirmMsg: confirmMsg ?? EzConfig.l10n.gApply,
        onConfirm: confirm,
        confirmIsDestructive: true,
        denyMsg: denyMsg ?? EzConfig.l10n.gCancel,
        onDeny: deny,
      );

      return EzAlertDialog(
        title: Text(
          title ?? EzConfig.l10n.csPickerTitle,
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
          opacityThumbRadius: min(padding, 25.0),
          opacityTrackHeight: min(padding * 2, 50.0),
          showColorCode: true,
        ),
        materialActions: materialActions,
        cupertinoActions: cupertinoActions,
        needsClose: false,
      );
    },
  );
}
