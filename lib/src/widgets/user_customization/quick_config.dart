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
      message: EzConfig.l10n.ssTryMe,
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

  /// Whether to notify [EzConfigProvider]
  final bool notifyTheme;

  /// [EzConfigProvider.rebuild] passthrough
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
    final EdgeInsets wrapPadding = EzInsets.wrap(EzConfig.spacing);

    return EzElevatedIconButton(
      onPressed: () async {
        bool updateBoth = false;

        await ezModal(
          context: context,
          builder: (BuildContext mContext) => StatefulBuilder(
            builder: (_, StateSetter setModal) {
              void onComplete() {
                Navigator.of(mContext).pop();
                if (notifyTheme) {
                  EzConfig.provider.rebuild(onComplete: onNotify);
                }
              }

              return EzScrollView(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Theme toggle
                  EzSwitchPair(
                    text: 'Update both theme modes', // TODO: l10n
                    value: updateBoth,
                    onChanged: (bool? choice) {
                      if (choice == null) return;
                      setModal(() => updateBoth = choice);
                    },
                  ),
                  EzConfig.layout.spacer,

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
                            onComplete: onComplete,
                            isDark: updateBoth ? null : EzConfig.isDark,
                          ),
                        ),

                      // High visibility
                      if (highVisibility)
                        Padding(
                          padding: wrapPadding,
                          child: EzHighVisibilityConfig(
                            onComplete: onComplete,
                            isDark: updateBoth ? null : EzConfig.isDark,
                          ),
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
                          child: EzFancyPantsConfig(
                            onComplete: onComplete,
                            isDark: updateBoth ? null : EzConfig.isDark,
                          ),
                        ),
                    ],
                  ),
                  EzConfig.layout.spacer,
                ],
              );
            },
          ),
        );
      },
      icon: EzIcon(PlatformIcons(context).edit),
      label: EzConfig.l10n.ssLoadPreset,
    );
  }
}

class EzBigButtonsConfig extends StatelessWidget {
  /// Only runs if you're using the full widget
  /// Calling [onPressed] does not trigger [onComplete]
  final void Function()? onComplete;

  /// null updates both themes
  /// Quantum computing
  final bool? isDark;

  /// Only modifies the layout settings and icon size
  /// Slight bump to all layout values, for easier tapping
  const EzBigButtonsConfig({super.key, this.onComplete, required this.isDark});

  /// null updates both themes
  /// Quantum computing
  static Future<void> onPressed({required bool? isDark}) async {
    if (isDark == null || isDark == true) {
      // Conditionally update text
      if (EzConfig.iconSize < 25.0) {
        await EzConfig.setDouble(
          darkIconSizeKey,
          25.0,
        );
      }

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
    }

    if (isDark == null || isDark == false) {
      // Conditionally update text
      if (EzConfig.iconSize < 25.0) {
        await EzConfig.setDouble(lightIconSizeKey, 25.0);
      }

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
    }
  }

  @override
  Widget build(BuildContext context) => EzElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(isMobile() ? 22.5 : 25.0),
        ),
        onPressed: () async {
          await onPressed(isDark: isDark);
          onComplete?.call();
        },
        text: EzConfig.l10n.ssBigButtons,
      );
}

class EzHighVisibilityConfig extends StatelessWidget {
  /// Only runs if you're using the full widget
  /// Calling [onPressed] does not trigger [onComplete]
  final void Function()? onComplete;

  /// null updates both themes
  /// Quantum computing
  final bool? isDark;

  /// Resets the current config and applies the [ezHighContrastLight] | [ezHighContrastDark] color scheme
  /// With text theme built with [atkinsonHyperlegible] and is slightly larger than the default
  /// Spacing is also increased, but not as much as [EzBigButtonsConfig]
  const EzHighVisibilityConfig({
    super.key,
    this.onComplete,
    required this.isDark,
  });

