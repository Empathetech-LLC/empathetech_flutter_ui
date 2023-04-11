library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class EzFontSetting extends StatefulWidget {
  /// Creates a tool for updating the app's font
  const EzFontSetting({Key? key}) : super(key: key);

  @override
  _FontFamilySettingState createState() => _FontFamilySettingState();
}

class _FontFamilySettingState extends State<EzFontSetting> {
  late String defaultFontFamily = EzConfig.defaults[fontFamilyKey];
  late String currFontFamily = EzConfig.prefs[fontFamilyKey];

  late TextStyle buttonTextStyle = getTextStyle(buttonStyleKey);
  late double buttonSpacer = EzConfig.prefs[buttonSpacingKey];

  /// Builds an [ezDialog] from mapping [myGoogleFonts] to a list of [EZButton]s
  /// Returns the chosen font's name
  Future<dynamic> _chooseGoogleFont() {
    return ezDialog(
      context,
      title: 'Choose a font',
      content: myGoogleFonts
          .map(
            (String font) => Column(
              children: [
                // Map font to a selectable button (title == name)
                EZButton(
                  action: () {
                    EzConfig.preferences.setString(fontFamilyKey, font);
                    setState(() {
                      currFontFamily = googleStyleAlias(font).fontFamily!;
                    });
                    popScreen(context, pass: font);
                  },
                  body: Text(font, style: googleStyleAlias(font)),
                ),
                Container(height: buttonSpacer),
              ],
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Title
        ezText('Font family', style: getTextStyle(subTitleStyleKey)),

        // Font picker
        EZButton(
          action: _chooseGoogleFont,
          body: Text(
            'Choose font:\n$currFontFamily',
            style: TextStyle(
              fontSize: buttonTextStyle.fontSize,
              fontFamily: currFontFamily,
              color: buttonTextStyle.color,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(height: buttonSpacer),

        // Font reset
        EZButton(
          action: () {
            EzConfig.preferences.remove(fontFamilyKey);
            setState(() {
              currFontFamily = defaultFontFamily;
            });
          },
          body: Text(
            'Reset font\n($defaultFontFamily)',
            style: TextStyle(
              fontSize: buttonTextStyle.fontSize,
              fontFamily: defaultFontFamily,
              color: buttonTextStyle.color,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
