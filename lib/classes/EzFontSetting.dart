library empathetech_flutter_ui;

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
  final String defaultFontFamily = EzConfig.instance.defaults[fontFamilyKey];
  String currFontFamily = EzConfig.instance.prefs[fontFamilyKey];

  final double space = EzConfig.instance.prefs[buttonSpacingKey];
  final double padding = EzConfig.instance.prefs[paddingKey];

  late TextStyle? titleTextStyle = headlineSmall(context);

  /// Builds an [EzDialog] from mapping [googleStyles] to a list of [ElevatedButton]s
  /// Returns the chosen font's name
  Future<dynamic> _chooseGoogleFont() {
    List<ListTile> tiles = [];

    googleStyles.forEach((String font, TextStyle style) {
      tiles.add(
        // Map font to a selectable button (title == name)
        ListTile(
          onTap: () {
            EzConfig.instance.preferences.setString(fontFamilyKey, font);
            setState(() {
              currFontFamily = style.fontFamily!;
            });
            popScreen(context: context, pass: font);
          },
          title: Text(
            (font == defaultFontFamily) ? '$font* (Default)' : font,
            style: style,
            textAlign: TextAlign.center,
          ),
        ),
      );
    });

    return showPlatformDialog(
      context: context,
      builder: (context) => EzDialog(
        title: EzSelectableText('Choose a font'),
        content: ListView.separated(
          itemCount: tiles.length,
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemBuilder: (BuildContext context, int index) {
            return tiles[index];
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _chooseGoogleFont,
      icon: const Icon(LineIcons.font),
      label: Text(
        'Font Family',
        style: TextStyle(fontFamily: currFontFamily),
        textAlign: TextAlign.center,
      ),
    );
  }
}
