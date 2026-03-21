/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../empathetech_flutter_ui.dart';

/// Opens an [ezModal] with links to each of the sub-settings pages and a common setting from that page
Future<void> openEzFavorites({
  required BuildContext context,
  required void Function() onComplete,
  required String colorSettingsPath,
  required String designSettingsPath,
  required String layoutSettingsPath,
  required String textSettingsPath,
  required String appName,
  required String? androidPackage,
  required Set<String> saveSkip,
  required Set<String> resetSkip,
}) async {
  final bool cURL = ezUrlCheck(colorSettingsPath);
  final bool dURL = ezUrlCheck(designSettingsPath);
  final bool lURL = ezUrlCheck(layoutSettingsPath);
  final bool tURL = ezUrlCheck(textSettingsPath);

  await ezModal(
    context: context,
    builder: (BuildContext mContext) => EzScrollView(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        EzLink(
          'Global settings', // TODO: l10n
          url: cURL ? Uri.parse(colorSettingsPath) : null,
          onTap: cURL ? null : () => context.goNamed(colorSettingsPath),
          hint: EzConfig.l10n.gOpenLink,
        ),
        EzConfig.spacer,

        // Global settings
        EzScrollView(
          mainAxisSize: MainAxisSize.min,
          scrollDirection: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.center,
          showScrollHint: true,
          children: <Widget>[
            EzThemeModeSwitch(onComplete),
          ],
        ),

        // Color settings
        EzDivider(
          title: EzLink(
            EzConfig.l10n.csPageTitle,
            url: cURL ? Uri.parse(colorSettingsPath) : null,
            onTap: cURL ? null : () => context.goNamed(colorSettingsPath),
            hint: EzConfig.l10n.gOpenLink,
          ),
        ),
        EzScrollView(
          mainAxisSize: MainAxisSize.min,
          scrollDirection: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.center,
          showScrollHint: true,
          children: <Widget>[
            EzMonoChromeColorsSetting(onComplete, both: false),
          ],
        ),

        // Design settings
        EzDivider(
          title: EzLink(
            EzConfig.l10n.dsPageTitle,
            url: dURL ? Uri.parse(designSettingsPath) : null,
            onTap: dURL ? null : () => context.goNamed(designSettingsPath),
            hint: EzConfig.l10n.gOpenLink,
          ),
        ),
        EzScrollView(
          mainAxisSize: MainAxisSize.min,
          scrollDirection: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.center,
          showScrollHint: true,
          children: <Widget>[
            EzConfig.isDark
                ? EzImageSetting(
                    onComplete,
                    configKey: darkBackgroundImageKey,
                    label: EzConfig.l10n.dsBackgroundImg.replaceAll(' ', '\n'),
                    updateBrightness: Brightness.dark,
                  )
                : EzImageSetting(
                    onComplete,
                    configKey: lightBackgroundImageKey,
                    label: EzConfig.l10n.dsBackgroundImg.replaceAll(' ', '\n'),
                    updateBrightness: Brightness.light,
                  ),
          ],
        ),

        // Layout settings
        EzDivider(
          title: EzLink(
            EzConfig.l10n.lsPageTitle,
            url: lURL ? Uri.parse(layoutSettingsPath) : null,
            onTap: lURL ? null : () => context.goNamed(layoutSettingsPath),
            hint: EzConfig.l10n.gOpenLink,
          ),
        ),
        EzScrollView(
          mainAxisSize: MainAxisSize.min,
          scrollDirection: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.center,
          showScrollHint: true,
          children: <Widget>[
            // Show back FAB
            EzSwitchPair(
              valueKey:
                  EzConfig.isDark ? darkShowBackFABKey : lightShowBackFABKey,
              afterChanged: (_) async => await EzConfig.rebuildUI(onComplete),
              text: EzConfig.l10n.lsShowBack,
            ),
            EzConfig.rowSpacer,

            // Show scroll
            EzSwitchPair(
              valueKey:
                  EzConfig.isDark ? darkShowScrollKey : lightShowScrollKey,
              afterChanged: (_) async => await EzConfig.rebuildUI(onComplete),
              text: EzConfig.l10n.lsShowScroll,
            ),
          ],
        ),

        // Text settings
        EzDivider(
          title: EzLink(
            EzConfig.l10n.tsPageTitle,
            url: tURL ? Uri.parse(textSettingsPath) : null,
            onTap: tURL ? null : () => context.goNamed(textSettingsPath),
            hint: EzConfig.l10n.gOpenLink,
          ),
        ),
        EzScrollView(
          mainAxisSize: MainAxisSize.min,
          scrollDirection: Axis.horizontal,
          reverseHands: true,
          mainAxisAlignment: MainAxisAlignment.center,
          showScrollHint: true,
          children: <Widget>[
            // Icon size
            const EzIconSizeSetting(updateBoth: false),
            EzConfig.rowSpacer,

            // Font family
            Tooltip(
              message: EzConfig.l10n.tsFontFamily,
              child: EzDropdownMenu<String>(
                widthEntries: <String>[fingerPaint],
                textStyle: EzConfig.styles.bodyLarge,
                dropdownMenuEntries: googleStyles.entries
                    .map((MapEntry<String, TextStyle> entry) =>
                        DropdownMenuEntry<String>(
                          value: entry.key,
                          label: ezCamelToTitle(entry.key),
                          style: TextButton.styleFrom(textStyle: entry.value),
                        ))
                    .toList(),
                enableSearch: false,
                initialSelection: EzConfig.styles.bodyLarge?.fontFamily ??
                    EzConfig.getDefault(EzConfig.isDark
                        ? darkBodyFontFamilyKey
                        : lightBodyFontFamilyKey),
                onSelected: (String? fontFamily) async {
                  if (fontFamily == null) return;

                  if (EzConfig.isDark) {
                    await EzConfig.setString(
                        darkDisplayFontFamilyKey, fontFamily);
                    await EzConfig.setString(
                        darkHeadlineFontFamilyKey, fontFamily);
                    await EzConfig.setString(
                        darkTitleFontFamilyKey, fontFamily);
                    await EzConfig.setString(darkBodyFontFamilyKey, fontFamily);
                    await EzConfig.setString(
                        darkLabelFontFamilyKey, fontFamily);
                  } else {
                    await EzConfig.setString(
                        lightDisplayFontFamilyKey, fontFamily);
                    await EzConfig.setString(
                        lightHeadlineFontFamilyKey, fontFamily);
                    await EzConfig.setString(
                        lightTitleFontFamilyKey, fontFamily);
                    await EzConfig.setString(
                        lightBodyFontFamilyKey, fontFamily);
                    await EzConfig.setString(
                        lightLabelFontFamilyKey, fontFamily);
                  }

                  await EzConfig.rebuildUI(onComplete);
                },
              ),
            ),
            EzConfig.rowSpacer,

            EzTextBackground(
              EzFontDoubleQuickSetting(),
              borderRadius: ezPillEdge,
            ),
          ],
        ),
        EzConfig.divider,

        // Global scroll II
        EzScrollView(
          mainAxisSize: MainAxisSize.min,
          scrollDirection: Axis.horizontal,
          reverseHands: true,
          mainAxisAlignment: MainAxisAlignment.center,
          showScrollHint: true,
          children: <Widget>[
            // Reset config
            EzResetButton(
              onComplete,
              appName: appName,
              resetBoth: false,
              saveSkip: saveSkip,
              resetSkip: resetSkip,
            ),
            EzConfig.rowSpacer,

            // Load config
            EzElevatedIconButton(
              onPressed: () => ezConfigLoader(context),
              icon: const Icon(Icons.upload),
              label: EzConfig.l10n.ssLoadConfig,
            ),
            EzConfig.rowSpacer,

            // Save config
            EzElevatedIconButton(
              onPressed: () => EzConfig.saveConfig(
                context,
                appName: appName,
                androidPackage: androidPackage,
                skip: saveSkip,
              ),
              icon: const Icon(Icons.save),
              label: EzConfig.l10n.ssSaveConfig,
            ),
          ],
        ),
        EzSpacer(space: EzConfig.spargin),
      ],
    ),
  );

  if (EzConfig.needsRebuild) await EzConfig.rebuildUI(onComplete);
}
