/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
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
  /// Toggle the [EzBigButtonsConfig]
  final bool bigButtons;

  /// Toggle the [EzHighVisibilityConfig]
  final bool highVisibility;

  /// Toggle the [EzVideoGameConfig]
  final bool videoGame;

  /// Toggle the [EzChalkboardConfig]
  final bool chalkboard;

  /// Toggle the [EzFancyPantsConfig]
  final bool fancyPants;

  /// Whether to notify [EzThemeProvider]
  final bool notifyTheme;

  /// [EzThemeProvider.rebuild] passthrough
  final void Function()? onNotify;

  /// Opens a [BottomSheet] with [EzElevatedIconButton]s for different [EzConfig] presets
  const EzQuickConfig({
    super.key,
    this.bigButtons = true,
    this.highVisibility = true,
    this.videoGame = true,
    this.chalkboard = true,
    this.fancyPants = true,
    this.notifyTheme = true,
    this.onNotify,
  });

  // Return the build //

  @override
  Widget build(BuildContext context) {
    final void Function()? onComplete =
        notifyTheme ? () => EzConfig.rebuild(onComplete: onNotify) : null;
    final EdgeInsets wrapPadding = EzInsets.wrap(EzConfig.spacing);

    return EzElevatedIconButton(
      onPressed: () => ezModal(
        context: context,
        builder: (BuildContext mContext) => EzScrollView(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                // Big buttons
                if (bigButtons)
                  Padding(
                    padding: wrapPadding,
                    child: EzBigButtonsConfig(onComplete: onComplete),
                  ),

                // High visibility
                if (highVisibility)
                  Padding(
                    padding: wrapPadding,
                    child: EzHighVisibilityConfig(onComplete: onComplete),
                  ),

                // Video game
                if (videoGame)
                  Padding(
                    padding: wrapPadding,
                    child: EzVideoGameConfig(onComplete: onComplete),
                  ),

                // Chalkboard
                if (chalkboard)
                  Padding(
                    padding: wrapPadding,
                    child: EzChalkboardConfig(onComplete: onComplete),
                  ),

                // Fancy pants
                if (fancyPants)
                  Padding(
                    padding: wrapPadding,
                    child: EzFancyPantsConfig(onComplete: onComplete),
                  ),
              ],
            ),
            EzConfig.spacer,
          ],
        ),
      ),
      icon: EzIcon(PlatformIcons(context).edit),
      label: ezL10n(context).ssLoadPreset,
    );
  }
}

class EzBigButtonsConfig extends StatelessWidget {
  /// Only runs if you're using the full widget
  /// Calling [onPressed] does not trigger [onComplete]
  final void Function()? onComplete;

  /// Only modifies the layout settings and [iconSizeKey]
  /// Slight bump to all layout values, for easier tapping
  const EzBigButtonsConfig({super.key, this.onComplete});

  static Future<void> onPressed() async {
    // Conditionally update text
    if (EzConfig.iconSize < 25.0) await EzConfig.setDouble(iconSizeKey, 25.0);

    // Update layout
    await EzConfig.setDouble(marginKey, 12.5);
    if (isMobile()) {
      await EzConfig.setDouble(paddingKey, 22.5);
      await EzConfig.setDouble(spacingKey, 35.0);
    } else {
      await EzConfig.setDouble(paddingKey, 25.0);
      await EzConfig.setDouble(spacingKey, 40.0);
    }
    await EzConfig.setBool(hideScrollKey, false);
  }

  @override
  Widget build(BuildContext context) => EzElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(isMobile() ? 22.5 : 25.0),
        ),
        onPressed: () async {
          await onPressed();
          onComplete?.call();
        },
        text: ezL10n(context).ssBigButtons,
      );
}

class EzHighVisibilityConfig extends StatelessWidget {
  /// Only runs if you're using the full widget
  /// Calling [onPressed] does not trigger [onComplete]
  final void Function()? onComplete;

  /// Resets the current config and applies the [ezHighContrastLight] | [ezHighContrastDark] color scheme
  /// With text theme built with [atkinsonHyperlegible] and is slightly larger than the default
  /// Spacing is also increased, but not as much as [EzBigButtonsConfig]
  const EzHighVisibilityConfig({super.key, this.onComplete});

