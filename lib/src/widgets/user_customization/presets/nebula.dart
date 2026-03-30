/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzNebulaConfig extends StatelessWidget {
  /// Only runs if you're using the rendered [Widget]
  /// Calling [onPressed] does not trigger [onComplete]
  final Future<void> Function() onComplete;

  /// Dark theme only config, will set [ThemeMode.dark]
  const EzNebulaConfig(this.onComplete, {super.key});

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

    // Global settings //

    await EzConfig.setBool(isDarkThemeKey, true);

    // Color settings //

    await loadColorScheme(
      const ColorScheme(
        brightness: Brightness.dark,
        // Primary
        primary: empathSand,
        primaryContainer: empathSandDim,
        onPrimary: Colors.black,
        onPrimaryContainer: Colors.black,

        // Secondary
        secondary: empathEucalyptus,
        secondaryContainer: empathEucalyptusDim,
        onSecondary: Colors.black,
        onSecondaryContainer: Colors.black,

        // Tertiary
        tertiary: empathPurple,
        tertiaryContainer: empathPurpleDim,
        onTertiary: Colors.white,
        onTertiaryContainer: Colors.white,

        // Error
        error: Colors.red,
        errorContainer: Colors.redAccent,
        onError: Colors.white,
        onErrorContainer: Colors.white,

        // Surface
        surface: Color(0x19A520DA),
        surfaceContainer: Color(0xFF0C0C0C),
        surfaceDim: Color(0xFF0C0C0C),
        onSurface: Colors.white,

        // Misc
        inversePrimary: empathSand,
        surfaceTint: Colors.transparent,
      ),
      Brightness.dark,
    );

    // Design settings //

    // Default transition(s)

    await EzConfig.setString(darkBackgroundImageKey, nebulaPath);
    await EzConfig.setString(
        '$darkBackgroundImageKey$boxFitSuffix', BoxFit.cover.name);

    await EzConfig.setString(darkButtonShapeKey, EzButtonShape.jewel.value);
    await EzConfig.setDouble(darkBorderWidthKey, 1.0);

    await EzConfig.setDouble(darkButtonOpacityKey, 0.333);
    await EzConfig.setDouble(darkBorderOpacityKey, 0.5);

    // Default layout settings //

    // Text settings //

    // Font
    await EzConfig.setString(darkDisplayFontFamilyKey, sourceCodePro);
    await EzConfig.setString(darkHeadlineFontFamilyKey, sourceCodePro);
    await EzConfig.setString(darkTitleFontFamilyKey, sourceCodePro);
    await EzConfig.setString(darkBodyFontFamilyKey, sourceCodePro);
    await EzConfig.setString(darkLabelFontFamilyKey, sourceCodePro);

    // Background opacity
    await EzConfig.setDouble(darkTextBackgroundOpacityKey, 0.333);

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
      decoration: ShapeDecoration(
        color: darkSurface,
        shape: EzButtonShape.jewel.shape,
      ),
      child: EzElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: empathPurpleDim,
          foregroundColor: Colors.white,
          shadowColor: empathPurpleDim,
          overlayColor: empathSandDim,
          side: const BorderSide(color: empathSandDim, width: 1.0),
          shape: EzButtonShape.jewel.shape,
          textStyle: localBody,
          padding: EdgeInsets.all(
              EzConfig.onMobile ? defaultMobilePadding : defaultDesktopPadding),
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
