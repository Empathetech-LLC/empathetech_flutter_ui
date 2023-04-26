library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'dart:developer';
import 'package:flutter/material.dart';

/// Log the passed message and display an [EzDialog] for the user
/// Should always return null via [popScreen]
Future<dynamic> logAlert(
  BuildContext context,
  String message,
) {
  log(message);
  return openDialog(
    context: context,
    dialog: EzDialog(
      title: ezText('Attention:'),
      contents: [
        ezText(message),
      ],
    ),
  );
}

/// [Card] designed to grab attention for warnings...
/// [Icon] 'WARNING' [Icon]
///        [content]
Card warningCard({
  required BuildContext context,
  required String warning,
  TextStyle? style,
}) {
  Color iconColor = Color(EzConfig.prefs[alertColorKey]);

  double padding = EzConfig.prefs[paddingKey];

  return Card(
    child: Container(
      padding: EdgeInsets.all(padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Title
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Thing1
              Icon(
                Icons.warning,
                color: iconColor,
                size: style?.fontSize,
              ),
              Container(width: padding),

              ezText(
                'WARNING',
                style: style,
              ),
              Container(width: padding),

              // Thing 2
              Icon(
                Icons.warning,
                color: iconColor,
                size: style?.fontSize,
              ),
            ],
          ),
          Container(height: padding),

          // Label
          ezText(warning, style: style),
        ],
      ),
    ),
  );
}
