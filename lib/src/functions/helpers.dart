/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Do you have a void [Function] as a parameter that you want to be optional?
/// Then do nothing!
void doNothing() {}

/// More readable than FocusScope.of(context).unfocus();
void closeKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}

/// More readable than MediaQuery.of(context).size.width
double widthOf(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

/// More readable than MediaQuery.of(context).size.height
double heightOf(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

/// Returns the soon-to-be rendered size of text via a [TextPainter]
/// [scalar] should be the value from MediaQuery.of(context).textScaleFactor
Size measureText({
  required String text,
  required double scalar,
  required TextStyle? style,
}) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: 1,
    textScaleFactor: scalar,
    textDirection: TextDirection.ltr,
  )..layout();

  return textPainter.size;
}

/// Returns whether the passed [path] refers to one of the stored [EzConfig.assets]
bool isAsset(String? path) {
  return EzConfig.instance.assets.contains(path);
}

/// For web use, set the tab's title
void setPageTitle({
  required BuildContext context,
  required String title,
}) {
  SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription(label: title));
}

/// Copy [string] to [ClipboardData] and show a [Fluttertoast] for the user
Future<bool?> copyToClipboard({required String string}) async {
  await Clipboard.setData(ClipboardData(text: string));
  return Fluttertoast.showToast(
    msg: 'Copied to clipboard',
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: Colors.black,
    fontSize: 18,
    textColor: Colors.white,
  );
}
