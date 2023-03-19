library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Creates a tool for updating the app's font
class FontFamilySetting extends StatefulWidget {
  const FontFamilySetting({Key? key}) : super(key: key);

  @override
  _FontFamilySettingState createState() => _FontFamilySettingState();
}

class _FontFamilySettingState extends State<FontFamilySetting> {
  // Initialize state

  late String defaultFontFamily = AppConfig.defaults[fontFamilyKey];
  late String currFontFamily = AppConfig.prefs[fontFamilyKey];

  late TextStyle buttonTextStyle = getTextStyle(buttonStyleKey);
  late double buttonSpacer = AppConfig.prefs[buttonSpacingKey];

  /// Builds an [ezDialog] from mapping [myGoogleFonts] to a list of [ezTextButton]s
  void chooseGoogleFont() {
    ezDialog(
      context,
      'Choose a font',
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        // Map myGoogleFonts to...
        children: myGoogleFonts
            .map(
              (String font) => Column(
                children: [
                  // ...a selectable button (title == font name)
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
      ),
    );
  }

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
