/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class TryTip extends StatelessWidget {
  final Widget child;

  const TryTip({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: ezL10n(context).ssTryMe,
      excludeFromSemantics: true,
      child: child,
    );
  }
}

class EzQuickConfig extends StatelessWidget {
  /// Toggle the big buttons quick config
  final bool bigButtons;

  /// Toggle the high visibility quick config
  final bool highVisibility;

  /// Toggle the video game quick config
  final bool videoGame;

  /// Toggle the chalkboard quick config
  final bool chalkboard;

  /// Toggle the fancy pants quick config
  final bool fancyPants;

  /// Optional callback for when the quick config is completed
  final void Function()? onComplete;

  /// [EzElevatedIconButton] for updating the current [Locale]
  /// Opens a [BottomSheet] with a [EzElevatedIconButton] for each supported [Locale]
  const EzQuickConfig({
    super.key,
    this.bigButtons = true,
    this.highVisibility = true,
    this.videoGame = true,
    this.chalkboard = true,
    this.fancyPants = true,
    this.onComplete,
  });

  // Return the build //

  @override
  Widget build(BuildContext context) {
    final EdgeInsets modalPadding = EzInsets.col(EzConfig.get(spacingKey));
    final EFUILang l10n = ezL10n(context);

    return EzElevatedIconButton(
      onPressed: () => showModalBottomSheet(
        context: context,
        builder: (BuildContext modalContext) {
          void onComplete(String configName) {
            Navigator.pop(modalContext);

            ezSnackBar(
              context: context,
              message:
                  '${l10n.ssApplied(configName)} ${kIsWeb ? l10n.ssRestartReminderWeb : l10n.ssRestartReminder}',
            );
          }

          return EzScrollView(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Big buttons
              if (bigButtons)
                Padding(
                  padding: modalPadding,
                  child: EzBigButtonsConfig(
                      onComplete: () => onComplete(l10n.ssBigButtons)),
                ),

              // High visibility
              if (highVisibility)
                Padding(
                  padding: modalPadding,
                  child: EzHighVisibilityConfig(
                      onComplete: () => onComplete(l10n.ssHighVisibility)),
                ),

              // Video game
              if (videoGame)
                Padding(
                  padding: modalPadding,
                  child: EzVideoGameConfig(
                      onComplete: () => onComplete(l10n.ssVideoGame)),
                ),

              // Chalkboard
              if (chalkboard)
                Padding(
                  padding: modalPadding,
                  child: EzChalkboardConfig(
                      onComplete: () => onComplete(l10n.ssChalkboard)),
                ),

              // Fancy pants
              if (fancyPants)
                Padding(
                  padding: modalPadding,
                  child: EzFancyPantsConfig(
                      onComplete: () => onComplete(l10n.ssFancyPants)),
                ),
            ],
          );
        },
      ),
      icon: EzIcon(PlatformIcons(context).edit),
      label: ezL10n(context).ssLoadPreset,
    );
  }
}

class EzBigButtonsConfig extends StatelessWidget {
  final void Function()? onComplete;

  const EzBigButtonsConfig({super.key, this.onComplete});

  @override
  Widget build(BuildContext context) {
    final bool onMobile = isMobile();
    final bool isDark = isDarkTheme(context);
    final EFUILang l10n = ezL10n(context);

    return EzElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(EzConfig.getDefault(paddingKey) * 1.5),
      ),
      onPressed: () async {
        // Reset
        if (isDark) {
          await EzConfig.removeKeys(darkColorKeys.keys.toSet());
          await EzConfig.removeKeys(darkDesignKeys.keys.toSet());
        } else {
          await EzConfig.removeKeys(lightColorKeys.keys.toSet());
          await EzConfig.removeKeys(lightDesignKeys.keys.toSet());
        }
        await EzConfig.removeKeys(globalDesignKeys.keys.toSet());
        await EzConfig.removeKeys(allLayoutKeys.keys.toSet());
        await EzConfig.removeKeys(allTextKeys.keys.toSet());

        // Update text
        await EzConfig.setDouble(iconSizeKey, 25);

        // Update layout
        await EzConfig.setDouble(marginKey, 12.5);
        if (onMobile) {
          await EzConfig.setDouble(paddingKey, 22.5);
          await EzConfig.setDouble(spacingKey, 35.0);
        } else {
          await EzConfig.setDouble(paddingKey, 25.0);
          await EzConfig.setDouble(spacingKey, 40.0);
        }
        await EzConfig.setBool(hideScrollKey, false);

        // Callback
        onComplete?.call();
      },
      text: l10n.ssBigButtons,
    );
  }
}

