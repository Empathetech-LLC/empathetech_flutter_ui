library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class FontFamilySetting extends StatefulWidget {
  const FontFamilySetting({Key? key}) : super(key: key);

  @override
  _FontFamilySettingState createState() => _FontFamilySettingState();
}

class _FontFamilySettingState extends State<FontFamilySetting> {
  //// Initialize state

  // Gather theme data
  late String defaultFontFamily = AppConfig.defaults[fontFamilyKey];
  late String currFontFamily = AppConfig.prefs[fontFamilyKey];

  late TextStyle buttonTextStyle = getTextStyle(buttonStyleKey);
  late double buttonSpacer = AppConfig.prefs[buttonSpacingKey];

  //// Define interaction methods

  // onPressed method for font picker button
  void chooseGoogleFont() {
    ezDialog(
      context,

      // Title
      'Choose a font',

      // Children
      myGoogleFonts
          .map(
            (String font) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Button with the title of the font in that font's style
                ezTextButton(
                  () {
                    AppConfig.preferences.setString(fontFamilyKey, font);
                    setState(() {
                      currFontFamily = googleStyleAlias(font).fontFamily!;
                    });
                    Navigator.of(context).pop();
                  },
                  () {},
                  font,
                  googleStyleAlias(font),
                ),
                Container(
                  height: buttonSpacer,
                ),
              ],
            ),
          )
          .toList(),
    );
  }

  //// Draw state

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Font picker
        ezTextButton(
          chooseGoogleFont,
          () {},
          'Choose font:\n$currFontFamily',
          TextStyle(
            fontSize: buttonTextStyle.fontSize,
            fontFamily: currFontFamily,
            color: buttonTextStyle.color,
          ),
        ),
        Container(height: buttonSpacer),

        // Font reset
        ezTextButton(
          () {
            AppConfig.preferences.remove(fontFamilyKey);
            setState(() {
              currFontFamily = defaultFontFamily;
            });
          },
          () {},
          'Reset font\n($defaultFontFamily)',
          TextStyle(
            fontSize: buttonTextStyle.fontSize,
            fontFamily: defaultFontFamily,
            color: buttonTextStyle.color,
          ),
        ),
      ],
    );
  }
}
