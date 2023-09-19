/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

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
  String? currFontFamily = EzConfig.instance.fontFamily;

  final String defaultFontFamily = EzConfig.instance.defaults[fontFamilyKey];
  final double space = EzConfig.instance.prefs[buttonSpacingKey];

  /// Builds an [EzAlertDialog] from mapping [googleStyles] to a list of [ElevatedButton]s
  /// Returns the chosen font's name
  Future<dynamic> _chooseGoogleFont(BuildContext context) {
    List<Widget> buttons = [];

    googleStyles.forEach((String font, TextStyle style) {
      buttons.addAll([
        // Map font to a selectable button (title == name)
        ElevatedButton(
          onPressed: () {
            EzConfig.instance.preferences.setString(fontFamilyKey, font);
            setState(() {
              currFontFamily = style.fontFamily!;
            });
            popScreen(context: context, pass: font);
          },
          child: Text(
            (font == defaultFontFamily) ? '$font* (Default)' : font,
            style: style,
            textAlign: TextAlign.center,
          ),
        ),
        EzSpacer(space),
      ]);
    });

    return showPlatformDialog(
      context: context,
      builder: (context) => EzAlertDialog(
        title: const EzSelectableText('Choose a font'),
        contents: buttons,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _chooseGoogleFont(context),
      icon: const Icon(LineIcons.font),
      label: Text(
        'Font Family',
        style: TextStyle(fontFamily: currFontFamily),
        textAlign: TextAlign.center,
      ),
    );
  }
}
