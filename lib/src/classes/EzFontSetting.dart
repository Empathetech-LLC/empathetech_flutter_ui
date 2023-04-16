library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class EzFontSetting extends StatefulWidget {
  /// Creates a tool for updating the app's font
  EzFontSetting({Key? key}) : super(key: key);

  @override
  _FontFamilySettingState createState() => _FontFamilySettingState();
}

class _FontFamilySettingState extends State<EzFontSetting> {
  late String defaultFontFamily = EzConfig.defaults[fontFamilyKey];
  late String currFontFamily = EzConfig.prefs[fontFamilyKey];

  late TextStyle buttonTextStyle = buildTextStyle(styleKey: buttonStyleKey);
  late double buttonSpacer = EzConfig.prefs[buttonSpacingKey];

  /// Builds an [ezDialog] from mapping [myGoogleFonts] to a list of [EzButton]s
  /// Returns the chosen font's name
  Future<dynamic> _chooseGoogleFont() {
    return openDialog(
      context: context,
      dialog: EzDialog(
        title: EzText.simple(
          'Choose a font',
          style: buildTextStyle(styleKey: dialogTitleStyleKey),
        ),
        contents: myGoogleFonts
            .map(
              (String font) => Column(
                children: [
                  // Map font to a selectable button (title == name)
                  EzButton(
                    action: () {
                      EzConfig.preferences.setString(fontFamilyKey, font);
                      setState(() {
                        currFontFamily = gStyle(font).fontFamily!;
                      });
                      popScreen(context: context, pass: font);
                    },
                    body: EzText.simple(font, style: gStyle(font)),
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
        EzText.simple('Font family', style: buildTextStyle(styleKey: subTitleStyleKey)),

        // Font picker
        EzButton(
          action: _chooseGoogleFont,
          body: EzText.simple(
            'Choose font:\n$currFontFamily',
            style: TextStyle(
              fontSize: buttonTextStyle.fontSize,
              fontFamily: currFontFamily,
              color: buttonTextStyle.color,
            ),
          ),
        ),
        Container(height: buttonSpacer),

        // Font reset
        EzButton(
          action: () {
            EzConfig.preferences.remove(fontFamilyKey);
            setState(() {
              currFontFamily = defaultFontFamily;
            });
          },
          body: EzText.simple(
            'Reset font\n($defaultFontFamily)',
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
