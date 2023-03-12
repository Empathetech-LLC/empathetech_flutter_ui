library ez_ui;

import '../../ez_ui.dart';
import '../app-config.dart';
import '../text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

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
                ezButton(
                  () {
                    AppConfig.preferences.setString(fontFamilyKey, font);
                    setState(() {
                      currFontFamily = googleStyleAlias(font).fontFamily!;
                    });
                    Navigator.of(context).pop();
                  },
                  () {},
                  PlatformText(
                    font,
                    textAlign: TextAlign.center,
                    style: googleStyleAlias(font),
                  ),
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
        ezButton(
          chooseGoogleFont,
          () {},
          PlatformText(
            'Choose font:\n$currFontFamily',
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              fontSize: buttonTextStyle.fontSize,
              fontFamily: currFontFamily,
              color: buttonTextStyle.color,
            ),
          ),
        ),
        Container(height: buttonSpacer),

        // Font reset
        ezButton(
          () {
            AppConfig.preferences.remove(fontFamilyKey);
            setState(() {
              currFontFamily = defaultFontFamily;
            });
          },
          () {},
          PlatformText(
            'Reset font\n($defaultFontFamily)',
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              fontSize: buttonTextStyle.fontSize,
              fontFamily: defaultFontFamily,
              color: buttonTextStyle.color,
            ),
          ),
        ),
      ],
    );
  }
}
