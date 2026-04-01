/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzLocaleSetting extends StatefulWidget {
  /// [EzConfig.rebuildLocale] passthrough
  final void Function() onComplete;

  /// Override [EFUILang.supportedLocales] default
  final List<Locale>? locales;

  /// [Locale]s to [skip]
  /// Works for both default and custom [locales]
  final Set<Locale>? skip;

  /// Set of [String] language codes you'd like to protest
  final Set<String> inDistress;

  /// [EzElevatedIconButton] for updating the current [Locale]
  /// Opens a [BottomSheet] with a [EzElevatedIconButton] for each supported [Locale]
  const EzLocaleSetting(
    this.onComplete, {
    super.key,
    this.locales,
    this.skip,
    this.inDistress = const <String>{'US'},
  });

  @override
  State<EzLocaleSetting> createState() => _LocaleSettingState();
}

class _LocaleSettingState extends State<EzLocaleSetting> {
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

  late final List<Locale> locales;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: EzConfig.l10n.ssLanguage,
      button: true,
      hint: EzConfig.l10n.ssLangHint,
      child: ExcludeSemantics(
        child: EzElevatedIconButton(
          onPressed: () => ezModal(
            context: context,
            builder: (BuildContext mContext) => EzScrollView(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: locales
                      .map(
                        (Locale locale) => Padding(
                          padding: EzInsets.wrap(EzConfig.spacing),
                          child: EzElevatedIconButton(
                            onPressed: () async {
                              // Check for no change
                              if (locale == EzConfig.locale) {
                                Navigator.of(mContext).pop();
                                return;
                              }

                              // Gather && set data
                              final List<String> localeData = <String>[
                                locale.languageCode
                              ];
                              if (locale.countryCode != null) {
                                localeData.add(locale.countryCode!);
                              }
                              await EzConfig.setStringList(
                                appLocaleKey,
                                localeData,
                              );

                              // Refresh the UI
                              await EzConfig.rebuildLocale(widget.onComplete);
                            },
                            icon: ezFlag(
                              locale,
                              inDistress: widget.inDistress
                                  .contains(locale.countryCode),
                            ),
                            label: ezLocaleName(locale, mContext),
                            labelPadding: false,
                          ),
                        ),
                      )
                      .toList(),
                ),
                EzConfig.spacer,
              ],
            ),
          ),
          icon: ezFlag(
            EzConfig.locale,
            inDistress: widget.inDistress.contains(EzConfig.locale.countryCode),
          ),
          label: EzConfig.l10n.ssLanguage,
          labelPadding: false,
        ),
      ),
    );
  }
}
