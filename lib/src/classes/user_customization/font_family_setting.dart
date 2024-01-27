/* empathetech_flutter_ui
 * Copyright (c) 2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzFontSetting extends StatefulWidget {
  /// Standardized tool for updating the [fontFamilyKey] in [EzConfig]
  /// [EzFontSetting] options are built from [googleStyles]
  const EzFontSetting({super.key});

  @override
  State<EzFontSetting> createState() => _FontFamilySettingState();
}

class _FontFamilySettingState extends State<EzFontSetting> {
  // Gather the theme data //

  final String _defaultFontFamily = EzConfig.getDefault(fontFamilyKey);
  String? currFontFamily = EzConfig.get(fontFamilyKey);

  final EzSpacer spacer = EzSpacer(EzConfig.get(spacingKey));

  // Define button functions //

  /// Builds an [EzAlertDialog] with [googleStyles] mapped to a list of [ElevatedButton]s
  Future<dynamic> _chooseGoogleFont(BuildContext context) {
    final List<Widget> buttons = <Widget>[];

    googleStyles.forEach((String font, TextStyle style) {
      buttons.addAll(<Widget>[
        ElevatedButton(
          onPressed: () {
            EzConfig.setString(fontFamilyKey, font);
            setState(() {
              currFontFamily = style.fontFamily!;
            });
            popScreen(context: context, result: font);
          },
          child: Text(
            (font == _defaultFontFamily)
                // Marks the default with "* (default)"
                ? EFUILang.of(context)!.gDefaultEntry(font)
                : font,
            style: style,
          ),
        ),
        spacer,
      ]);
    });

    return showPlatformDialog(
      context: context,
      builder: (BuildContext context) => EzAlertDialog(
        title: Text(
          EFUILang.of(context)!.tsFonts,
          textAlign: TextAlign.center,
        ),
        // Remove the trailing button spacer
        contents: buttons.sublist(0, buttons.length - 1),
      ),
    );
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _chooseGoogleFont(context),
      icon: const Icon(LineIcons.font),
      label: Text(
        EFUILang.of(context)!.tsFontFamily,
        style: TextStyle(fontFamily: currFontFamily),
      ),
    );
  }
}
