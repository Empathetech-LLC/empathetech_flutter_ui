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

    await loadColorScheme(
      const ColorScheme(
        brightness: Brightness.light,

        // Primary
        primary: Color(0xFF3B77BC),
        onPrimary: Colors.white,
        primaryContainer: Colors.black,
        onPrimaryContainer: Colors.white,

        // Secondary
        secondary: Color(0xFFFCCF03),
        onSecondary: Colors.black,
        secondaryContainer: Colors.black,
        onSecondaryContainer: Colors.white,

        // Tertiary
        tertiary: Color(0xFF81C046),
        onTertiary: Colors.black,
        tertiaryContainer: Colors.black,
        onTertiaryContainer: Colors.white,

        // Error
        error: Color(0xFFDE482B),
        onError: Colors.white,
        errorContainer: Colors.black,
        onErrorContainer: Colors.white,

        // Surface
        surface: lightSurface,
        onSurface: Colors.black,
        surfaceContainer: Color(0xFFDAE4F8),
        surfaceDim: Color(0xFFDAE4F8),

        // Misc
        outline: lightOutline,
        outlineVariant: lightOutlineVariant,
        shadow: Colors.transparent,
        scrim: Colors.white,
        surfaceTint: Colors.transparent,
      ),
      Brightness.light,
    );

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
