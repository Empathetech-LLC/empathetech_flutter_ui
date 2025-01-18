/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
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

  final double margin = EzConfig.get(marginKey);
  final double padding = EzConfig.get(paddingKey);
  final double spacing = EzConfig.get(spacingKey);

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

  // Return the build //

  @override
  Widget build(BuildContext context) {
    final List<Locale> locales = (widget.locales == null)
        ? EFUILang.supportedLocales
        : EFUILang.supportedLocales + widget.locales!;

    return Semantics(
      label: l10n.ssLanguage,
      button: true,
      hint: 'Activate to change the app language',
      child: ExcludeSemantics(
        child: EzElevatedIconButton(
          onPressed: () => showModalBottomSheet(
            context: context,
            builder: (BuildContext modalContext) => EzScrollView(
              mainAxisSize: MainAxisSize.min,
              children: locales
                  .map(
                    (Locale locale) => Padding(
                      padding: EzInsets.col(spacing),
                      child: EzElevatedIconButton(
                        onPressed: () async {
                          // Gather data
                          final List<String> localeData = <String>[
                            locale.languageCode,
                          ];
                          if (locale.countryCode != null) {
                            localeData.add(locale.countryCode!);
                          }

                          // Set data
                          await EzConfig.setStringList(
                            appLocaleKey,
                            localeData,
                          );
                          currLocale = locale;
                          l10n = await EFUILang.delegate.load(locale);

                          setState(() {});

                          // Close modal
                          if (modalContext.mounted) {
                            Navigator.of(modalContext).pop(locale);
                          }
                        },
                        icon: flag(locale),
                        label: LocaleNames.of(context)!
                            .nameOf(locale.languageCode)!,
                        labelPadding: false,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          icon: flag(currLocale),
          label: l10n.ssLanguage,
          labelPadding: false,
        ),
      ),
    );
  }
}