  static Future<void> onPressed({required bool? isDark}) async {
    if (isDark == null || isDark == true) {
      // Reset //

      await EzConfig.removeKeys(darkColorKeys.keys.toSet());
      await EzConfig.removeKeys(darkDesignKeys.keys.toSet());
      await EzConfig.removeKeys(darkLayoutKeys.keys.toSet());
      await EzConfig.removeKeys(darkTextKeys.keys.toSet());

      // Update colors //

      await storeColorScheme(
        colorScheme: ezHighContrastDark,
        brightness: Brightness.dark,
      );

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

      await storeColorScheme(
        colorScheme: ezHighContrastLight,
        brightness: Brightness.light,
      );

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
        await onPressed(isDark: isDark);
        onComplete?.call();
      },
      text: EzConfig.l10n.ssHighVisibility,
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

    // If the current theme is not dark, show a warning dialog
    if (!EzConfig.isDark) {
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
            title: Text(EzConfig.l10n.gAttention, textAlign: TextAlign.center),
            content:
                Text(EzConfig.l10n.ssDarkOnly, textAlign: TextAlign.center),
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
    await EzConfig.removeKeys(darkLayoutKeys.keys.toSet());
    await EzConfig.removeKeys(darkTextKeys.keys.toSet());

    // Update colors //

    if (!EzConfig.isDark) await EzConfig.setBool(isDarkThemeKey, true);
    await storeColorScheme(
      colorScheme: ezColorScheme(Brightness.dark),
      brightness: Brightness.dark,
    );

    // Update design //

    await EzConfig.setInt(darkAnimationDurationKey, 400);

    // Update layout //

    if (onMobile) {
      await EzConfig.setDouble(darkMarginKey, 10.0);
      await EzConfig.setDouble(darkPaddingKey, 22.5);
      await EzConfig.setDouble(darkSpacingKey, 30.0);
    } else {
      await EzConfig.setDouble(darkMarginKey, 12.5);
      await EzConfig.setDouble(darkPaddingKey, 25.0);
      await EzConfig.setDouble(darkSpacingKey, 35.0);
    }

    // Update text //

    // Display
    await EzConfig.setString(darkDisplayFontFamilyKey, pressStart2P);
    await EzConfig.setDouble(darkDisplayFontSizeKey, 30.0);
    await EzConfig.setBool(darkDisplayBoldedKey, false);
    await EzConfig.setBool(darkDisplayItalicizedKey, false);

    // Headline
    await EzConfig.setString(darkHeadlineFontFamilyKey, pressStart2P);
    await EzConfig.setDouble(darkHeadlineFontSizeKey, 24.0);
    await EzConfig.setBool(darkHeadlineBoldedKey, false);
    await EzConfig.setBool(darkHeadlineItalicizedKey, false);

    // Title
    await EzConfig.setString(darkTitleFontFamilyKey, pressStart2P);
    await EzConfig.setDouble(darkTitleFontSizeKey, 18.0);
    await EzConfig.setBool(darkTitleBoldedKey, false);
    await EzConfig.setBool(darkTitleItalicizedKey, false);

    // Body
    await EzConfig.setString(darkBodyFontFamilyKey, pressStart2P);
    await EzConfig.setDouble(darkBodyFontSizeKey, 14.0);
    await EzConfig.setBool(darkBodyBoldedKey, false);
    await EzConfig.setBool(darkBodyItalicizedKey, false);

    // Label
    await EzConfig.setString(darkLabelFontFamilyKey, pressStart2P);
    await EzConfig.setDouble(darkLabelFontSizeKey, 12.0);
    await EzConfig.setBool(darkLabelBoldedKey, false);
    await EzConfig.setBool(darkLabelItalicizedKey, false);

    // Icons
    if (!onMobile) await EzConfig.setDouble(darkIconSizeKey, 22.0);
    return true;
  }

  @override
  Widget build(BuildContext context) {
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
        padding: EdgeInsets.all(isMobile() ? 22.5 : 25.0),
      ),
      onPressed: () async {
        final bool confirmed = await onPressed(context);
        if (confirmed) onComplete?.call();
      },
      text: EzConfig.l10n.ssVideoGame,
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
    // If the current theme is not dark, show a warning dialog
    if (!EzConfig.isDark) {
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
            title: Text(EzConfig.l10n.gAttention, textAlign: TextAlign.center),
            content:
                Text(EzConfig.l10n.ssDarkOnly, textAlign: TextAlign.center),
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
    await EzConfig.removeKeys(darkLayoutKeys.keys.toSet());
    await EzConfig.removeKeys(darkTextKeys.keys.toSet());

    // Update colors //

    if (!EzConfig.isDark) await EzConfig.setBool(isDarkThemeKey, true);
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
            isMobile() ? defaultMobilePadding : defaultDesktopPadding),
      ),
      onPressed: () async {
        final bool confirmed = await onPressed(context);
        if (confirmed) onComplete?.call();
      },
      text: EzConfig.l10n.ssChalkboard,
      textStyle: localBody,
    );
  }
}

