/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class TryTip extends StatelessWidget {
  final Widget child;

  const TryTip({super.key, required this.child});

  @override
  Widget build(BuildContext context) => Tooltip(
        message: EzConfig.l10n.ssTryMe,
        excludeFromSemantics: true,
        child: child,
      );
}

class EzQuickConfig extends StatelessWidget {
  /// [EzConfigProvider.rebuildUI] passthrough
  final void Function() onComplete;

  /// Toggle the [EzBigButtonsConfig]
  final bool bigButtons;

  /// Toggle the [EzHighVisibilityConfig]
  final bool highVisibility;

  /// Toggle the [EzChalkboardConfig]
  final bool chalkboard;

  /// Toggle the [EzNebulaConfig]
  final bool nebula;

  /// Opens a [BottomSheet] with [EzElevatedIconButton]s for different [EzConfig] presets
  const EzQuickConfig(
    this.onComplete, {
    super.key,
    this.bigButtons = true,
    this.highVisibility = true,
    this.chalkboard = true,
    this.nebula = true,
  });

  // Return the build //

  @override
  Widget build(BuildContext context) {
    final EdgeInsets wrapPadding = EzInsets.wrap(EzConfig.spacing);

    return EzElevatedIconButton(
      onPressed: () async {
        bool updateBoth = false;

        await ezModal(
          context: context,
          builder: (BuildContext mContext) => StatefulBuilder(
            builder: (_, StateSetter setModal) {
              Future<void> cleanRebuild() async {
                await EzConfig.rebuildUI(onComplete);
                if (mContext.mounted) Navigator.of(mContext).pop();
              }

              return EzScrollView(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Theme toggle
                  EzSwitchPair(
                    text: EzConfig.l10n.ssUpdateBoth,
                    value: updateBoth,
                    onChanged: (bool? choice) {
                      if (choice == null) return;
                      setModal(() => updateBoth = choice);
                    },
                  ),
                  EzConfig.spacer,

                  // Choices
                  Wrap(
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      // Big buttons
                      if (bigButtons)
                        Padding(
                          padding: wrapPadding,
                          child: EzBigButtonsConfig(
                            updateBoth ? null : EzConfig.isDark,
                            cleanRebuild,
                          ),
                        ),

                      // High visibility
                      if (highVisibility)
                        Padding(
                          padding: wrapPadding,
                          child: EzHighVisibilityConfig(
                            updateBoth ? null : EzConfig.isDark,
                            cleanRebuild,
                          ),
                        ),

                      // Chalkboard
                      if (chalkboard)
                        Padding(
                          padding: wrapPadding,
                          child: EzChalkboardConfig(cleanRebuild),
                        ),

                      // Nebula
                      if (nebula)
                        Padding(
                          padding: wrapPadding,
                          child: EzNebulaConfig(cleanRebuild),
                        ),
                    ],
                  ),
                  EzConfig.spacer,
                ],
              );
            },
          ),
        );
      },
      icon: const Icon(Icons.edit),
      label: EzConfig.l10n.ssLoadPreset,
    );
  }
}

class EzBigButtonsConfig extends StatelessWidget {
  /// null updates both themes
  /// Quantum computing
  final bool? isDark;

  /// Only runs if you're using the rendered [Widget]
  /// Calling [onPressed] does not trigger [onComplete]
  final Future<void> Function() onComplete;

  /// Only modifies the layout settings and icon size
  /// Slight bump to all layout values, for easier tapping
  const EzBigButtonsConfig(this.isDark, this.onComplete, {super.key});

