/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

class EzLocaleSetting extends StatefulWidget {
  /// Override [EFUILang.supportedLocales] default
  final List<Locale>? locales;

  /// [EzElevatedIconButton] for updating the current [Locale]
  /// Opens a [BottomSheet] with a [EzElevatedIconButton] for each supported [Locale]
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

  // Gather the build data  //

  late EFUILang l10n = EFUILang.of(context)!;
  late Locale currLocale = Localizations.localeOf(context);

  Widget flag(Locale lang) => (lang.countryCode == null)
      ? Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: primary),
          ),
          child: CountryFlag.fromLanguageCode(
            lang.languageCode,
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
            lang.countryCode!,
            shape: const Circle(),
            width: padding * 2 + margin,
          ),
        );

  // Return the build //

  @override
  Widget build(BuildContext context) {
    final List<Locale> locales = widget.locales ?? EFUILang.supportedLocales;

    return Semantics(
      label: l10n.ssLanguage,
      button: true,
      hint: l10n.ssLangHint,
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
                                .nameOf(locale.languageCode) ??
                            'Language',
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
