/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzWallHolesConfig extends StatelessWidget {
  /// Only runs if you're using the rendered [Widget]
  /// Calling [onPressed] does not trigger [onComplete]
  final Future<void> Function() onComplete;

  /// !Not Windows
  const EzWallHolesConfig(this.onComplete, {super.key});

  static Future<bool> onPressed(BuildContext context) async {
    // If the current theme is not light, show a warning dialog
    if (EzConfig.themeMode != ThemeMode.light) {
      final bool doIt = await showDialog(
        context: context,
        builder: (BuildContext dContext) => EzAlertDialog(
          title: Text(EzConfig.l10n.gAttention, textAlign: TextAlign.center),
          content: Text(
            EzConfig.l10n.ssLightOnly,
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

    await EzConfig.removeKeys(lightColorKeys.keys.toSet());
    await EzConfig.removeKeys(lightDesignKeys.keys.toSet());
    await EzConfig.removeKeys(lightLayoutKeys.keys.toSet());
    await EzConfig.removeKeys(lightTextKeys.keys.toSet());

    // Global settings //

    // Default lefty and language

    await EzConfig.setBool(isDarkThemeKey, false);

    // Color settings //
    // TODO: mess around with it, I'm sure there's lots more to do

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

    await EzConfig.setInt(lightPrimaryKey, 0xFF3B77BC);
    await EzConfig.setInt(lightPrimaryContainerKey, blackHex);
    await EzConfig.setInt(lightOnPrimaryKey, whiteHex);

    await EzConfig.setInt(lightSecondaryKey, 0xFFFCCF03);
    await EzConfig.setInt(lightSecondaryContainerKey, blackHex);
    await EzConfig.setInt(lightOnSecondaryKey, blackHex);

    await EzConfig.setInt(lightTertiaryKey, 0xFF81C046);
    await EzConfig.setInt(lightTertiaryContainerKey, blackHex);
    await EzConfig.setInt(lightOnTertiaryKey, blackHex);

    await EzConfig.setInt(lightSurfaceContainerKey, 0xFFDAE4F8);
    await EzConfig.setInt(lightSurfaceDimKey, 0xFFDAE4F8);

    await EzConfig.setInt(lightErrorKey, 0xFFDE482B);
    await EzConfig.setInt(lightOnErrorKey, blackHex);

    // Design settings //
    // TODO: both scale and zoom? This is for elsewhere but I'm in the zone

    await EzConfig.setInt(lightAnimationDurationKey, 600);
    await EzConfig.setString(
        lightTransitionTypeKey, EzPageTransition.zoom.value);

    await EzConfig.setString(lightBackgroundImageKey, wallHolesPath);
    await EzConfig.setString(
        '$lightBackgroundImageKey$boxFitSuffix', BoxFit.cover.name);

    await EzConfig.setString(lightButtonShapeKey, EzButtonShape.rect.value);
    await EzConfig.setDouble(lightBorderWidthKey, 2.0);
    await EzConfig.setDouble(lightBorderOpacityKey, 1.0);

    // Layout settings //

    // Default margin, padding, && spacing

    await EzConfig.setBool(lightShowBackFABKey, true);
    await EzConfig.setBool(lightShowScrollKey, true);

    // Text settings //

    // Default text styles

    await EzConfig.setDouble(lightTextBackgroundOpacityKey, 0.65);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle localBody = ezDefaultBodyStyle(Colors.black);

    return EzElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFDAE4F8),
        foregroundColor: Colors.black,
        overlayColor: Colors.white,
        side: const BorderSide(color: Colors.black, width: 2.0),
        shape: EzButtonShape.rect.shape,
        textStyle: localBody,
        padding: EdgeInsets.all(
            EzConfig.onMobile ? defaultMobilePadding : defaultDesktopPadding),
      ),
      onPressed: () async {
        final bool confirmed = await onPressed(context);
        if (confirmed) await onComplete();
      },
      text: EzConfig.l10n.ssWallHoles,
      textStyle: localBody,
    );
  }
}