  /// null updates both themes
  /// Quantum computing
  static Future<void> onPressed(bool? isDark) async {
    if (isDark == null || isDark == true) {
      // Update layout
      await EzConfig.setDouble(darkMarginKey, 12.5);
      if (isMobile()) {
        await EzConfig.setDouble(darkPaddingKey, 22.5);
        await EzConfig.setDouble(darkSpacingKey, 35.0);
      } else {
        await EzConfig.setDouble(darkPaddingKey, 25.0);
        await EzConfig.setDouble(darkSpacingKey, 40.0);
      }
      await EzConfig.setBool(darkHideScrollKey, false);

      // Conditionally update text
      if (EzConfig.iconSize < 25.0) {
        await EzConfig.setDouble(darkIconSizeKey, 25.0);
      }
    }

    if (isDark == null || isDark == false) {
      // Update layout
      await EzConfig.setDouble(lightMarginKey, 12.5);
      if (isMobile()) {
        await EzConfig.setDouble(lightPaddingKey, 22.5);
        await EzConfig.setDouble(lightSpacingKey, 35.0);
      } else {
        await EzConfig.setDouble(lightPaddingKey, 25.0);
        await EzConfig.setDouble(lightSpacingKey, 40.0);
      }
      await EzConfig.setBool(lightHideScrollKey, false);

      // Conditionally update text
      if (EzConfig.iconSize < 25.0) {
        await EzConfig.setDouble(lightIconSizeKey, 25.0);
      }
    }
  }

  @override
  Widget build(BuildContext context) => EzElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(isMobile() ? 22.5 : 25.0),
        ),
        onPressed: () async {
          await onPressed(isDark);
          await onComplete();
        },
        text: EzConfig.l10n.ssBigButtons,
      );
}

class EzHighVisibilityConfig extends StatelessWidget {
  /// null updates both themes
  /// Quantum computing
  final bool? isDark;

  /// Only runs if you're using the rendered [Widget]
  /// Calling [onPressed] does not trigger [onComplete]
  final Future<void> Function() onComplete;

  /// Resets the current config and applies the [ezHighContrastLight] | [ezHighContrastDark] color scheme
  /// With text theme built with [atkinsonHyperlegible] and is slightly larger than the default
  /// Spacing is also increased, but not as much as [EzBigButtonsConfig]
  const EzHighVisibilityConfig(this.isDark, this.onComplete, {super.key});

