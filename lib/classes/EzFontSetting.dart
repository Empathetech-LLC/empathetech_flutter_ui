library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzFontSetting extends StatefulWidget {
  /// Standardized tool for updating the [fontFamilyKey] in [EzConfig.prefs]
  /// [EzFontSetting] options are built from [googleStyles]
  EzFontSetting({Key? key}) : super(key: key);

  @override
  _FontFamilySettingState createState() => _FontFamilySettingState();
}

class _FontFamilySettingState extends State<EzFontSetting> {
  late String defaultFontFamily = EzConfig.defaults[fontFamilyKey];
  late String currFontFamily = EzConfig.prefs[fontFamilyKey];

  late double buttonSpacer = EzConfig.prefs[buttonSpacingKey];
  late double padding = EzConfig.prefs[paddingKey];

  late TextStyle? titleTextStyle = headlineSmall(context);

  /// Builds an [EzDialog] from mapping [googleStyles] to a list of [ElevatedButton]s
  /// Returns the chosen font's name
  Future<dynamic> _chooseGoogleFont() {
    List<Widget> buttons = [];

    googleStyles.forEach((String font, TextStyle style) {
      buttons.addAll([
        // Map font to a selectable button (title == name)
        ElevatedButton(
          onPressed: () {
            EzConfig.preferences.setString(fontFamilyKey, font);
            setState(() {
              currFontFamily = style.fontFamily!;
            });
            popScreen(context: context, pass: font);
          },
          child: Text(
            font,
            style: style,
            textAlign: TextAlign.center,
          ),
        ),
        Container(height: buttonSpacer),
      ]);
    });

    return openDialog(
      context: context,
      dialog: EzDialog(
        title: ezText('Choose a font'),
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
        ezText('Font family', style: titleTextStyle),
        Container(height: padding),

        // Font picker
        ElevatedButton(
          onPressed: _chooseGoogleFont,
          child: Text(
            'Choose font:\n$currFontFamily',
            style: TextStyle(fontFamily: currFontFamily),
            textAlign: TextAlign.center,
          ),
        ),
        Container(height: buttonSpacer),

        // Font reset
        ElevatedButton(
          onPressed: () {
            EzConfig.preferences.remove(fontFamilyKey);
            setState(() {
              currFontFamily = defaultFontFamily;
            });
          },
          child: Text(
            'Reset font\n($defaultFontFamily)',
            style: TextStyle(fontFamily: defaultFontFamily),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