  static Future<void> onPressed(bool isDarkTheme) async {
    // Reset //

    if (isDarkTheme) {
      await EzConfig.removeKeys(darkColorKeys.keys.toSet());
      await EzConfig.removeKeys(darkDesignKeys.keys.toSet());
    } else {
      await EzConfig.removeKeys(lightColorKeys.keys.toSet());
      await EzConfig.removeKeys(lightDesignKeys.keys.toSet());
    }
    await EzConfig.removeKeys(globalDesignKeys.keys.toSet());
    await EzConfig.removeKeys(allLayoutKeys.keys.toSet());
    await EzConfig.removeKeys(allTextKeys.keys.toSet());

    // Update colors //

    if (isDarkTheme) {
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

    // Update layout //

    await EzConfig.setDouble(marginKey, 12.5);
    if (isMobile()) {
      await EzConfig.setDouble(paddingKey, 17.5);
      await EzConfig.setDouble(spacingKey, 30.0);
    } else {
      await EzConfig.setDouble(paddingKey, 20.0);
      await EzConfig.setDouble(spacingKey, 35.0);
    }
    await EzConfig.setBool(hideScrollKey, true);

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
  }

  @override
  Widget build(BuildContext context) {
    final bool onMobile = isMobile();
    final bool isDark = isDarkTheme(context);
    final EFUILang l10n = ezL10n(context);

    final TextStyle localBody = fuseWithGFont(
      starter: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
        decoration: TextDecoration.none,
        color: isDark ? Colors.white : Colors.black,
        height: 1.75,
        leadingDistribution: TextLeadingDistribution.even,
        letterSpacing: 0.30,
        wordSpacing: 1.25,
      ),
      gFont: atkinsonHyperlegible,
    );

    return EzElevatedButton(
      style: isDark
          ? ElevatedButton.styleFrom(
              backgroundColor: darkSurface,
              foregroundColor: Colors.white,
              shadowColor: Colors.transparent,
              iconColor: Colors.white,
              overlayColor: Colors.white,
              side: const BorderSide(color: darkOutline),
              textStyle: localBody,
              padding: EdgeInsets.all(onMobile ? 17.5 : 20.0),
            )
          : ElevatedButton.styleFrom(
              backgroundColor: lightSurface,
              foregroundColor: Colors.black,
              shadowColor: Colors.transparent,
              iconColor: Colors.black,
              overlayColor: Colors.black,
              side: const BorderSide(color: lightOutline),
              textStyle: localBody,
              padding: EdgeInsets.all(onMobile ? 17.5 : 20.0),
            ),
      onPressed: () async {
        await onPressed(isDark);
        onComplete?.call();
      },
      text: l10n.ssHighVisibility,
      textStyle: localBody,
    );
  }
}

class EzVideoGameConfig extends StatelessWidget {
  /// Only runs if you're using the full widget
  /// Calling [onPressed] does not trigger [onComplete]
  final void Function()? onComplete;

  /// Dark theme only config; sets [ThemeMode.dark], resets it, and...
  /// Sets [ezColorScheme] with [Brightness.dark]
  /// Slightly increases the layout spacing
  /// Sets the [TextTheme] to a [pressStart2P] based theme
  const EzVideoGameConfig({super.key, this.onComplete});

  static Future<bool> onPressed(BuildContext context) async {
    final bool onMobile = isMobile();
    final EFUILang l10n = ezL10n(context);

    // If the current theme is not dark, show a warning dialog
    if (!isDarkTheme(context)) {
      final bool doIt = await showPlatformDialog(
        context: context,
        builder: (BuildContext dContext) {
          void onConfirm() => Navigator.of(dContext).pop(true);
          void onDeny() => Navigator.of(dContext).pop(false);

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

      if (!doIt) return false;
    }

    // Reset //

    await EzConfig.removeKeys(darkColorKeys.keys.toSet());
    await EzConfig.removeKeys(darkDesignKeys.keys.toSet());
    await EzConfig.removeKeys(globalDesignKeys.keys.toSet());
    await EzConfig.removeKeys(allLayoutKeys.keys.toSet());
    await EzConfig.removeKeys(allTextKeys.keys.toSet());

    // Update colors //

    await EzConfig.setBool(isDarkThemeKey, true);
    await storeColorScheme(
      colorScheme: ezColorScheme(Brightness.dark),
      brightness: Brightness.dark,
    );

    // Update design //

    await EzConfig.setInt(animationDurationKey, 400);

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

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final bool onMobile = isMobile();

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
        final bool confirmed = await onPressed(context);
        if (confirmed) onComplete?.call();
      },
      text: ezL10n(context).ssVideoGame,
      textStyle: localBody,
    );
  }
}

const Color chalkboardGreen = Color(0xFF264941);

class EzChalkboardConfig extends StatelessWidget {
  /// Only runs if you're using the full widget
  /// Calling [onPressed] does not trigger [onComplete]
  final void Function()? onComplete;

  /// Dark theme only config; sets [ThemeMode.dark], resets it, and...
  /// Sets a [ColorScheme] similar to [ezHighContrastDark], but with a chalkboard surface (0xFF264941) and [empathSand] accents
  /// Has default design and layout settings, but a [fingerPaint] based [TextTheme]
  const EzChalkboardConfig({super.key, this.onComplete});