  static Future<void> onPressed(bool? isDark) async {
    if (isDark == null || isDark == true) {
      // Reset //

      await EzConfig.removeKeys(darkColorKeys.keys.toSet());
      await EzConfig.removeKeys(darkDesignKeys.keys.toSet());
      await EzConfig.removeKeys(darkLayoutKeys.keys.toSet());
      await EzConfig.removeKeys(darkTextKeys.keys.toSet());

      // Update colors //

      await loadColorScheme(ezHighContrastDark, Brightness.dark);

      // Update layout //

      await EzConfig.setDouble(darkMarginKey, 12.5);
      if (isMobile()) {
        await EzConfig.setDouble(darkPaddingKey, 17.5);
        await EzConfig.setDouble(darkSpacingKey, 30.0);
      } else {
        await EzConfig.setDouble(darkPaddingKey, 20.0);
        await EzConfig.setDouble(darkSpacingKey, 35.0);
      }
      await EzConfig.setBool(darkHideScrollKey, true);

      // Update text //

      // Display
      await EzConfig.setString(darkDisplayFontFamilyKey, atkinsonHyperlegible);
      await EzConfig.setDouble(darkDisplayFontSizeKey, 50);
      await EzConfig.setBool(darkDisplayBoldedKey, false);
      await EzConfig.setBool(darkDisplayItalicizedKey, false);
      await EzConfig.setBool(darkDisplayUnderlinedKey, false);
      await EzConfig.setDouble(darkDisplayFontHeightKey, 1.5);
      await EzConfig.setDouble(darkDisplayLetterSpacingKey, 0.30);
      await EzConfig.setDouble(darkDisplayWordSpacingKey, 1.25);

      // Headline
      await EzConfig.setString(darkHeadlineFontFamilyKey, atkinsonHyperlegible);
      await EzConfig.setDouble(darkHeadlineFontSizeKey, 38);
      await EzConfig.setBool(darkHeadlineBoldedKey, false);
      await EzConfig.setBool(darkHeadlineItalicizedKey, false);
      await EzConfig.setBool(darkHeadlineUnderlinedKey, false);
      await EzConfig.setDouble(darkHeadlineFontHeightKey, 1.625);
      await EzConfig.setDouble(darkHeadlineLetterSpacingKey, 0.30);
      await EzConfig.setDouble(darkHeadlineWordSpacingKey, 1.25);

      // Title
      await EzConfig.setString(darkTitleFontFamilyKey, atkinsonHyperlegible);
      await EzConfig.setDouble(darkTitleFontSizeKey, 26);
      await EzConfig.setBool(darkTitleBoldedKey, false);
      await EzConfig.setBool(darkTitleItalicizedKey, false);
      await EzConfig.setBool(darkTitleUnderlinedKey, true);
      await EzConfig.setDouble(darkTitleFontHeightKey, 1.75);
      await EzConfig.setDouble(darkTitleLetterSpacingKey, 0.30);
      await EzConfig.setDouble(darkTitleWordSpacingKey, 1.25);

      // Body
      await EzConfig.setString(darkBodyFontFamilyKey, atkinsonHyperlegible);
      await EzConfig.setDouble(darkBodyFontSizeKey, 20);
      await EzConfig.setBool(darkBodyBoldedKey, false);
      await EzConfig.setBool(darkBodyItalicizedKey, false);
      await EzConfig.setBool(darkBodyUnderlinedKey, false);
      await EzConfig.setDouble(darkBodyFontHeightKey, 1.75);
      await EzConfig.setDouble(darkBodyLetterSpacingKey, 0.30);
      await EzConfig.setDouble(darkBodyWordSpacingKey, 1.25);

      // Label
      await EzConfig.setString(darkLabelFontFamilyKey, atkinsonHyperlegible);
      await EzConfig.setDouble(darkLabelFontSizeKey, 16);
      await EzConfig.setBool(darkLabelBoldedKey, false);
      await EzConfig.setBool(darkLabelItalicizedKey, false);
      await EzConfig.setBool(darkLabelUnderlinedKey, false);
      await EzConfig.setDouble(darkLabelFontHeightKey, 1.75);
      await EzConfig.setDouble(darkLabelLetterSpacingKey, 0.30);
      await EzConfig.setDouble(darkLabelWordSpacingKey, 1.25);

      // Icons
      await EzConfig.setDouble(darkIconSizeKey, 22.0);
    }

    if (isDark == null || isDark == false) {
      // Reset //

      await EzConfig.removeKeys(lightColorKeys.keys.toSet());
      await EzConfig.removeKeys(lightDesignKeys.keys.toSet());
      await EzConfig.removeKeys(lightLayoutKeys.keys.toSet());
      await EzConfig.removeKeys(lightTextKeys.keys.toSet());

      // Update colors //

      await loadColorScheme(ezHighContrastLight, Brightness.light);

      // Update layout //

      await EzConfig.setDouble(lightMarginKey, 12.5);
      if (isMobile()) {
        await EzConfig.setDouble(lightPaddingKey, 17.5);
        await EzConfig.setDouble(lightSpacingKey, 30.0);
      } else {
        await EzConfig.setDouble(lightPaddingKey, 20.0);
        await EzConfig.setDouble(lightSpacingKey, 35.0);
      }
      await EzConfig.setBool(lightHideScrollKey, true);
    }

    // Update text //

    // Display
    await EzConfig.setString(lightDisplayFontFamilyKey, atkinsonHyperlegible);
    await EzConfig.setDouble(lightDisplayFontSizeKey, 50);
    await EzConfig.setBool(lightDisplayBoldedKey, false);
    await EzConfig.setBool(lightDisplayItalicizedKey, false);
    await EzConfig.setBool(lightDisplayUnderlinedKey, false);
    await EzConfig.setDouble(lightDisplayFontHeightKey, 1.5);
    await EzConfig.setDouble(lightDisplayLetterSpacingKey, 0.30);
    await EzConfig.setDouble(lightDisplayWordSpacingKey, 1.25);

    // Headline
    await EzConfig.setString(lightHeadlineFontFamilyKey, atkinsonHyperlegible);
    await EzConfig.setDouble(lightHeadlineFontSizeKey, 38);
    await EzConfig.setBool(lightHeadlineBoldedKey, false);
    await EzConfig.setBool(lightHeadlineItalicizedKey, false);
    await EzConfig.setBool(lightHeadlineUnderlinedKey, false);
    await EzConfig.setDouble(lightHeadlineFontHeightKey, 1.625);
    await EzConfig.setDouble(lightHeadlineLetterSpacingKey, 0.30);
    await EzConfig.setDouble(lightHeadlineWordSpacingKey, 1.25);

    // Title
    await EzConfig.setString(lightTitleFontFamilyKey, atkinsonHyperlegible);
    await EzConfig.setDouble(lightTitleFontSizeKey, 26);
    await EzConfig.setBool(lightTitleBoldedKey, false);
    await EzConfig.setBool(lightTitleItalicizedKey, false);
    await EzConfig.setBool(lightTitleUnderlinedKey, true);
    await EzConfig.setDouble(lightTitleFontHeightKey, 1.75);
    await EzConfig.setDouble(lightTitleLetterSpacingKey, 0.30);
    await EzConfig.setDouble(lightTitleWordSpacingKey, 1.25);

    // Body
    await EzConfig.setString(lightBodyFontFamilyKey, atkinsonHyperlegible);
    await EzConfig.setDouble(lightBodyFontSizeKey, 20);
    await EzConfig.setBool(lightBodyBoldedKey, false);
    await EzConfig.setBool(lightBodyItalicizedKey, false);
    await EzConfig.setBool(lightBodyUnderlinedKey, false);
    await EzConfig.setDouble(lightBodyFontHeightKey, 1.75);
    await EzConfig.setDouble(lightBodyLetterSpacingKey, 0.30);
    await EzConfig.setDouble(lightBodyWordSpacingKey, 1.25);

    // Label
    await EzConfig.setString(lightLabelFontFamilyKey, atkinsonHyperlegible);
    await EzConfig.setDouble(lightLabelFontSizeKey, 16);
    await EzConfig.setBool(lightLabelBoldedKey, false);
    await EzConfig.setBool(lightLabelItalicizedKey, false);
    await EzConfig.setBool(lightLabelUnderlinedKey, false);
    await EzConfig.setDouble(lightLabelFontHeightKey, 1.75);
    await EzConfig.setDouble(lightLabelLetterSpacingKey, 0.30);
    await EzConfig.setDouble(lightLabelWordSpacingKey, 1.25);

    // Icons
    await EzConfig.setDouble(lightIconSizeKey, 22.0);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle localBody = fuseWithGFont(
      starter: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
        decoration: TextDecoration.none,
        color: EzConfig.isDark ? Colors.white : Colors.black,
        height: 1.75,
        leadingDistribution: TextLeadingDistribution.even,
        letterSpacing: 0.30,
        wordSpacing: 1.25,
      ),
      gFont: atkinsonHyperlegible,
    );

