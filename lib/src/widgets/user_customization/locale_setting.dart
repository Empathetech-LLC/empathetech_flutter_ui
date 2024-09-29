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
  /// [EzLocaleSetting] inherits [ElevatedButton] and [AlertDialog] styling from your [ThemeData]
  const EzLocaleSetting({super.key, this.locales});

  @override
  State<EzLocaleSetting> createState() => _LocaleSettingState();
}

class _LocaleSettingState extends State<EzLocaleSetting> {
  // Gather the theme data //

  static const EzSpacer spacer = EzSpacer();

  final double margin = EzConfig.get(marginKey);
  final double padding = EzConfig.get(paddingKey);

  late final Color primary = Theme.of(context).colorScheme.primary;

  late Locale currLocale = Localizations.localeOf(context);

  late EFUILang l10n = EFUILang.of(context)!;

  // Gather the list items //

  Widget flag(Locale locale) {
    final Locale flagLocale = locale;

    return (flagLocale.countryCode == null)
        ? Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: primary),
            ),
            child: CountryFlag.fromLanguageCode(
              flagLocale.languageCode,
              shape: const Circle(),
              width: padding * 2 + margin,
            ),
          )
        : Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: primary),
            ),
            child: CountryFlag.fromCountryCode(
              flagLocale.countryCode!,
              shape: const Circle(),
              width: padding * 2 + margin,
            ),
          );
  }

  /// Builds an [EzAlertDialog] with [Locale]s mapped to a list of [ElevatedButton]s
  Future<dynamic> _chooseLocale(BuildContext context) {
    final List<Locale> locales = (widget.locales == null)
        ? EFUILang.supportedLocales
        : EFUILang.supportedLocales + widget.locales!;

    final List<Widget> buttons = <Widget>[];

    return showPlatformDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        for (final Locale locale in locales) {
          final List<String> localeData = <String>[locale.languageCode];
          if (locale.countryCode != null) localeData.add(locale.countryCode!);

          buttons.addAll(<Widget>[
            EzElevatedButton(
              onPressed: () async {
                await EzConfig.setStringList(localeKey, localeData);
                currLocale = locale;
                l10n = await EFUILang.delegate.load(locale);
                setState(() {});

                if (dialogContext.mounted) {
                  Navigator.of(dialogContext).pop(locale);
                }
              },
              icon: flag(locale),
              label: LocaleNames.of(context)!.nameOf(locale.languageCode)!,
            ),
            spacer,
          ]);
        }

        return EzAlertDialog(
          title: Text(
            l10n.ssLanguages,
            textAlign: TextAlign.center,
          ),
          // Remove the trailing button spacer
          contents: buttons.sublist(0, buttons.length - 1),
        );
      },
    );
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      hint: l10n.ssLangHint,
      child: ExcludeSemantics(
        child: EzElevatedButton(
          onPressed: () => _chooseLocale(context),
          icon: flag(currLocale),
          label: l10n.ssLanguage,
        ),
      ),
    );
  }
}
