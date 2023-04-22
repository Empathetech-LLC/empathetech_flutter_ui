library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class EzFontSetting extends StatefulWidget {
  /// Standardized tool for updating the [fontFamilyKey] in [EzConfig.prefs]
  /// [EzFontSetting] options are built from [EzFonts]
  EzFontSetting({Key? key}) : super(key: key);

  @override
  _FontFamilySettingState createState() => _FontFamilySettingState();
}

class _FontFamilySettingState extends State<EzFontSetting> {
  late String defaultFontFamily = EzConfig.defaults[fontFamilyKey];
  late String currFontFamily = EzConfig.prefs[fontFamilyKey];

  late double buttonSpacer = EzConfig.prefs[buttonSpacingKey];

  /// Builds an [EzDialog] from mapping [EzFonts] to a list of [EzButton]s
  /// Returns the chosen font's name
  Future<dynamic> _chooseGoogleFont() {
    List<Widget> buttons = [];

    EzFonts.values.forEach((font) {
      buttons.addAll([
        // Map font to a selectable button (title == name)
        EzButton(
          onPressed: () {
            EzConfig.preferences.setString(fontFamilyKey, gStyleName(font));
            setState(() {
              currFontFamily = gStyle(font).fontFamily!;
            });
            popScreen(context: context, pass: font);
          },
          child: EzText.simple(gStyleName(font), style: gStyle(font)),
        ),
        Container(height: buttonSpacer),
      ]);
    });

    return openDialog(
      context: context,
      dialog: EzDialog(
        title: EzText.simple('Choose a font'),
        contents: buttons,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return EzScrollView(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Title
        EzText.simple('Font family'),

        // Font picker
        EzButton(
          onPressed: _chooseGoogleFont,
          child: EzText.simple(
            'Choose font:\n$currFontFamily',
            style: TextStyle(fontFamily: currFontFamily),
          ),
        ),
        Container(height: buttonSpacer),

        // Font reset
        EzButton(
          onPressed: () {
            EzConfig.preferences.remove(fontFamilyKey);
            setState(() {
              currFontFamily = defaultFontFamily;
            });
          },
          child: EzText.simple(
            'Reset font\n($defaultFontFamily)',
            style: TextStyle(fontFamily: defaultFontFamily),
          ),
        ),
      ],
    );
  }
}
