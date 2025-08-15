/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

// TODO: l10n things

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzQuickConfig extends StatelessWidget {
  /// Context passthrough
  /// So this can be Stateless, and the buttons can be accessed externally
  final BuildContext context;

  /// Toggle the low mobility quick config
  final bool lowMobility;

  /// Toggle the low vision quick config
  final bool lowVision;

  /// Toggle the video game quick config
  final bool videoGame;

  /// Toggle the chalkboard quick config
  final bool chalkboard;

  /// Toggle the fancy pants quick config
  final bool fancyPants;

  /// Reset the theme before applying the quick config
  final bool resetFirst;

  /// [EzElevatedIconButton] for updating the current [Locale]
  /// Opens a [BottomSheet] with a [EzElevatedIconButton] for each supported [Locale]
  const EzQuickConfig({
    super.key,
    required this.context,
    this.lowMobility = true,
    this.lowVision = true,
    this.videoGame = true,
    this.chalkboard = true,
    this.fancyPants = true,
    this.resetFirst = true,
  });

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> reloadSnack(
    String message,
  ) =>
      ezSnackBar(context: context, message: message);

  Widget get lowMobilityConfig {
    final EFUILang l10n = ezL10n(context);
    final bool onMobile = isMobile();
    final bool isDark = isDarkTheme(context);

    return Tooltip(
      message: l10n.ssTryMe,
      excludeFromSemantics: true,
      child: EzTextIconButton(
        onPressed: () async {
          // Reset (conditional)
          if (resetFirst) {
            await EzConfig.removeKeys(textStyleKeys.keys.toSet());
            await EzConfig.removeKeys(layoutKeys.keys.toSet());
            await EzConfig.removeKeys(
              isDark ? darkColorKeys.toSet() : lightColorKeys.toSet(),
            );
            await EzConfig.removeKeys(allImageKeys.keys.toSet());
          }

          // Update text
          await EzConfig.setDouble(iconSizeKey, defaultIconSize * 1.5);

          // Update layout
          await EzConfig.setDouble(marginKey, defaultMargin * 1.5);
          if (onMobile) {
            await EzConfig.setDouble(paddingKey, defaultMobilePadding * 1.5);
            await EzConfig.setDouble(spacingKey, defaultMobileSpacing * 2.0);
          } else {
            await EzConfig.setDouble(paddingKey, defaultDesktopPadding * 1.5);
            await EzConfig.setDouble(spacingKey, defaultDesktopSpacing * 2.0);
          }
          await EzConfig.setBool(hideScrollKey, false);

          // Prompt for reload
          reloadSnack(l10n.ssSettingsGuideWeb.split('\n')[0]);
        },
        icon: EzIcon(Icons.touch_app),
        label: l10n.ssAccessible,
      ),
    );
  }

  Widget get lowVisionConfig {
    final EFUILang l10n = ezL10n(context);
    final bool onMobile = isMobile();
    final bool isDark = isDarkTheme(context);

    return Tooltip(
      message: l10n.ssTryMe,
      excludeFromSemantics: true,
      child: EzTextIconButton(
        onPressed: () async {
          // Reset (conditional) //
          if (resetFirst) {
            await EzConfig.removeKeys(textStyleKeys.keys.toSet());
            await EzConfig.removeKeys(layoutKeys.keys.toSet());
            await EzConfig.removeKeys(
              isDark ? darkColorKeys.toSet() : lightColorKeys.toSet(),
            );
            await EzConfig.removeKeys(allImageKeys.keys.toSet());
          }

          // Update text //

          // Display
          await EzConfig.setString(displayFontFamilyKey, atkinsonHyperlegible);
          await EzConfig.setDouble(
            displayFontSizeKey,
            defaultDisplaySize * 1.2,
          );
          await EzConfig.setBool(displayBoldedKey, false);
          await EzConfig.setBool(displayItalicizedKey, false);
          await EzConfig.setBool(displayUnderlinedKey, false);
          await EzConfig.setDouble(
            displayFontHeightKey,
            defaultFontHeight,
          );
          await EzConfig.setDouble(
            displayLetterSpacingKey,
            defaultLetterSpacing * 1.1,
          );
          await EzConfig.setDouble(
            displayWordSpacingKey,
            defaultWordSpacing * 1.2,
          );

          // Headline
          await EzConfig.setString(headlineFontFamilyKey, atkinsonHyperlegible);
          await EzConfig.setDouble(
            headlineFontSizeKey,
            defaultHeadlineSize * 1.2,
          );
          await EzConfig.setBool(headlineBoldedKey, false);
          await EzConfig.setBool(headlineItalicizedKey, false);
          await EzConfig.setBool(headlineUnderlinedKey, false);
          await EzConfig.setDouble(
            headlineFontHeightKey,
            defaultFontHeight * 1.1,
          );
          await EzConfig.setDouble(
            headlineLetterSpacingKey,
            defaultLetterSpacing * 1.1,
          );
          await EzConfig.setDouble(
            headlineWordSpacingKey,
            defaultWordSpacing * 1.2,
          );

          // Title
          await EzConfig.setString(titleFontFamilyKey, atkinsonHyperlegible);
          await EzConfig.setDouble(
            titleFontSizeKey,
            defaultTitleSize * 1.2,
          );
          await EzConfig.setBool(titleBoldedKey, true);
          await EzConfig.setBool(titleItalicizedKey, false);
          await EzConfig.setBool(titleUnderlinedKey, false);
          await EzConfig.setDouble(
            titleFontHeightKey,
            defaultFontHeight * 1.2,
          );
          await EzConfig.setDouble(
            titleLetterSpacingKey,
            defaultLetterSpacing * 1.1,
          );
          await EzConfig.setDouble(
            titleWordSpacingKey,
            defaultWordSpacing * 1.2,
          );

          // Body
          await EzConfig.setString(bodyFontFamilyKey, atkinsonHyperlegible);
          await EzConfig.setDouble(
            bodyFontSizeKey,
            defaultBodySize * 1.2,
          );
          await EzConfig.setBool(bodyBoldedKey, false);
          await EzConfig.setBool(bodyItalicizedKey, false);
          await EzConfig.setBool(bodyUnderlinedKey, false);
          await EzConfig.setDouble(
            bodyFontHeightKey,
            defaultFontHeight * 1.2,
          );
          await EzConfig.setDouble(
            bodyLetterSpacingKey,
            defaultLetterSpacing * 1.1,
          );
          await EzConfig.setDouble(
            bodyWordSpacingKey,
            defaultWordSpacing * 1.2,
          );

          // Label
          await EzConfig.setString(labelFontFamilyKey, atkinsonHyperlegible);
          await EzConfig.setDouble(
            labelFontSizeKey,
            defaultLabelSize * 1.2,
          );
          await EzConfig.setBool(labelBoldedKey, false);
          await EzConfig.setBool(labelItalicizedKey, false);
          await EzConfig.setBool(labelUnderlinedKey, false);
          await EzConfig.setDouble(
            labelFontHeightKey,
            defaultFontHeight * 1.2,
          );
          await EzConfig.setDouble(
            labelLetterSpacingKey,
            defaultLetterSpacing * 1.1,
          );
          await EzConfig.setDouble(
            labelWordSpacingKey,
            defaultWordSpacing * 1.2,
          );

          await EzConfig.setDouble(iconSizeKey, defaultIconSize * 1.1);

          // Update layout //

          await EzConfig.setDouble(marginKey, defaultMargin * 1.2);
          if (onMobile) {
            await EzConfig.setDouble(paddingKey, defaultMobilePadding);
            await EzConfig.setDouble(spacingKey, defaultMobileSpacing * 1.2);
          } else {
            await EzConfig.setDouble(paddingKey, defaultDesktopPadding);
            await EzConfig.setDouble(spacingKey, defaultDesktopSpacing * 1.2);
          }
          await EzConfig.setBool(hideScrollKey, true);

          // Update colors //

          if (isDark) {
            await storeColorScheme(
              colorScheme: ezHighContrastDark,
              brightness: Brightness.dark,
            );
          } else {
            await storeColorScheme(
              colorScheme: ezHighContrastLight,
              brightness: Brightness.light,
            );
          }

          // Prompt for reload //

          reloadSnack(l10n.ssSettingsGuideWeb.split('\n')[0]);
        },
        icon: EzIcon(Icons.contrast),
        label: 'Low vision', // Is this still in dotnet l10n?
      ),
    );
  }

  Widget get videoGameConfig {
    final EFUILang l10n = ezL10n(context);
    final bool onMobile = isMobile();
    final bool isDark = isDarkTheme(context);

    return Tooltip(
      message: l10n.ssTryMe,
      excludeFromSemantics: true,
      child: EzTextIconButton(
        onPressed: () async {
          // Reset (conditional) //

          if (resetFirst) {
            await EzConfig.removeKeys(textStyleKeys.keys.toSet());
            await EzConfig.removeKeys(layoutKeys.keys.toSet());
            await EzConfig.removeKeys(
              isDark ? darkColorKeys.toSet() : lightColorKeys.toSet(),
            );
            await EzConfig.removeKeys(allImageKeys.keys.toSet());
          }

          // Update text //

          // Display
          await EzConfig.setString(displayFontFamilyKey, pressStart2P);
          await EzConfig.setDouble(displayFontSizeKey, 30.0);
          await EzConfig.setBool(displayBoldedKey, false);
          await EzConfig.setBool(displayItalicizedKey, false);

          // Headline
          await EzConfig.setString(headlineFontFamilyKey, pressStart2P);
          await EzConfig.setDouble(headlineFontSizeKey, 24.0);
          await EzConfig.setBool(headlineBoldedKey, false);
          await EzConfig.setBool(headlineItalicizedKey, false);

          // Title
          await EzConfig.setString(titleFontFamilyKey, pressStart2P);
          await EzConfig.setDouble(titleFontSizeKey, 18.0);
          await EzConfig.setBool(titleBoldedKey, false);
          await EzConfig.setBool(titleItalicizedKey, false);

          // Body
          await EzConfig.setString(bodyFontFamilyKey, pressStart2P);
          await EzConfig.setDouble(bodyFontSizeKey, 14.0);
          await EzConfig.setBool(bodyBoldedKey, false);
          await EzConfig.setBool(bodyItalicizedKey, false);

          // Label
          await EzConfig.setString(labelFontFamilyKey, pressStart2P);
          await EzConfig.setDouble(labelFontSizeKey, 12.0);
          await EzConfig.setBool(labelBoldedKey, false);
          await EzConfig.setBool(labelItalicizedKey, false);

          // Update layout //

          if (onMobile) {
            await EzConfig.setDouble(marginKey, 10.0);
            await EzConfig.setDouble(paddingKey, 22.5);
            await EzConfig.setDouble(spacingKey, 30.0);
          } else {
            await EzConfig.setDouble(marginKey, 12.5);
            await EzConfig.setDouble(paddingKey, 25.0);
            await EzConfig.setDouble(spacingKey, 35.0);
          }

          await EzConfig.setDouble(iconSizeKey, defaultIconSize * 1.1);

          // Update colors //

          await storeColorScheme(
            colorScheme: ezColorScheme(Brightness.dark),
            brightness: isDark ? Brightness.dark : Brightness.light,
          );

          // Prompt for reload //

          reloadSnack(l10n.ssSettingsGuideWeb.split('\n')[0]);
        },
        icon: EzIcon(Icons.contrast),
        label: 'Video game',
      ),
    );
  }

  Widget get chalkboardConfig {
    final EFUILang l10n = ezL10n(context);
    final bool isDark = isDarkTheme(context);

    return Tooltip(
      message: l10n.ssTryMe,
      excludeFromSemantics: true,
      child: EzTextIconButton(
        onPressed: () async {
          // Reset (conditional) //
          if (resetFirst) {
            await EzConfig.removeKeys(textStyleKeys.keys.toSet());
            await EzConfig.removeKeys(layoutKeys.keys.toSet());
            await EzConfig.removeKeys(
              isDark ? darkColorKeys.toSet() : lightColorKeys.toSet(),
            );
            await EzConfig.removeKeys(allImageKeys.keys.toSet());
          }

          // Update text //

          // Display
          await EzConfig.setString(displayFontFamilyKey, fingerPaint);
          await EzConfig.setBool(displayItalicizedKey, false);

          // Headline
          await EzConfig.setString(headlineFontFamilyKey, fingerPaint);
          await EzConfig.setBool(headlineItalicizedKey, false);

          // Title
          await EzConfig.setString(titleFontFamilyKey, fingerPaint);
          await EzConfig.setBool(titleItalicizedKey, false);

          // Body
          await EzConfig.setString(bodyFontFamilyKey, fingerPaint);
          await EzConfig.setBool(bodyItalicizedKey, false);

          // Label
          await EzConfig.setString(labelFontFamilyKey, fingerPaint);
          await EzConfig.setBool(labelItalicizedKey, false);

          // Update colors //

          const int chalkboardGreen = 0xFF264941;
          if (isDark) {
            await storeColorScheme(
              colorScheme: ezHighContrastDark,
              brightness: Brightness.dark,
            );

            await EzConfig.setInt(darkErrorKey, whiteHex);
            await EzConfig.setInt(darkPrimaryKey, empathSandHex);
            await EzConfig.setInt(darkOnPrimaryKey, blackHex);
            await EzConfig.setInt(darkPrimaryContainerKey, empathSandDimHex);
            await EzConfig.setInt(darkOnPrimaryContainerKey, blackHex);
            await EzConfig.setInt(darkShadowKey, transparentHex);
            await EzConfig.setInt(darkSurfaceKey, chalkboardGreen);
            await EzConfig.setInt(darkSurfaceContainerKey, chalkboardGreen);
            await EzConfig.setInt(darkSurfaceDimKey, chalkboardGreen);
          } else {
            await storeColorScheme(
              colorScheme: ezHighContrastDark,
              brightness: Brightness.light,
            );

            await EzConfig.setInt(lightErrorKey, whiteHex);
            await EzConfig.setInt(lightPrimaryKey, empathSandHex);
            await EzConfig.setInt(lightOnPrimaryKey, blackHex);
            await EzConfig.setInt(lightPrimaryContainerKey, empathSandDimHex);
            await EzConfig.setInt(lightOnPrimaryContainerKey, blackHex);
            await EzConfig.setInt(lightShadowKey, transparentHex);
            await EzConfig.setInt(lightSurfaceKey, chalkboardGreen);
            await EzConfig.setInt(lightSurfaceContainerKey, chalkboardGreen);
            await EzConfig.setInt(lightSurfaceDimKey, chalkboardGreen);
          }

          // Prompt for reload
          reloadSnack(l10n.ssSettingsGuideWeb.split('\n')[0]);
        },
        icon: EzIcon(Icons.contrast),
        label: 'Chalkboard',
      ),
    );
  }

  Widget get fancyPantsConfig {
    final EFUILang l10n = ezL10n(context);
    final bool onMobile = isMobile();
    final bool isDark = isDarkTheme(context);

    return Tooltip(
      message: l10n.ssTryMe,
      excludeFromSemantics: true,
      child: EzTextIconButton(
        onPressed: () async {
          // Reset (conditional) //

          if (resetFirst) {
            await EzConfig.removeKeys(textStyleKeys.keys.toSet());
            await EzConfig.removeKeys(layoutKeys.keys.toSet());
            await EzConfig.removeKeys(
              isDark ? darkColorKeys.toSet() : lightColorKeys.toSet(),
            );
            await EzConfig.removeKeys(allImageKeys.keys.toSet());
          }

          // Update text //

          await EzConfig.setString(displayFontFamilyKey, alexBrush);
          await EzConfig.setDouble(displayFontSizeKey, 60.0);
          await EzConfig.setBool(displayItalicizedKey, false);

          // Headline
          await EzConfig.setString(headlineFontFamilyKey, alexBrush);
          await EzConfig.setDouble(headlineFontSizeKey, 44.0);
          await EzConfig.setBool(headlineItalicizedKey, false);

          // Title
          await EzConfig.setString(titleFontFamilyKey, alexBrush);
          await EzConfig.setDouble(titleFontSizeKey, 32.0);
          await EzConfig.setBool(titleItalicizedKey, false);

          // Body
          await EzConfig.setString(bodyFontFamilyKey, alexBrush);
          await EzConfig.setDouble(bodyFontSizeKey, 24.0);
          await EzConfig.setBool(bodyItalicizedKey, false);

          // Label
          await EzConfig.setString(labelFontFamilyKey, alexBrush);
          await EzConfig.setDouble(labelFontSizeKey, 20.0);
          await EzConfig.setBool(labelItalicizedKey, false);

          // Update layout //

          await EzConfig.setDouble(
            paddingKey,
            (onMobile ? defaultMobilePadding : defaultDesktopPadding) - 2.5,
          );

          // Update colors //

          if (isDark) {
            await EzConfig.setInt(darkPrimaryKey, empathSandHex);
            await EzConfig.setInt(darkOnPrimaryKey, blackHex);
            await EzConfig.setInt(darkPrimaryContainerKey, empathSandDimHex);
            await EzConfig.setInt(darkOnPrimaryContainerKey, blackHex);

            await EzConfig.setInt(darkSecondaryKey, empathEucalyptusHex);
            await EzConfig.setInt(darkOnSecondaryKey, blackHex);
            await EzConfig.setInt(
                darkSecondaryContainerKey, empathEucalyptusDimHex);
            await EzConfig.setInt(darkOnSecondaryContainerKey, blackHex);
          } else {
            await EzConfig.setInt(lightPrimaryKey, empathSandHex);
            await EzConfig.setInt(lightOnPrimaryKey, blackHex);
            await EzConfig.setInt(lightPrimaryContainerKey, empathSandDimHex);
            await EzConfig.setInt(lightOnPrimaryContainerKey, blackHex);

            await EzConfig.setInt(lightSecondaryKey, empathPurpleHex);
            await EzConfig.setInt(lightOnSecondaryKey, whiteHex);
            await EzConfig.setInt(
                lightSecondaryContainerKey, empathPurpleDimHex);
            await EzConfig.setInt(lightOnSecondaryContainerKey, whiteHex);
          }

          // Prompt for reload //

          reloadSnack(l10n.ssSettingsGuideWeb.split('\n')[0]);
        },
        icon: EzIcon(Icons.contrast),
        label: 'Fancy pants',
      ),
    );
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    final EdgeInsets modalPadding = EzInsets.col(EzConfig.get(spacingKey));

    return EzElevatedIconButton(
      onPressed: () => showModalBottomSheet(
        context: context,
        builder: (BuildContext modalContext) => EzScrollView(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Low mobility
            if (lowMobility) ...<Widget>[
              Padding(padding: modalPadding, child: lowMobilityConfig),
            ],

            // Low vision
            if (lowVision) ...<Widget>[
              Padding(padding: modalPadding, child: lowVisionConfig),
            ],

            // Video game
            if (videoGame) ...<Widget>[
              Padding(padding: modalPadding, child: videoGameConfig),
            ],

            // Chalkboard
            if (chalkboard) ...<Widget>[
              Padding(padding: modalPadding, child: chalkboardConfig),
            ],

            // Fancy pants
            if (fancyPants) ...<Widget>[
              Padding(padding: modalPadding, child: fancyPantsConfig),
            ],
          ],
        ),
      ),
      icon: EzIcon(Icons.save),
      label: 'Load config',
    );
  }
}