class EzFancyPantsConfig extends StatelessWidget {
  /// Only runs if you're using the full widget
  /// Calling [onPressed] does not trigger [onComplete]
  final void Function()? onComplete;

  /// null updates both themes
  /// Quantum computing
  final bool? isDark;

  /// Reset the current config
  /// Applies a [ezColorScheme] with the primary and secondary colors swapped (primary is always [empathSand])
  /// Slightly decreases the padding and sets an [alexBrush] based [TextTheme]
  /// Otherwise default
  const EzFancyPantsConfig({super.key, this.onComplete, required this.isDark});

  static Future<void> onPressed({required bool? isDark}) async {
    if (isDark == null || isDark == true) {
      // Reset //

      await EzConfig.removeKeys(darkColorKeys.keys.toSet());
      await EzConfig.removeKeys(darkDesignKeys.keys.toSet());
      await EzConfig.removeKeys(darkLayoutKeys.keys.toSet());
      await EzConfig.removeKeys(darkTextKeys.keys.toSet());

      // Update colors //

      await EzConfig.setInt(darkPrimaryKey, empathSandHex);
      await EzConfig.setInt(darkOnPrimaryKey, blackHex);
      await EzConfig.setInt(darkPrimaryContainerKey, empathSandDimHex);
      await EzConfig.setInt(darkOnPrimaryContainerKey, blackHex);

      await EzConfig.setInt(darkSecondaryKey, empathEucalyptusHex);
      await EzConfig.setInt(darkOnSecondaryKey, blackHex);
      await EzConfig.setInt(darkSecondaryContainerKey, empathEucalyptusDimHex);
      await EzConfig.setInt(darkOnSecondaryContainerKey, blackHex);

      // Update design //

      await EzConfig.setInt(darkAnimationDurationKey, 600);

      // Update layout //

      await EzConfig.setDouble(darkPaddingKey, isMobile() ? 15 : 17.5);

      // Update text //

      await EzConfig.setString(darkDisplayFontFamilyKey, alexBrush);
      await EzConfig.setDouble(darkDisplayFontSizeKey, 60.0);
      await EzConfig.setBool(darkDisplayItalicizedKey, false);

      // Headline
      await EzConfig.setString(darkHeadlineFontFamilyKey, alexBrush);
      await EzConfig.setDouble(darkHeadlineFontSizeKey, 44.0);
      await EzConfig.setBool(darkHeadlineItalicizedKey, false);

      // Title
      await EzConfig.setString(darkTitleFontFamilyKey, alexBrush);
      await EzConfig.setDouble(darkTitleFontSizeKey, 32.0);
      await EzConfig.setBool(darkTitleItalicizedKey, false);

      // Body
      await EzConfig.setString(darkBodyFontFamilyKey, alexBrush);
      await EzConfig.setDouble(darkBodyFontSizeKey, 24.0);
      await EzConfig.setBool(darkBodyItalicizedKey, false);

      // Label
      await EzConfig.setString(darkLabelFontFamilyKey, alexBrush);
      await EzConfig.setDouble(darkLabelFontSizeKey, 20.0);
      await EzConfig.setBool(darkLabelItalicizedKey, false);
    }

    if (isDark == null || isDark == false) {
      // Reset //

      await EzConfig.removeKeys(lightColorKeys.keys.toSet());
      await EzConfig.removeKeys(lightDesignKeys.keys.toSet());
      await EzConfig.removeKeys(lightLayoutKeys.keys.toSet());
      await EzConfig.removeKeys(lightTextKeys.keys.toSet());

      // Update colors //

      await EzConfig.setInt(lightPrimaryKey, empathSandHex);
      await EzConfig.setInt(lightOnPrimaryKey, blackHex);
      await EzConfig.setInt(lightPrimaryContainerKey, empathSandDimHex);
      await EzConfig.setInt(lightOnPrimaryContainerKey, blackHex);

      await EzConfig.setInt(lightSecondaryKey, empathPurpleHex);
      await EzConfig.setInt(lightOnSecondaryKey, whiteHex);
      await EzConfig.setInt(lightSecondaryContainerKey, empathPurpleDimHex);
      await EzConfig.setInt(lightOnSecondaryContainerKey, whiteHex);

      // Update design //

      await EzConfig.setInt(lightAnimationDurationKey, 600);

      // Update layout //

      await EzConfig.setDouble(lightPaddingKey, isMobile() ? 15 : 17.5);

      // Update text //

      await EzConfig.setString(lightDisplayFontFamilyKey, alexBrush);
      await EzConfig.setDouble(lightDisplayFontSizeKey, 60.0);
      await EzConfig.setBool(lightDisplayItalicizedKey, false);

      // Headline
      await EzConfig.setString(lightHeadlineFontFamilyKey, alexBrush);
      await EzConfig.setDouble(lightHeadlineFontSizeKey, 44.0);
      await EzConfig.setBool(lightHeadlineItalicizedKey, false);

      // Title
      await EzConfig.setString(lightTitleFontFamilyKey, alexBrush);
      await EzConfig.setDouble(lightTitleFontSizeKey, 32.0);
      await EzConfig.setBool(lightTitleItalicizedKey, false);

      // Body
      await EzConfig.setString(lightBodyFontFamilyKey, alexBrush);
      await EzConfig.setDouble(lightBodyFontSizeKey, 24.0);
      await EzConfig.setBool(lightBodyItalicizedKey, false);

      // Label
      await EzConfig.setString(lightLabelFontFamilyKey, alexBrush);
      await EzConfig.setDouble(lightLabelFontSizeKey, 20.0);
      await EzConfig.setBool(lightLabelItalicizedKey, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle localBody = fuseWithGFont(
      starter: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
        decoration: TextDecoration.none,
        color: EzConfig.isDark ? Colors.white : Colors.black,
        height: defaultFontHeight,
        leadingDistribution: TextLeadingDistribution.even,
        letterSpacing: defaultLetterSpacing,
        wordSpacing: defaultWordSpacing,
      ),
      gFont: alexBrush,
    );

    return EzElevatedButton(
      style: EzConfig.isDark
          ? ElevatedButton.styleFrom(
              backgroundColor: darkSurface,
              foregroundColor: Colors.white,
              iconColor: empathSand,
              overlayColor: empathSand,
              side: const BorderSide(color: empathSandDim),
              textStyle: localBody,
              padding: EdgeInsets.all(isMobile() ? 15 : 17.5),
            )
          : ElevatedButton.styleFrom(
              backgroundColor: lightSurface,
              foregroundColor: Colors.black,
              iconColor: empathSand,
              overlayColor: empathSand,
              side: const BorderSide(color: empathSandDim),
              textStyle: localBody,
              padding: EdgeInsets.all(isMobile() ? 15 : 17.5),
            ),
      onPressed: () async {
        await onPressed(isDark: isDark);
        onComplete?.call();
      },
      text: EzConfig.l10n.ssFancyPants,
      textStyle: localBody,
    );
  }
}
