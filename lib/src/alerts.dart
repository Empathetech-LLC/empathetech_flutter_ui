library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'dart:developer';
import 'package:flutter/material.dart';

/// 'Loading...' text but the ellipsis is built from the passed [image] (.gif recommended)
/// The text is "naked"; wrap in a container if necessary
Widget loadingMessage(
  BuildContext context, {
  required Image image,
}) {
  // Gather theme data

  TextStyle style = getTextStyle(titleStyleKey);

  double imageSize = style.fontSize!;
  SizedBox ellipsis = SizedBox(height: imageSize, width: imageSize, child: image);

  return Container(
    child: Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Loading ', style: style),
          ellipsis,
          Text(' ', style: style),
          ellipsis,
          Text(' ', style: style),
          ellipsis,
        ],
      ),
    ),
  );
}

/// [titleCard] designed to grab attention for warnings...
/// [Icon] 'WARNING' [Icon]
///        [content]
Widget warningCard(
  BuildContext context, {
  required String warning,
}) {
  Color iconColor = Color(EzConfig.prefs[alertColorKey]);

  TextStyle titleStyle = getTextStyle(titleStyleKey);
  TextStyle contentStyle = getTextStyle(dialogContentStyleKey);

  double padding = EzConfig.prefs[paddingKey];

  return Card(
    color: Color(EzConfig.prefs[themeColorKey]),
    child: Container(
      width: screenWidth(context),
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
              ezIcon(Icons.warning, color: iconColor),
              Text('WARNING', style: titleStyle),
              ezIcon(Icons.warning, color: iconColor),
            ],
          ),
          Container(height: padding),

          // Label
          Text(warning, style: contentStyle, textAlign: TextAlign.center),
        ],
      ),
    ),
  );
}

/// Log the passed message and display an alert dialog for the user
/// Should always return null via [popScreen]
Future<dynamic> logAlert(
  BuildContext context,
  String message,
) {
  log(message);
  return ezDialog(
    context,
    title: 'Attention:',
    content: [ezText(message, style: getTextStyle(dialogContentStyleKey))],
  );
}
