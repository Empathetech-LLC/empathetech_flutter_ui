library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Log the passed message and display an alert dialog for the user
Future<bool> logAlert(
  BuildContext context,
  String message,
) async {
  log(message);
  return await ezDialog(
    context,
    title: 'Attention:',
    content: [ezText(message, style: getTextStyle(dialogContentStyleKey))],
  );
}

/// Say it loud, say it proud
/// Background and text colors are built from [AppConfig.prefs] theme values
Widget titleCard(
  String title,
) {
  return Card(
    color: Color(AppConfig.prefs[themeColorKey]),
    child: ezText(title, style: getTextStyle(titleStyleKey)),
  );
}

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
              ezIcon(Icons.warning, color: Colors.amber),
              Text('WARNING', style: titleStyle),
              ezIcon(Icons.warning, color: Colors.amber),
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

/// Styles a [PlatformAlertDialog] from [AppConfig.prefs]
Future<bool> ezDialog(
  BuildContext context, {
  required List<Widget> content,
  String? title,
  bool needsClose = true,
}) async {
  // Gather theme data

  TextStyle dialogTitleStyle = getTextStyle(dialogTitleStyleKey);
  double dialogSpacer = AppConfig.prefs[dialogSpacingKey];
  double padding = AppConfig.prefs[paddingKey];

  return await showPlatformDialog(
        context: context,
        builder: (context) => PlatformAlertDialog(
          // Material (Android)
          material: (context, platform) => MaterialAlertDialogData(
            insetPadding: EdgeInsets.all(padding),

            // Title
            title: title == null
                ? null
                : Text(
                    title,
                    style: dialogTitleStyle,
                    textAlign: TextAlign.center,
                  ),
            titlePadding: title == null
                ? EdgeInsets.zero
                : EdgeInsets.symmetric(vertical: dialogSpacer, horizontal: padding),

            // Content
            content: ezScrollView(children: content),
            contentPadding: EdgeInsets.only(
              bottom: dialogSpacer,
              left: padding,
              right: padding,
            ),
          ),

          // Cupertino (iOS)
          cupertino: (context, platform) => CupertinoAlertDialogData(
            // Title
            title: title == null
                ? null
                : Container(
                    padding: EdgeInsets.only(bottom: AppConfig.prefs[dialogSpacingKey]),
                    child: Text(
                      title,
                      style: dialogTitleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),

            // Content
            content: ezScrollView(
                children:
                    (needsClose) ? content : [...content, Container(height: padding)]),
            actions: (needsClose)
                ? [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
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
      ) ??
      false;
}