class EzHighVisibilityConfig extends StatelessWidget {
  final void Function()? onComplete;

  const EzHighVisibilityConfig({super.key, this.onComplete});

  @override
  Widget build(BuildContext context) {
    final bool onMobile = isMobile();
    final bool isDark = isDarkTheme(context);
    final EFUILang l10n = ezL10n(context);
    final Color onSurface = Theme.of(context).colorScheme.onSurface;

    final TextStyle localBody = fuseWithGFont(
      starter: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
        decoration: TextDecoration.none,
        color: onSurface,
        height: 1.75,
        leadingDistribution: TextLeadingDistribution.even,
        letterSpacing: 0.30,
        wordSpacing: 1.25,
      ),
      gFont: atkinsonHyperlegible,
    );

    return EzElevatedButton(
      style: ElevatedButton.styleFrom(
        iconColor: onSurface,
        overlayColor: onSurface,
        side: BorderSide(color: onSurface.withValues(alpha: 0.5)),
        textStyle: localBody,
      ),
      onPressed: () async {
        // Reset //

        if (isDark) {
          await EzConfig.removeKeys(darkColorKeys.keys.toSet());
          await EzConfig.removeKeys(darkDesignKeys.keys.toSet());
        } else {
          await EzConfig.removeKeys(lightColorKeys.keys.toSet());
          await EzConfig.removeKeys(lightDesignKeys.keys.toSet());
        }
        await EzConfig.removeKeys(globalDesignKeys.keys.toSet());
        await EzConfig.removeKeys(allLayoutKeys.keys.toSet());
        await EzConfig.removeKeys(allTextKeys.keys.toSet());

        // Update text //

        // Display
        await EzConfig.setString(displayFontFamilyKey, atkinsonHyperlegible);
        await EzConfig.setDouble(displayFontSizeKey, 50);
        await EzConfig.setBool(displayBoldedKey, false);
        await EzConfig.setBool(displayItalicizedKey, false);
        await EzConfig.setBool(displayUnderlinedKey, false);
        await EzConfig.setDouble(displayFontHeightKey, 1.5);
        await EzConfig.setDouble(displayLetterSpacingKey, 0.30);
        await EzConfig.setDouble(displayWordSpacingKey, 1.25);

        // Headline
        await EzConfig.setString(headlineFontFamilyKey, atkinsonHyperlegible);
        await EzConfig.setDouble(headlineFontSizeKey, 38);
        await EzConfig.setBool(headlineBoldedKey, false);
        await EzConfig.setBool(headlineItalicizedKey, false);
        await EzConfig.setBool(headlineUnderlinedKey, false);
        await EzConfig.setDouble(headlineFontHeightKey, 1.625);
        await EzConfig.setDouble(headlineLetterSpacingKey, 0.30);
        await EzConfig.setDouble(headlineWordSpacingKey, 1.25);

        // Title
        await EzConfig.setString(titleFontFamilyKey, atkinsonHyperlegible);
        await EzConfig.setDouble(titleFontSizeKey, 26);
        await EzConfig.setBool(titleBoldedKey, false);
        await EzConfig.setBool(titleItalicizedKey, false);
        await EzConfig.setBool(titleUnderlinedKey, true);
        await EzConfig.setDouble(titleFontHeightKey, 1.75);
        await EzConfig.setDouble(titleLetterSpacingKey, 0.30);
        await EzConfig.setDouble(titleWordSpacingKey, 1.25);

        // Body
        await EzConfig.setString(bodyFontFamilyKey, atkinsonHyperlegible);
        await EzConfig.setDouble(bodyFontSizeKey, 20);
        await EzConfig.setBool(bodyBoldedKey, false);
        await EzConfig.setBool(bodyItalicizedKey, false);
        await EzConfig.setBool(bodyUnderlinedKey, false);
        await EzConfig.setDouble(bodyFontHeightKey, 1.75);
        await EzConfig.setDouble(bodyLetterSpacingKey, 0.30);
        await EzConfig.setDouble(bodyWordSpacingKey, 1.25);

        // Label
        await EzConfig.setString(labelFontFamilyKey, atkinsonHyperlegible);
        await EzConfig.setDouble(labelFontSizeKey, 16);
        await EzConfig.setBool(labelBoldedKey, false);
        await EzConfig.setBool(labelItalicizedKey, false);
        await EzConfig.setBool(labelUnderlinedKey, false);
        await EzConfig.setDouble(labelFontHeightKey, 1.75);
        await EzConfig.setDouble(labelLetterSpacingKey, 0.30);
        await EzConfig.setDouble(labelWordSpacingKey, 1.25);

        // Icons
        await EzConfig.setDouble(iconSizeKey, 22.0);

        // Update layout //

        await EzConfig.setDouble(marginKey, 12.5);
        if (onMobile) {
          await EzConfig.setDouble(paddingKey, 17.5);
          await EzConfig.setDouble(spacingKey, 30.0);
        } else {
          await EzConfig.setDouble(paddingKey, 20.0);
          await EzConfig.setDouble(spacingKey, 35.0);
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

        // Callback //

        onComplete?.call();
      },
      text: l10n.ssHighVisibility,
      textStyle: localBody,
    );
  }
}

