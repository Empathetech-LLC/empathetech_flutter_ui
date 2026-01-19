/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

/// [ezLog] the passed message and display an [EzAlertDialog] to notify the user
Future<dynamic> ezLogAlert(
  BuildContext context, {
  String? title,
  required String message,
  List<Widget>? customActions,
}) async {
  ezLog(message);

  return showDialog(
    context: context,
    builder: (_) => EzAlertDialog(
      title: Text(
        title ?? EzConfig.l10n.gAttention,
        textAlign: TextAlign.center,
      ),
      contents: <Widget>[Text(message, textAlign: TextAlign.center)],
      actions: customActions,
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
}) =>
    showDialog(
      context: context,
      builder: (BuildContext dContext) => EzAlertDialog(
        title: Text(
          title ?? EzConfig.l10n.csPickerTitle,
          textAlign: TextAlign.center,
        ),
        content: ColorPicker(
          color: startColor,
          mainAxisSize: MainAxisSize.min,
          padding: EdgeInsets.zero,
          spacing: EzConfig.spacing / 2,
          runSpacing: EzConfig.spacing / 2,
          columnSpacing: EzConfig.spacing,
          pickersEnabled: const <ColorPickerType, bool>{
            ColorPickerType.both: false,
            ColorPickerType.primary: false,
            ColorPickerType.accent: false,
            ColorPickerType.bw: false,
            ColorPickerType.custom: false,
            ColorPickerType.customSecondary: false,
            ColorPickerType.wheel: true,
          },
          onColorChanged: onColorChange,
          showRecentColors: true,
          enableOpacity: true,
          opacityThumbRadius: min(EzConfig.padding, 25.0),
          opacityTrackHeight: min(EzConfig.padding * 2, 50.0),
          showColorCode: true,
        ),
        actions: ezActionPair(
          context: context,
          confirmMsg: confirmMsg ?? EzConfig.l10n.gApply,
          onConfirm: () {
            onConfirm();
            Navigator.of(dContext).pop();
          },
          confirmIsDestructive: true,
          denyMsg: denyMsg ?? EzConfig.l10n.gCancel,
          onDeny: () {
            onDeny();
            Navigator.of(dContext).pop();
          },
        ),
        needsClose: false,
      ),
    );
