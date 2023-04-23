library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Do you have a void [Function] as a parameter that you want to be optional?
/// Then do nothing!
void doNothing() {}

/// More readable than EzConfig.focus.primaryFocus?.unfocus()
void closeFocus() {
  EzConfig.focus.primaryFocus?.unfocus();
}

/// More readable than Theme.of(context).brightness == Brightness.light
bool isLightTheme(BuildContext context) {
  return Theme.of(context).brightness == Brightness.light;
}

/// More readable than MediaQuery.of(context).size.width
double widthOf(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

/// More readable than MediaQuery.of(context).size.height
double heightOf(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

/// More readable than MediaQuery.of(context).size
Size sizeOf(BuildContext context) {
  return MediaQuery.of(context).size;
}

/// For web use, set the tab's title
void setPageTitle({
  required BuildContext context,
  required String title,
  int? primaryColor,
}) {
  SystemChrome.setApplicationSwitcherDescription(
    ApplicationSwitcherDescription(
      label: title,
      primaryColor: primaryColor,
    ),
  );
}

/// Copy [string] to [ClipboardData] and show a [Fluttertoast] for the user
Future<bool?> copyToClipboard({
  required String string,
  Toast? toastLength,
  int timeInSecForIosWeb = 1,
  double? fontSize,
  ToastGravity? gravity,
  Color? backgroundColor,
  Color? textColor,
  bool webShowClose = false,
  dynamic webBgColor = "linear-gradient(to right, #000000, #000000)",
  dynamic webPosition = "right",
}) async {
  await Clipboard.setData(ClipboardData(text: string));
  return Fluttertoast.showToast(
    msg: 'Copied to clipboard',
    toastLength: Toast.LENGTH_SHORT,
    timeInSecForIosWeb: timeInSecForIosWeb,
    fontSize: fontSize,
    gravity: gravity,
    backgroundColor: backgroundColor,
    textColor: textColor,
    webShowClose: webShowClose,
    webBgColor: webBgColor,
    webPosition: webPosition,
  );
}