class EzVideoGameConfig extends StatelessWidget {
  final void Function()? onComplete;

  const EzVideoGameConfig({super.key, this.onComplete});

  @override
  Widget build(BuildContext context) {
    final bool onMobile = isMobile();
    final EFUILang l10n = ezL10n(context);

    final TextStyle localBody = fuseWithGFont(
      starter: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
        decoration: TextDecoration.none,
        color: Colors.white,
        height: defaultFontHeight,
        leadingDistribution: TextLeadingDistribution.even,
        letterSpacing: defaultLetterSpacing,
        wordSpacing: defaultWordSpacing,
      ),
      gFont: pressStart2P,
    );

    return EzElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkSurface,
        foregroundColor: Colors.white,
        iconColor: empathEucalyptus,
        overlayColor: empathEucalyptus,
        side: const BorderSide(color: empathEucalyptusDim),
        textStyle: localBody,
        padding: EdgeInsets.all(onMobile ? 22.5 : 25.0),
      ),
      onPressed: () async {
        if (!isDarkTheme(context)) {
          final bool doIt = await showPlatformDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              void onConfirm() => Navigator.of(dialogContext).pop(true);
              void onDeny() => Navigator.of(dialogContext).pop(false);

              late final List<Widget> materialActions;
              late final List<Widget> cupertinoActions;

              (materialActions, cupertinoActions) = ezActionPairs(
                context: context,
                onConfirm: onConfirm,
                confirmIsDestructive: true,
                onDeny: onDeny,
              );

              return EzAlertDialog(
                title: Text(l10n.gAttention, textAlign: TextAlign.center),
                content: Text(l10n.ssDarkOnly, textAlign: TextAlign.center),
                materialActions: materialActions,
                cupertinoActions: cupertinoActions,
                needsClose: false,
              );
            },
          );

          if (!doIt) return;
        }

        // Reset //

        await EzConfig.removeKeys(darkColorKeys.keys.toSet());
        await EzConfig.removeKeys(darkDesignKeys.keys.toSet());
        await EzConfig.removeKeys(globalDesignKeys.keys.toSet());
        await EzConfig.removeKeys(allLayoutKeys.keys.toSet());
        await EzConfig.removeKeys(allTextKeys.keys.toSet());

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

        // Icons
        if (!onMobile) await EzConfig.setDouble(iconSizeKey, 22.0);

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

        // Update colors //

        await EzConfig.setBool(isDarkThemeKey, true);
        await storeColorScheme(
          colorScheme: ezColorScheme(Brightness.dark),
          brightness: Brightness.dark,
        );

        // Callback //

        onComplete?.call();
      },
      text: l10n.ssVideoGame,
      textStyle: localBody,
    );
  }
}

class EzChalkboardConfig extends StatelessWidget {
  final void Function()? onComplete;

  const EzChalkboardConfig({super.key, this.onComplete});