    return EzElevatedButton(
      style: EzConfig.isDark
          ? ElevatedButton.styleFrom(
              backgroundColor: darkSurface,
              foregroundColor: Colors.white,
              shadowColor: Colors.transparent,
              iconColor: Colors.white,
              overlayColor: Colors.white,
              side: const BorderSide(color: darkOutline),
              textStyle: localBody,
              padding: EdgeInsets.all(isMobile() ? 17.5 : 20.0),
            )
          : ElevatedButton.styleFrom(
              backgroundColor: lightSurface,
              foregroundColor: Colors.black,
              shadowColor: Colors.transparent,
              iconColor: Colors.black,
              overlayColor: Colors.black,
              side: const BorderSide(color: lightOutline),
              textStyle: localBody,
              padding: EdgeInsets.all(isMobile() ? 17.5 : 20.0),
            ),
      onPressed: () async {
        await onPressed(isDark);
        await onComplete();
      },
      text: EzConfig.l10n.ssHighVisibility,
      textStyle: localBody,
    );
  }
}

class EzChalkboardConfig extends StatelessWidget {
  /// Only runs if you're using the rendered [Widget]
  /// Calling [onPressed] does not trigger [onComplete]
  final Future<void> Function() onComplete;

  /// Dark theme only config; sets [ThemeMode.dark], resets it, and...
  /// Sets a [ColorScheme] similar to [ezHighContrastDark], but with a [chalkboardGreen] surface and [empathSand] accents
  /// Has default design and layout settings, but a [fingerPaint] based [TextTheme]
  const EzChalkboardConfig(this.onComplete, {super.key});

