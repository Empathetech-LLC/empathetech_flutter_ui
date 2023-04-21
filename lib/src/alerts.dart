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
      title: EzText.simple('Attention:'),
      contents: [
        EzText.simple(message),
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
}) {
  Color iconColor = Color(EzConfig.prefs[alertColorKey]);

  double padding = EzConfig.prefs[paddingKey];

  return Card(
    child: Container(
      width: widthOf(context),
      padding: EdgeInsets.all(padding),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Title
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.warning, color: iconColor),
              EzText.simple('WARNING'),
              Icon(Icons.warning, color: iconColor),
            ],
          ),
          Container(height: padding),

          // Label
          EzText.simple(warning),
        ],
      ),
    ),
  );
}
