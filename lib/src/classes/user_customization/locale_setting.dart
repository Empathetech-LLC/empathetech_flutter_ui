/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
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
  const EzLocaleSetting({super.key, this.locales});

  @override
  State<EzLocaleSetting> createState() => _LocaleSettingState();
}

class _LocaleSettingState extends State<EzLocaleSetting> {
  // Gather the theme data //

  late Locale currLocale = Localizations.localeOf(context);

  late final EzSpacer spacer = EzSpacer(EzConfig.get(spacingKey));

  late final EFUILang l10n = EFUILang.of(context)!;

  // Gather the list items //

  CountryFlag _flag(Locale locale) {
    final Locale flagLocale = locale;

    final double flagHeight = MediaQuery.textScalerOf(context).scale(
      Theme.of(context)
          .elevatedButtonTheme
          .style!
          .textStyle!
          .resolve(<MaterialState>{})!.fontSize!,
    );
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
    final List<Locale> locales = (widget.locales == null)
        ? EFUILang.supportedLocales
        : EFUILang.supportedLocales + widget.locales!;

    final List<Widget> buttons = <Widget>[];

    for (final Locale locale in locales) {
      final List<String> localeData = <String>[locale.languageCode];
      if (locale.countryCode != null) localeData.add(locale.countryCode!);

      buttons.addAll(<Widget>[
        ElevatedButton.icon(
          onPressed: () {
            EzConfig.setStringList(localeKey, localeData);
            setState(() {
              currLocale = locale;
            });
            Navigator.of(context).pop(locale);
          },
          icon: _flag(locale),
          label: Text(
            LocaleNames.of(context)!.nameOf(locale.languageCode)!,
            textAlign: TextAlign.center,
          ),
        ),
        spacer,
      ]);
    }

    return showPlatformDialog(
      context: context,
      builder: (BuildContext context) => EzAlertDialog(
        title: Text(
          l10n.ssLanguages,
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
      hint: l10n.ssLangSemantics,
      child: ExcludeSemantics(
        child: ElevatedButton.icon(
          onPressed: () => _chooseLocale(context),
          icon: _flag(currLocale),
          label: Text(l10n.ssLanguage),
        ),
      ),
    );
  }
}
