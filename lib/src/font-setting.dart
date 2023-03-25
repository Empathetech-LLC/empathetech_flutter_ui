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

  /// Builds an [ezDialog] from mapping [myGoogleFonts] to a list of [EZButton]s
  void chooseGoogleFont() {
    ezDialog(
      context: context,
      title: 'Choose a font',
      content: ezScrollView(
        children: myGoogleFonts
            .map(
              (String font) => Column(
                children: [
                  // Map font to a selectable button (title == name)
                  EZButton(
                    action: () {
                      AppConfig.preferences.setString(fontFamilyKey, font);
                      setState(() {
                        currFontFamily = googleStyleAlias(font).fontFamily!;
                      });
                      Navigator.of(context).pop();
                    },
                    body: Text(font, style: googleStyleAlias(font)),
                  ),
                  Container(height: buttonSpacer),
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
        // Title
        ezText('Font family', style: getTextStyle(subTitleStyleKey)),
        Container(height: buttonSpacer),

        // Font picker
        EZButton(
          action: chooseGoogleFont,
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
            AppConfig.preferences.remove(fontFamilyKey);
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
