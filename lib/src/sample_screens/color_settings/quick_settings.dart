/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class QuickColorSettings extends StatelessWidget {
  final void Function() onUpdate;
  final List<Widget>? quickHeader;
  final List<Widget>? quickFooter;
  final Widget resetSpacer;
  final String appName;
  final String? androidPackage;
  final Set<String>? resetExtraDark;
  final Set<String>? resetExtraLight;
  final Set<String>? resetSkip;
  final Set<String>? saveSkip;

  const QuickColorSettings({
    super.key,
    required this.onUpdate,
    required this.quickHeader,
    required this.quickFooter,
    required this.resetSpacer,
    required this.appName,
    required this.androidPackage,
    required this.resetExtraDark,
    required this.resetExtraLight,
    required this.resetSkip,
    required this.saveSkip,
  });

  @override
  Widget build(BuildContext context) => EzCol(children: <Widget>[
        if (quickHeader != null) ...quickHeader!,

        // From image
        Semantics(
          label: EzConfig.l10n.csSchemeBase.replaceAll('\n', ' '),
          value: EzConfig.l10n.gOptional,
          button: true,
          hint: EzConfig.l10n.csFromImage,
          child: ExcludeSemantics(
            child: EzImageSetting(
              onUpdate,
              configKey: EzConfig.isDark ? darkColorSchemeImageKey : lightColorSchemeImageKey,
              label: EzConfig.l10n.csSchemeBase,
              allowThemeUpdate: true,
              showEditor: false,
              showFitOption: false,
            ),
          ),
        ),
        EzConfig.separator,

        // High contrast
        EzHighContrastColorsSetting(onUpdate),
        EzConfig.spacer,

        // MonoChrome
        EzMonoChromeColorsSetting(onUpdate),

        // Additional settings
        if (quickFooter != null) ...quickFooter!,

        // Local reset
        resetSpacer,
        EzResetButton(
          all: false,
          onUpdate,
          androidPackage: androidPackage,
          appName: appName,
          dynamicTitle: () => EzConfig.l10n.csReset(ezThemeString(true)),
          resetSkip: resetSkip,
          onConfirm: () async {
            if (EzConfig.updateBoth) {
              await EzConfig.removeKeys(allColorKeys.keys.toSet());
              if (resetExtraDark != null) {
                await EzConfig.removeKeys(resetExtraDark!);
              }
              if (resetExtraLight != null) {
                await EzConfig.removeKeys(resetExtraLight!);
              }
            } else {
              if (EzConfig.isDark) {
                await EzConfig.removeKeys(darkColorKeys.keys.toSet());
                if (resetExtraDark != null) {
                  await EzConfig.removeKeys(resetExtraDark!);
                }
              } else {
                await EzConfig.removeKeys(lightColorKeys.keys.toSet());
                if (resetExtraLight != null) {
                  await EzConfig.removeKeys(resetExtraLight!);
                }
              }
            }
          },
        ),
        EzConfig.separator,
      ]);
}
