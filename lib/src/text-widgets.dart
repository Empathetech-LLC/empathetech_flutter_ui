library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Styles an [Icon] from [EzConfig.prefs]
Icon ezIcon(
  IconData icon, {
  Color? color,
  double? size,
}) {
  return Icon(
    icon,
    color: color ?? Color(EzConfig.prefs[buttonTextColorKey]),
    size: size,
  );
}

/// Text that values its personal space
/// And requires a [TextStyle], for wide [TargetPlatform] support
/// Optionally provide [textAlign]
/// Optionally overwrite the transparent [background] color
/// Optionally provide a [navTo] function (ie: [pushScreen]) to make the text an internal link
Widget ezText(
  String text, {
  required TextStyle style,
  TextAlign? textAlign,
  Color background = Colors.transparent,
}) {
  double padding = EzConfig.prefs[paddingKey] / 2.0;

  return Padding(
    padding: EdgeInsets.all(padding),
    child: Container(
      decoration: BoxDecoration(
        color: background.withOpacity(background.opacity * 0.75),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(padding),
      child: Text(text, style: style, textAlign: textAlign),
    ),
  );
}

/// Say it loud, say it proud
/// Background and text colors are built from [EzConfig.prefs] theme values
Widget titleCard(
  String title,
) {
  return Card(
    color: Color(EzConfig.prefs[themeColorKey]),
    child: ezText(title, style: getTextStyle(titleStyleKey)),
  );
}

/// Styles a [PlatformTextFormField] from [EzConfig.prefs]
Widget ezForm({
  required Key? key,
  required TextEditingController? controller,
  required String? hintText,
  bool private = false,
  Iterable<String>? autofillHints,
  String? Function(String?)? validator,
  AutovalidateMode? autovalidateMode,
}) {
  // Gather theme data
  Color buttonColor = Color(EzConfig.prefs[buttonColorKey]);
  Color themeColor = Color(EzConfig.prefs[themeColorKey]);
  Color themeTextColor = Color(EzConfig.prefs[themeTextColorKey]);

  return Container(
    decoration: BoxDecoration(
        border: Border.all(color: buttonColor),
        color: themeColor.withOpacity(themeColor.opacity * 0.75)),
    child: Form(
      key: key,
      child: PlatformTextFormField(
        controller: controller,
        textAlign: TextAlign.center,
        obscureText: private,

        // Hint
        hintText: hintText,
        autofillHints: autofillHints,

        // Validating
        validator: validator,
        autovalidateMode: autovalidateMode,

        // Styling
        style: getTextStyle(dialogContentStyleKey),
        cursorColor: themeTextColor,
      ),
    ),
  );
}