  static Future<bool> onPressed(BuildContext context) async {
    // If the current theme is not dark, show a warning dialog
    if (EzConfig.themeMode != ThemeMode.dark) {
      final bool doIt = await showDialog(
        context: context,
        builder: (BuildContext dContext) => EzAlertDialog(
          title: Text(EzConfig.l10n.gAttention, textAlign: TextAlign.center),
          content: Text(
            EzConfig.l10n.ssDarkOnly,
            textAlign: TextAlign.center,
          ),
          actions: ezActionPair(
            context: context,
            onConfirm: () => Navigator.of(dContext).pop(true),
            confirmIsDestructive: true,
            onDeny: () => Navigator.of(dContext).pop(false),
          ),
          needsClose: false,
        ),
      );

      if (!doIt) return false;
    }

    // Reset //

    await EzConfig.removeKeys(darkColorKeys.keys.toSet());
    await EzConfig.removeKeys(darkDesignKeys.keys.toSet());
    await EzConfig.removeKeys(darkLayoutKeys.keys.toSet());
    await EzConfig.removeKeys(darkTextKeys.keys.toSet());

    // Update theme mode //

    await EzConfig.setBool(isDarkThemeKey, true);

    // Update colors //

    await loadColorScheme(
      const ColorScheme(
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
      Brightness.dark,
    );

    // Update text //

    // Display
    await EzConfig.setString(darkDisplayFontFamilyKey, fingerPaint);
    await EzConfig.setBool(darkDisplayItalicizedKey, false);

    // Headline
    await EzConfig.setString(darkHeadlineFontFamilyKey, fingerPaint);
    await EzConfig.setBool(darkHeadlineItalicizedKey, false);

    // Title
    await EzConfig.setString(darkTitleFontFamilyKey, fingerPaint);
    await EzConfig.setBool(darkTitleItalicizedKey, false);

    // Body
    await EzConfig.setString(darkBodyFontFamilyKey, fingerPaint);
    await EzConfig.setBool(darkBodyItalicizedKey, false);

    // Label
    await EzConfig.setString(darkLabelFontFamilyKey, fingerPaint);
    await EzConfig.setBool(darkLabelItalicizedKey, false);

    return true;
  }

  @override
  Widget build(BuildContext context) {
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
          isMobile() ? defaultMobilePadding : defaultDesktopPadding,
        ),
      ),
      onPressed: () async {
        final bool confirmed = await onPressed(context);
        if (confirmed) await onComplete();
      },
      text: EzConfig.l10n.ssChalkboard,
      textStyle: localBody,
    );
  }
}

class EzNebulaConfig extends StatelessWidget {
  /// Only runs if you're using the rendered [Widget]
  /// Calling [onPressed] does not trigger [onComplete]
  final Future<void> Function() onComplete;

  /// Dark theme only config, will set [ThemeMode.dark]
  const EzNebulaConfig(this.onComplete, {super.key});

  static const double nebulaOpacity = 0.25;

