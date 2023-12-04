/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzFontSetting extends StatefulWidget {
  /// Standardized tool for updating the [fontFamilyKey] in [EzConfig]
  /// [EzFontSetting] options are built from [googleStyles]
  const EzFontSetting({Key? key}) : super(key: key);

  @override
  _FontFamilySettingState createState() => _FontFamilySettingState();
}

class _FontFamilySettingState extends State<EzFontSetting> {
  // Gather theme data //

  String? currFontFamily = EzConfig.get(fontFamilyKey);
  final String _defaultFontFamily = EzConfig.instance.defaults[fontFamilyKey];

  final double _buttonSpacer = EzConfig.get(buttonSpacingKey);

  // Define button functions //

  /// Builds an [EzAlertDialog] with [googleStyles] mapped to a list of [ElevatedButton]s
  Future<dynamic> _chooseGoogleFont(BuildContext context) {
    List<Widget> buttons = [];

    googleStyles.forEach((String font, TextStyle style) {
      buttons.addAll([
        ElevatedButton(
          onPressed: () {
            EzConfig.instance.preferences.setString(fontFamilyKey, font);
            setState(() {
              currFontFamily = style.fontFamily!;
            });
            popScreen(context: context, pass: font);
          },
          child: Text(
            (font == _defaultFontFamily)
                // Marks the default with "* (default)"
                ? EFUILang.of(context)!.gDefaultEntry(font)
                : font,
            style: style,
            textAlign: TextAlign.center,
          ),
        ),
        EzSpacer(_buttonSpacer),
      ]);
    });

    return showPlatformDialog(
      context: context,
      builder: (context) => EzAlertDialog(
        title: Text(
          EFUILang.of(context)!.stsFonts,
          textAlign: TextAlign.center,
        ),
        // Remove the trailing button spacer
        contents: buttons.sublist(0, buttons.length - 1),
      ),
    );
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _chooseGoogleFont(context),
      icon: const Icon(LineIcons.font),
      label: Text(
        EFUILang.of(context)!.stsTextFont,
        style: TextStyle(fontFamily: currFontFamily),
        textAlign: TextAlign.center,
      ),
    );
  }
}
