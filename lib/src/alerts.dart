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
      title: EzText.simple(
        'Attention:',
        style: buildTextStyle(style: dialogTitleStyleKey),
        textAlign: TextAlign.center,
      ),
      contents: [
        EzText.simple(message, style: buildTextStyle(style: dialogContentStyleKey)),
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

  TextStyle titleStyle = buildTextStyle(style: titleStyleKey);
  TextStyle contentStyle = buildTextStyle(style: dialogContentStyleKey);

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
              EzIcon(Icons.warning, color: iconColor),
              EzText.simple('WARNING', style: titleStyle),
              EzIcon(Icons.warning, color: iconColor),
            ],
          ),
          Container(height: padding),

          // Label
          EzText.simple(
            warning,
            style: contentStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

/// 'Loading...' text but the ellipsis is built from the passed [image] (.gif recommended)
/// [Row] of [EzText] wrapped in a [Center]
/// Make this the child of your own background [Widget] if necessary
Center loadingMessage({
  required BuildContext context,
  required Image image,
}) {
  // Gather theme data

  TextStyle style = buildTextStyle(style: titleStyleKey);

  double imageSize = style.fontSize!;
  SizedBox ellipsis = SizedBox(height: imageSize, width: imageSize, child: image);

  return Center(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        EzText.simple('Loading ', style: style),
        ellipsis,
        EzText.simple(' ', style: style),
        ellipsis,
        EzText.simple(' ', style: style),
        ellipsis,
      ],
    ),
  );
}
