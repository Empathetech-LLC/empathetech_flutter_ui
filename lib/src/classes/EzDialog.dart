library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Styles a [PlatformAlertDialog] from [EzConfig.prefs]
PlatformAlertDialog EzDialog({
  Key? key,
  Key? widgetKey,
  required BuildContext context,
  required List<Widget> content,
  String? title,
  bool needsClose = true,
}) {
  TextStyle dialogTitleStyle = buildTextStyle(style: dialogTitleStyleKey);
  double dialogSpacer = EzConfig.prefs[dialogSpacingKey];
  double padding = EzConfig.prefs[paddingKey];

  // Builds the title widget based on platform (Cupertino needs extra padding)
  Widget? _title() {
    if (title == null) {
      return null;
    } else {
      if (isCupertino(context)) {
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

  return PlatformAlertDialog(
    key: key,
    widgetKey: widgetKey,

    // Material (Android)
    material: (context, platform) => MaterialAlertDialogData(
      insetPadding: EdgeInsets.all(padding),

      // Title
      title: _title(),
      titlePadding: EdgeInsets.only(top: dialogSpacer, left: padding, right: padding),

      // Content
      content: ezScrollView(children: content),
      contentPadding: EdgeInsets.symmetric(vertical: dialogSpacer, horizontal: padding),
    ),

    // Cupertino (iOS)
    cupertino: (context, platform) => CupertinoAlertDialogData(
      // Title
      title: _title(),

      // Content
      content: ezScrollView(
          children: (needsClose) ? content : [...content, Container(height: padding)]),
      actions: (needsClose)
          ? [
              GestureDetector(
                onTap: () => popScreen(context: context),
                child: ezText(
                  'Close',
                  style: buildTextStyle(style: dialogContentStyleKey),
                  textAlign: TextAlign.center,
                ),
              ),
            ]
          : [],
    ),
  );
}
