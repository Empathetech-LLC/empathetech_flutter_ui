/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzChalkboardConfig extends StatelessWidget {
  /// Only runs if you're using the rendered [Widget]
  /// Calling [onPressed] does not trigger [onComplete]
  final Future<void> Function() onComplete;

  /// Dark theme only config; sets [ThemeMode.dark], resets it, and...
  /// Sets a [ColorScheme] similar to [ezHighContrastDark], but with a [chalkboardGreen] surface and [empathSand] accents
  /// Has default design and layout settings, but a [fingerPaint] based [TextTheme]
  const EzChalkboardConfig(this.onComplete, {super.key});

  /// When true, skips the "This is a dark theme only..." dialog
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
        side: EzConfig.borderSide(chalkboardGreen),
        shape: EzConfig.buttonShape.shape,
        textStyle: localBody,
        padding: EdgeInsets.all(
          EzConfig.onMobile ? defaultMobilePadding : defaultDesktopPadding,
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