  @override
  Widget build(BuildContext context) {
    const Color chalkboardGreen = Color(0xFF264941);
    final EFUILang l10n = ezL10n(context);

    final TextStyle localBody = fuseWithGFont(
      starter: const TextStyle(
        fontSize: defaultBodySize,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
        decoration: TextDecoration.none,
        color: Colors.white,
        height: defaultFontHeight,
        leadingDistribution: TextLeadingDistribution.even,
        letterSpacing: defaultLetterSpacing,
        wordSpacing: defaultWordSpacing,
      ),
      gFont: fingerPaint,
    );

    return EzElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: chalkboardGreen,
        foregroundColor: Colors.white,
        iconColor: empathSand,
        overlayColor: empathSand,
        side: const BorderSide(color: darkOutline),
        textStyle: localBody,
      ),
      onPressed: () async {
        // Reset //

        await EzConfig.removeKeys(darkColorKeys.keys.toSet());
        await EzConfig.removeKeys(darkDesignKeys.keys.toSet());
        await EzConfig.removeKeys(globalDesignKeys.keys.toSet());
        await EzConfig.removeKeys(allLayoutKeys.keys.toSet());
        await EzConfig.removeKeys(allTextKeys.keys.toSet());

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

        await EzConfig.setBool(isDarkThemeKey, true);
        await storeColorScheme(
          colorScheme: const ColorScheme(
            brightness: Brightness.dark,
            // Primary
            primary: empathSand,
            onPrimary: Colors.black,
            primaryContainer: darkOutline,
            onPrimaryContainer: Colors.black,
            primaryFixed: empathSand,
            primaryFixedDim: empathSand,
            onPrimaryFixed: Colors.black,
            onPrimaryFixedVariant: Colors.black,

            // Secondary
            secondary: Colors.white,
            onSecondary: Colors.black,
            secondaryContainer: Colors.white,
            onSecondaryContainer: Colors.black,
            secondaryFixed: Colors.white,
            secondaryFixedDim: Colors.white,
            onSecondaryFixed: Colors.black,
            onSecondaryFixedVariant: Colors.black,

            // Tertiary
            tertiary: Colors.white,
            onTertiary: Colors.black,
            tertiaryContainer: Colors.white,
            onTertiaryContainer: Colors.black,
            tertiaryFixed: Colors.white,
            tertiaryFixedDim: Colors.white,
            onTertiaryFixed: Colors.black,
            onTertiaryFixedVariant: Colors.black,

            // Error
            error: Colors.red,
            onError: Colors.white,
            errorContainer: Colors.redAccent,
            onErrorContainer: Colors.white,

            // Surface
            surface: chalkboardGreen,
            onSurface: Colors.white,
            surfaceDim: chalkboardGreen,
            surfaceBright: chalkboardGreen,
            surfaceContainerLowest: chalkboardGreen,
            surfaceContainerLow: chalkboardGreen,
            surfaceContainer: chalkboardGreen,
            surfaceContainerHigh: chalkboardGreen,
            surfaceContainerHighest: chalkboardGreen,
            onSurfaceVariant: Colors.white,

            // Misc
            outline: darkOutline,
            outlineVariant: darkOutlineVariant,
            shadow: Colors.transparent,
            scrim: Colors.black,
            inverseSurface: chalkboardGreen,
            onInverseSurface: Colors.white,
            inversePrimary: empathSand,
            surfaceTint: Colors.transparent,
          ),
          brightness: Brightness.dark,
        );

        // Callback //

        onComplete?.call();
      },
      text: l10n.ssChalkboard,
      textStyle: localBody,
    );
  }
}

class EzFancyPantsConfig extends StatelessWidget {
  final void Function()? onComplete;

  const EzFancyPantsConfig({super.key, this.onComplete});

  @override
  Widget build(BuildContext context) {
    final bool onMobile = isMobile();
    final bool isDark = isDarkTheme(context);
    final EFUILang l10n = ezL10n(context);

    final TextStyle localBody = fuseWithGFont(
      starter: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
        decoration: TextDecoration.none,
        color: Theme.of(context).colorScheme.onSurface,
        height: defaultFontHeight,
        leadingDistribution: TextLeadingDistribution.even,
        letterSpacing: defaultLetterSpacing,
        wordSpacing: defaultWordSpacing,
      ),
      gFont: alexBrush,
    );

    return EzElevatedButton(
      style: ElevatedButton.styleFrom(
        iconColor: empathSand,
        overlayColor: empathSand,
        side: const BorderSide(color: empathSandDim),
        textStyle: localBody,
        padding: EdgeInsets.all(onMobile ? 15 : 17.5),
      ),
      onPressed: () async {
        // Reset //

        if (isDark) {
          await EzConfig.removeKeys(darkColorKeys.keys.toSet());
          await EzConfig.removeKeys(darkDesignKeys.keys.toSet());
        } else {
          await EzConfig.removeKeys(lightColorKeys.keys.toSet());
          await EzConfig.removeKeys(lightDesignKeys.keys.toSet());
        }
        await EzConfig.removeKeys(globalDesignKeys.keys.toSet());
        await EzConfig.removeKeys(allLayoutKeys.keys.toSet());
        await EzConfig.removeKeys(allTextKeys.keys.toSet());

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

        await EzConfig.setDouble(paddingKey, onMobile ? 15 : 17.5);

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
          await EzConfig.setInt(lightSecondaryContainerKey, empathPurpleDimHex);
          await EzConfig.setInt(lightOnSecondaryContainerKey, whiteHex);
        }

        // Callback //

        onComplete?.call();
      },
      text: l10n.ssFancyPants,
      textStyle: localBody,
    );
  }
}
