library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Styles a [PlatformAlertDialog] from [EzConfig.prefs]
Future<dynamic> ezDialog(
  BuildContext context, {
  required List<Widget> content,
  String? title,
  bool needsClose = true,
}) {
  TextStyle dialogTitleStyle = getTextStyle(dialogTitleStyleKey);
  double dialogSpacer = EzConfig.prefs[dialogSpacingKey];
  double padding = EzConfig.prefs[paddingKey];

  // Builds the title widget based on platform (Cupertino needs extra padding)
  Widget? _title(PlatformTarget platform) {
    if (title == null) {
      return null;
    } else {
      if (platform == PlatformTarget.iOS || platform == PlatformTarget.macOS) {
        return Container(
          padding: EdgeInsets.only(bottom: EzConfig.prefs[dialogSpacingKey]),
          child: Text(
            title,
            style: dialogTitleStyle,
            textAlign: TextAlign.center,
          ),
        );
      } else {
        return Text(
          title,
          style: dialogTitleStyle,
          textAlign: TextAlign.center,
        );
      }
    }
  }

  return showPlatformDialog(
    context: context,
    builder: (context) => PlatformAlertDialog(
      // Material (Android)
      material: (context, platform) => MaterialAlertDialogData(
        insetPadding: EdgeInsets.all(padding),

        // Title
        title: _title(platform),
        titlePadding: EdgeInsets.only(top: dialogSpacer, left: padding, right: padding),

        // Content
        content: ezScrollView(children: content),
        contentPadding: EdgeInsets.symmetric(vertical: dialogSpacer, horizontal: padding),
      ),

      // Cupertino (iOS)
      cupertino: (context, platform) => CupertinoAlertDialogData(
        // Title
        title: _title(platform),

        // Content
        content: ezScrollView(
            children: (needsClose) ? content : [...content, Container(height: padding)]),
        actions: (needsClose)
            ? [
                GestureDetector(
                  onTap: () => popScreen(context),
                  child: ezText(
                    'Close',
                    style: getTextStyle(dialogContentStyleKey),
                    textAlign: TextAlign.center,
                  ),
                ),
              ]
            : [],
      ),
    ),
  );
}

/// Wrap a [ColorPicker] in an [ezDialog]
Future<dynamic> ezColorPicker(
  BuildContext context, {
  required Color startColor,
  required void Function(Color chosenColor) onColorChange,
  required void Function() apply,
  required void Function() cancel,
}) {
  return ezDialog(
    context,
    title: 'Pick a color!',
    content: [
      ColorPicker(
        pickerColor: startColor,
        onColorChanged: onColorChange,
        // ignore: deprecated_member_use
        labelTextStyle: getTextStyle(dialogContentStyleKey),
        // above is required for iOS
      ),
      Container(height: EzConfig.prefs[dialogSpacingKey]),
      ezYesNo(
        context,
        onConfirm: apply,
        onDeny: cancel,
        axis: Axis.vertical,
        confirmMsg: 'Apply',
        denyMsg: 'Cancel',
      ),
    ],
    needsClose: false,
  );
}
