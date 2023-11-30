/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

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

  Locale? currLocale = EzConfig.instance.locale;

  final double _padding = EzConfig.instance.prefs[paddingKey];
  final double _buttonSpacer = EzConfig.instance.prefs[buttonSpacingKey];

  // Gather the list items //

  CountryFlag _flag(Locale? locale) {
    final Locale flagLocale = locale ?? Localizations.localeOf(context);

    final double? flagHeight = Theme.of(context)
        .elevatedButtonTheme
        .style
        ?.textStyle
        ?.resolve({})?.fontSize;
    final double flagWidth = flagHeight! * 2;

    return (flagLocale.countryCode == null)
        ? CountryFlag.fromLanguageCode(
            flagLocale.languageCode,
            height: flagHeight,
            width: flagWidth,
          )
        : CountryFlag.fromCountryCode(
            flagLocale.countryCode!,
            height: flagHeight,
            width: flagWidth,
          );
  }

  /// Builds an [EzAlertDialog] with [Locale]s mapped to a list of [ElevatedButton]s
  Future<dynamic> _chooseLocale(BuildContext context) {
    final List<Locale> _locales = (widget.locales == null)
        ? EFUILang.supportedLocales
        : EFUILang.supportedLocales + widget.locales!;

    List<Widget> buttons = [];

    _locales.forEach((Locale locale) {
      List<String> localeData = [locale.languageCode];
      locale.countryCode ?? localeData.add(locale.countryCode!);

      buttons.addAll([
        ElevatedButton(
          onPressed: () {
            EzConfig.instance.preferences.setStringList(localeKey, localeData);
            setState(() {
              currLocale = locale;
            });
            popScreen(context: context, pass: locale);
          },
          child: EzRow(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _flag(locale),
              EzSpacer.row(_padding),
              Text(
                locale.toString(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        EzSpacer(_buttonSpacer),
      ]);
    });

    return showPlatformDialog(
      context: context,
      builder: (context) => EzAlertDialog(
        title: Text(
          EFUILang.of(context)!.ssLanguages,
          textAlign: TextAlign.center,
        ),
        contents: buttons,
      ),
    );
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _chooseLocale(context),
      child: EzRow(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _flag(currLocale),
          EzSpacer.row(_padding),
          Text(
            EFUILang.of(context)!.ssLanguage,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
