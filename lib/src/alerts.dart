library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Log the passed message and display an alert dialog for the user
void popNLog(
  BuildContext context,
  String message,
) {
  log(message);
  ezDialog(
    context: context,
    title: 'Attention:',
    content: paddedText(message),
  );
}

/// Say it loud, say it proud
/// Background and text colors are built from [AppConfig.prefs] theme values
Widget titleCard(
  String title,
) {
  return Card(
    color: Color(AppConfig.prefs[themeColorKey]),
    child: paddedText(title, style: getTextStyle(titleStyleKey)),
  );
}

/// 'Loading...' text but the elipsis is built from the passed [image] (gifs recommended)
/// The text is "naked"; wrap in a container if necessary
Widget loadingMessage({
  required BuildContext context,
  required Image image,
}) {
  // Gather theme data

  TextStyle style = getTextStyle(titleStyleKey);

  double imageSize = style.fontSize!;
  SizedBox elipsis = SizedBox(height: imageSize, width: imageSize, child: image);

  return Container(
    child: Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Loading ', style: style),
          elipsis,
          Text(' ', style: style),
          elipsis,
          Text(' ', style: style),
          elipsis,
        ],
      ),
    ),
  );
}

/// [titleCard] designed to grab attention for warnings...
/// [Icon] 'WARNING' [Icon]
///        [content]
Widget warningCard({
  required BuildContext context,
  required String content,
}) {
  // Gather theme data

  TextStyle titleStyle = getTextStyle(titleStyleKey);
  TextStyle contentStyle = getTextStyle(dialogContentStyleKey);

  double padding = AppConfig.prefs[paddingKey];

  return Card(
    color: Color(AppConfig.prefs[themeColorKey]),
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
              Icon(Icons.warning, color: Colors.amber),
              Text('WARNING', style: titleStyle),
              Icon(Icons.warning, color: Colors.amber),
            ],
          ),
          Container(height: padding),

          // Label
          Text(content, style: contentStyle, textAlign: TextAlign.center),
        ],
      ),
    ),
  );
}

/// Styles a [PlatformAlertDialog] from [AppConfig.prefs]
void ezDialog({
  required BuildContext context,
  required Widget content,
  String? title,
}) {
  // Gather theme data
  double dialogSpacer = AppConfig.prefs[dialogSpacingKey];
  double padding = AppConfig.prefs[paddingKey];

  showPlatformDialog(
    context: context,
    builder: (context) => PlatformAlertDialog(
      title: title == null ? null : Text(title, textAlign: TextAlign.center),
      content: content,

      // Styling
      material: (context, platform) => MaterialAlertDialogData(
        insetPadding: EdgeInsets.all(padding),
        titlePadding: title == null
            ? EdgeInsets.zero
            : EdgeInsets.symmetric(vertical: dialogSpacer, horizontal: padding),
        contentPadding: EdgeInsets.symmetric(vertical: dialogSpacer, horizontal: padding),
      ),
      cupertino: (context, platform) => CupertinoAlertDialogData(),
    ),
  );
}
