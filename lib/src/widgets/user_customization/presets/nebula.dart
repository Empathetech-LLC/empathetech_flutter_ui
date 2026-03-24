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

  static const double nebulaOpacity = 0.25;

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
    await EzConfig.setDouble(darkBorderOpacityKey, nebulaOpacity);

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
        borderRadius: ezPillEdge,
      ),
      child: EzElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: empathPurple.withValues(alpha: nebulaOpacity),
          shadowColor: empathPurple.withValues(alpha: nebulaOpacity),
          foregroundColor: Colors.white,
          iconColor: empathSand,
          overlayColor: empathSand,
          side: EzConfig.borderSide(empathSandDim),
          shape: EzConfig.buttonShape.shape,
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