  static Future<bool> onPressed(BuildContext context) async {
    final EFUILang l10n = ezL10n(context);

    // If the current theme is not dark, show a warning dialog
    if (!isDarkTheme(context)) {
      final bool doIt = await showPlatformDialog(
        context: context,
        builder: (BuildContext dContext) {
          void onConfirm() => Navigator.of(dContext).pop(true);
          void onDeny() => Navigator.of(dContext).pop(false);

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

      if (!doIt) return false;
    }

    // Reset //

    await EzConfig.removeKeys(darkColorKeys.keys.toSet());
    await EzConfig.removeKeys(darkDesignKeys.keys.toSet());
    await EzConfig.removeKeys(globalDesignKeys.keys.toSet());
    await EzConfig.removeKeys(allLayoutKeys.keys.toSet());
    await EzConfig.removeKeys(allTextKeys.keys.toSet());

    // Update colors //

    await EzConfig.setBool(isDarkThemeKey, true);
    await storeColorScheme(
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        // Primary
        primary: empathSand,
        onPrimary: Colors.black,
        primaryContainer: chalkboardGreen,
        onPrimaryContainer: Colors.white,
        primaryFixed: empathSand,
        primaryFixedDim: empathSand,
        onPrimaryFixed: Colors.black,
        onPrimaryFixedVariant: Colors.black,

        // Secondary
        secondary: Colors.white,
        onSecondary: Colors.black,
        secondaryContainer: chalkboardGreen,
        onSecondaryContainer: Colors.white,
        secondaryFixed: Colors.white,
        secondaryFixedDim: Colors.white,
        onSecondaryFixed: Colors.black,
        onSecondaryFixedVariant: Colors.black,

        // Tertiary
        tertiary: Colors.white,
        onTertiary: Colors.black,
        tertiaryContainer: chalkboardGreen,
        onTertiaryContainer: Colors.white,
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

    return true;
  }

  @override
  Widget build(BuildContext context) {
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
        shadowColor: Colors.transparent,
        iconColor: empathSand,
        overlayColor: empathSand,
        side: const BorderSide(color: chalkboardGreen),
        textStyle: localBody,
        padding: EdgeInsets.all(
            isMobile() ? defaultMobilePadding : defaultDesktopPadding),
      ),
      onPressed: () async {
        final bool confirmed = await onPressed(context);
        if (confirmed) onComplete?.call();
      },
      text: l10n.ssChalkboard,
      textStyle: localBody,
    );
  }
}

class EzFancyPantsConfig extends StatelessWidget {
  /// Only runs if you're using the full widget
  /// Calling [onPressed] does not trigger [onComplete]
  final void Function()? onComplete;

  /// Reset the current config
  /// Applies a [ezColorScheme] with the primary and secondary colors swapped (primary is always [empathSand])
  /// Slightly decreases the padding and sets an [alexBrush] based [TextTheme]
  /// Otherwise default
  const EzFancyPantsConfig({super.key, this.onComplete});

  static Future<void> onPressed(bool isDarkTheme) async {
    // Reset //

    if (isDarkTheme) {
      await EzConfig.removeKeys(darkColorKeys.keys.toSet());
      await EzConfig.removeKeys(darkDesignKeys.keys.toSet());
    } else {
      await EzConfig.removeKeys(lightColorKeys.keys.toSet());
      await EzConfig.removeKeys(lightDesignKeys.keys.toSet());
    }
    await EzConfig.removeKeys(globalDesignKeys.keys.toSet());
    await EzConfig.removeKeys(allLayoutKeys.keys.toSet());
    await EzConfig.removeKeys(allTextKeys.keys.toSet());

    // Update colors //

    if (isDarkTheme) {
      await EzConfig.setInt(darkPrimaryKey, empathSandHex);
      await EzConfig.setInt(darkOnPrimaryKey, blackHex);
      await EzConfig.setInt(darkPrimaryContainerKey, empathSandDimHex);
      await EzConfig.setInt(darkOnPrimaryContainerKey, blackHex);

      await EzConfig.setInt(darkSecondaryKey, empathEucalyptusHex);
      await EzConfig.setInt(darkOnSecondaryKey, blackHex);
      await EzConfig.setInt(darkSecondaryContainerKey, empathEucalyptusDimHex);
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

    // Update design //

    await EzConfig.setInt(animationDurationKey, 600);

    // Update layout //

    await EzConfig.setDouble(paddingKey, isMobile() ? 15 : 17.5);

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
  }

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
        color: isDark ? Colors.white : Colors.black,
        height: defaultFontHeight,
        leadingDistribution: TextLeadingDistribution.even,
        letterSpacing: defaultLetterSpacing,
        wordSpacing: defaultWordSpacing,
      ),
      gFont: alexBrush,
    );

    return EzElevatedButton(
      style: isDark
          ? ElevatedButton.styleFrom(
              backgroundColor: darkSurface,
              foregroundColor: Colors.white,
              iconColor: empathSand,
              overlayColor: empathSand,
              side: const BorderSide(color: empathSandDim),
              textStyle: localBody,
              padding: EdgeInsets.all(onMobile ? 15 : 17.5),
            )
          : ElevatedButton.styleFrom(
              backgroundColor: lightSurface,
              foregroundColor: Colors.black,
              iconColor: empathSand,
              overlayColor: empathSand,
              side: const BorderSide(color: empathSandDim),
              textStyle: localBody,
              padding: EdgeInsets.all(onMobile ? 15 : 17.5),
            ),
      onPressed: () async {
        await onPressed(isDark);
        onComplete?.call();
      },
      text: l10n.ssFancyPants,
      textStyle: localBody,
    );
  }
}
