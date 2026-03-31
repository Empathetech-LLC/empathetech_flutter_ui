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

    // Global settings //

    // Default lefty and language

    await EzConfig.setBool(isDarkThemeKey, true);

    // Color settings //

    await loadColorScheme(
      const ColorScheme(
        brightness: Brightness.dark,
        // Primary
        primary: empathSand,
        onPrimary: Colors.black,
        primaryContainer: Colors.white,
        onPrimaryContainer: Colors.black,

        // Secondary
        secondary: darkOutline,
        onSecondary: Colors.black,
        secondaryContainer: Colors.white,
        onSecondaryContainer: Colors.black,

        // Tertiary
        tertiary: Colors.white,
        onTertiary: Colors.black,
        tertiaryContainer: Colors.white,
        onTertiaryContainer: Colors.black,

        // Error
        error: Colors.red,
        onError: Colors.white,
        errorContainer: Colors.white,
        onErrorContainer: Colors.black,

        // Surface
        surface: chalkboardGreen,
        onSurface: Colors.white,
        surfaceBright: chalkboardGreen,
        surfaceContainerLowest: chalkboardGreen,
        surfaceContainerLow: chalkboardGreen,
        surfaceContainer: chalkboardGreen,
        surfaceContainerHigh: chalkboardGreen,
        surfaceContainerHighest: chalkboardGreen,
        surfaceDim: chalkboardGreen,
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

    // Design settings //

    await EzConfig.setInt(darkAnimationDurationKey, 500);

    await EzConfig.setString(
        darkTransitionTypeKey, EzPageTransition.slideDown.value);

    await EzConfig.setString(darkButtonShapeKey, EzButtonShape.rect.value);

    await EzConfig.setDouble(darkBorderOpacityKey, 0.0);

    // Layout settings //

    await EzConfig.setBool(darkShowScrollKey, false);
    await EzConfig.setBool(darkShowBackFABKey, false);

    // Text settings //

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

    await EzConfig.setDouble(darkTextBackgroundOpacityKey, 0.0);

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
        overlayColor: empathSand,
        side: BorderSide.none,
        shape: EzButtonShape.rect.shape,
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