  static Future<bool> onPressed(BuildContext context) async {
    // If the current theme is not dark, show a warning dialog
    if (EzConfig.themeMode != ThemeMode.dark) {
      final bool doIt = await showDialog(
        context: context,
        builder: (BuildContext dContext) => EzAlertDialog(
          title: Text(EzConfig.l10n.gAttention, textAlign: TextAlign.center),
          content: Text(
            EzConfig.l10n.ssDarkOnly,
            textAlign: TextAlign.center,
          ),
          actions: ezActionPair(
            context: context,
            onConfirm: () => Navigator.of(dContext).pop(true),
            confirmIsDestructive: true,
            onDeny: () => Navigator.of(dContext).pop(false),
          ),
          needsClose: false,
        ),
      );

      if (!doIt) return false;
    }

    // Reset //

    await EzConfig.removeKeys(darkColorKeys.keys.toSet());
    await EzConfig.removeKeys(darkDesignKeys.keys.toSet());
    await EzConfig.removeKeys(darkLayoutKeys.keys.toSet());
    await EzConfig.removeKeys(darkTextKeys.keys.toSet());

    // Update theme mode //

    await EzConfig.setBool(isDarkThemeKey, true);

    // Update colors //

    // TODO: batch set
    await EzConfig.setInt(darkPrimaryKey, empathSandHex);
    await EzConfig.setInt(darkPrimaryContainerKey, empathSandDimHex);
    await EzConfig.setInt(darkOnPrimaryKey, blackHex);
    await EzConfig.setInt(darkOnPrimaryContainerKey, blackHex);

    await EzConfig.setInt(darkSecondaryKey, empathEucalyptusHex);
    await EzConfig.setInt(darkSecondaryContainerKey, empathEucalyptusDimHex);
    await EzConfig.setInt(darkOnSecondaryKey, blackHex);
    await EzConfig.setInt(darkOnSecondaryContainerKey, blackHex);

    await EzConfig.setInt(darkTertiaryKey, empathPurpleHex);
    await EzConfig.setInt(darkTertiaryContainerKey, empathPurpleDimHex);
    await EzConfig.setInt(darkOnTertiaryKey, whiteHex);
    await EzConfig.setInt(darkOnTertiaryContainerKey, whiteHex);

    await EzConfig.setInt(darkSurfaceKey, 0x19A520DA);
    await EzConfig.setInt(darkSurfaceDimKey, 0xFF0C0C0C);
    await EzConfig.setInt(darkSurfaceContainerKey, 0xFF0C0C0C);
    await EzConfig.setInt(darkInversePrimaryKey, empathSandHex);

    // Update design //

    await EzConfig.setString(darkBackgroundImageKey, nebulaPath);
    await EzConfig.setString(
        '$darkBackgroundImageKey$boxFitSuffix', BoxFit.cover.name);
    await EzConfig.setDouble(darkButtonOpacityKey, nebulaOpacity);
    await EzConfig.setDouble(darkButtonOutlineOpacityKey, nebulaOpacity);

    // Update layout //

    // Update text //

    // Font
    await EzConfig.setString(darkDisplayFontFamilyKey, sourceCodePro);
    await EzConfig.setString(darkHeadlineFontFamilyKey, sourceCodePro);
    await EzConfig.setString(darkTitleFontFamilyKey, sourceCodePro);
    await EzConfig.setString(darkBodyFontFamilyKey, sourceCodePro);
    await EzConfig.setString(darkLabelFontFamilyKey, sourceCodePro);

    // Background opacity
    await EzConfig.setDouble(darkTextBackgroundOpacityKey, nebulaOpacity);

    return true;
  }

  @override
  Widget build(BuildContext context) {
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
      gFont: sourceCodePro,
    );

    return Container(
      decoration: const BoxDecoration(
        color: darkSurfaceContainer,
        borderRadius: ezPillShape,
      ),
      child: EzElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: empathPurple.withValues(alpha: nebulaOpacity),
          shadowColor: empathPurple.withValues(alpha: nebulaOpacity),
          foregroundColor: Colors.white,
          iconColor: empathSand,
          overlayColor: empathSand,
          side: const BorderSide(color: empathSandDim),
          textStyle: localBody,
        ),
        onPressed: () async {
          final bool confirmed = await onPressed(context);
          if (confirmed) await onComplete();
        },
        text: EzConfig.l10n.ssNebula,
        textStyle: localBody,
      ),
    );
  }
}
