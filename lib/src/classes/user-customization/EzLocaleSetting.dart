/* empathetech_flutter_ui
 * Copyright (c) 2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

class EzLocaleSetting extends StatefulWidget {
  /// Pass in any custom supported [Locale]s
  final List<Locale>? locales;

  /// Standardized tool for updating the current [Locale]
  const EzLocaleSetting({Key? key, this.locales}) : super(key: key);

  @override
  _LocaleSettingState createState() => _LocaleSettingState();
}

class _LocaleSettingState extends State<EzLocaleSetting> {
  // Gather the theme data //

  late Locale currLocale = Localizations.localeOf(context);

  final double buttonSpace = EzConfig.get(buttonSpacingKey);
  late final EzSpacer _buttonSpacer = EzSpacer(buttonSpace);

  // Gather the list items //

  CountryFlag _flag(Locale locale) {
    final Locale flagLocale = locale;

    final double flagHeight = MediaQuery.textScalerOf(context).scale(
        Theme.of(context)
            .elevatedButtonTheme
            .style!
            .textStyle!
            .resolve({})!.fontSize!);
    final double flagWidth = flagHeight * 2;

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
      if (locale.countryCode != null) localeData.add(locale.countryCode!);

      buttons.addAll([
        ElevatedButton.icon(
          onPressed: () {
            EzConfig.setStringList(localeKey, localeData);
            setState(() {
              currLocale = locale;
            });
            popScreen(context: context, result: locale);
          },
          icon: _flag(locale),
          label: Text(
            LocaleNames.of(context)!.nameOf(locale.languageCode)!,
            textAlign: TextAlign.center,
          ),
        ),
        _buttonSpacer,
      ]);
    });

    return showPlatformDialog(
      context: context,
      builder: (context) => EzAlertDialog(
        title: Text(
          EFUILang.of(context)!.ssLanguages,
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
    return Semantics(
      button: true,
      hint: EFUILang.of(context)!.ssLangSemantics,
      child: ExcludeSemantics(
        child: ElevatedButton.icon(
          onPressed: () => _chooseLocale(context),
          icon: _flag(currLocale),
          label: Text(EFUILang.of(context)!.ssLanguage),
        ),
      ),
    );
  }
}
