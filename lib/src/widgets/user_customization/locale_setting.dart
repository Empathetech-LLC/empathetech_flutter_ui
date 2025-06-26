/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

class EzLocaleSetting extends StatefulWidget {
  /// Override [EFUILang.supportedLocales] default
  final List<Locale>? locales;

  /// [Locale]s to [skip]
  /// Works for both default and custom [locales]
  final Set<Locale>? skip;

  /// [protest] to show a flipped flag
  final bool protest;

  /// Set of [String] language codes you'd like to (optionally) [protest]
  final Set<String> inDistress;

  /// [EzElevatedIconButton] for updating the current [Locale]
  /// Opens a [BottomSheet] with a [EzElevatedIconButton] for each supported [Locale]
  const EzLocaleSetting({
    super.key,
    this.locales,
    this.skip,
    this.protest = false,
    this.inDistress = const <String>{'US'},
  });

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

  late EFUILang l10n = ezL10n(context);

  late final List<Locale> locales;
  late Locale currLocale = Localizations.localeOf(context);

  Widget flag(Locale lang) {
    late final Widget flag;

    // Fix language code != flag code
    switch (lang.languageCode) {
      case 'fil':
        lang = const Locale('tl'); // Filipino to Tagalog
        break;

      default:
        break;
    }

    flag = (lang.countryCode == null)
        ? CountryFlag.fromLanguageCode(
            lang.languageCode,
            shape: const Circle(),
            width: padding * 2 + margin,
          )
        : CountryFlag.fromCountryCode(
            lang.countryCode!,
            shape: const Circle(),
            width: padding * 2 + margin,
          );

    return (widget.protest && widget.inDistress.contains(lang.countryCode))
        ? Transform.rotate(angle: pi, child: flag)
        : flag;
  }

  // Create custom functions //

  String localeName(Locale locale) {
    final String? supported =
        LocaleNames.of(context)!.nameOf(locale.languageCode);

    if (supported != null) return supported;

    switch (locale) {
      case filipino:
        return 'Filipino';
      case creole:
        return 'Creole';
      default:
        return 'Language';
    }
  }

  // Init //

  @override
  void initState() {
    super.initState();
    locales = List<Locale>.from(widget.locales ?? EFUILang.supportedLocales);

    if (widget.skip != null && widget.skip!.isNotEmpty) {
      locales.removeWhere(
        (final Locale locale) => widget.skip!.contains(locale),
      );
    }
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
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

                          try {
                            l10n = await EFUILang.delegate.load(locale);
                          } catch (_) {
                            l10n = EzConfig.l10nFallback;
                          }

                          setState(() {});

                          // Close modal
                          if (modalContext.mounted) {
                            Navigator.of(modalContext).pop(locale);
                          }
                        },
                        icon: flag(locale),
                        label: localeName(locale),
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
