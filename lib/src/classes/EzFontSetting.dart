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

  late TextStyle buttonTextStyle =
      ezTextStyle(context, MaterialStyles.bodyLarge);
  late double buttonSpacer = EzConfig.prefs[buttonSpacingKey];

  /// Builds an [ezDialog] from mapping [myGoogleFonts] to a list of [EzButton]s
  /// Returns the chosen font's name
  Future<dynamic> _chooseGoogleFont() {
    return openDialog(
      context: context,
      dialog: EzDialog(
        title: EzText.simple(
          'Choose a font',
          style: ezTextStyle(context, MaterialStyles.titleSmall),
        ),
        contents: EzFonts.values
            .map(
              (EzFonts font) => Column(
                children: [
                  // Map font to a selectable button (title == name)
                  EzButton(
                    context: context,
                    action: () {
                      EzConfig.preferences
                          .setString(fontFamilyKey, gStyleName(font));
                      setState(() {
                        currFontFamily = gStyle(font).fontFamily!;
                      });
                      popScreen(context: context, pass: font);
                    },
                    body: EzText.simple(gStyleName(font), style: gStyle(font)),
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
        EzText.simple('Font family',
            style: ezTextStyle(context, MaterialStyles.titleMedium)),

        // Font picker
        EzButton(
          context: context,
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
          context: context,
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
