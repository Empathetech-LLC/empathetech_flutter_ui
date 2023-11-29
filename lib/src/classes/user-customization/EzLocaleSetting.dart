/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzLocaleSetting extends StatefulWidget {
  /// Pass in any custom [supportedLocales]
  final List<Locale>? locales;

  /// Standardized tool for updating [EzConfig] Locale
  const EzLocaleSetting({Key? key, this.locales}) : super(key: key);

  @override
  _LocaleSettingState createState() => _LocaleSettingState();
}

class _LocaleSettingState extends State<EzLocaleSetting> {
  // Gather theme data //

  Locale currLocale = EzConfig.instance.locale;

  @override
  Widget build(BuildContext context) {
    // Define the list items //

    final TextStyle? style = Theme.of(context).dropdownMenuTheme.textStyle;

    final List<DropdownMenuItem<Locale>> items = [
      DropdownMenuItem<Hand>(
        child: Text(handName(context, Hand.right)),
        value: Hand.right,
      ),
      DropdownMenuItem<Hand>(
        child: Text(handName(context, Hand.left)),
        value: Hand.left,
      ),
    ];

    // Return the build //

    // Define the build contents locally so it can be reversed in real-time alongside user selections
    List<Widget> _children = [
      // Label
      Text(
        EFUILang.of(context)!.hsLocale,
        style: style,
        textAlign: TextAlign.center,
      ),
      EzSpacer.row(EzConfig.instance.prefs[buttonSpacingKey]),

      // Button
      Semantics(
        button: true,
        hint:
            "${EFUILang.of(context)!.hsHandSemantics} ${handName(context, currSide)}",
        child: ExcludeSemantics(
          child: DropdownButton<Hand>(
            value: currSide,
            items: items,
            dropdownColor: Theme.of(context).scaffoldBackgroundColor,
            onChanged: (Hand? newLocale) {
              switch (newLocale) {
                case Hand.right:
                  EzConfig.instance.preferences.remove(isRightKey);
                  setState(() {
                    currSide = Hand.right;
                  });
                  break;

                case Hand.left:
                  EzConfig.instance.preferences.setBool(isRightKey, false);
                  setState(() {
                    currSide = Hand.left;
                  });
                  break;

                default:
                  break;
              }
            },
          ),
        ),
      ),
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          (currSide == Hand.right) ? _children : _children.reversed.toList(),
    );
  }
}
