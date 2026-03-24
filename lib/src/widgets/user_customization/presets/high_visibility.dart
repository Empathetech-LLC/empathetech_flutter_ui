/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzHighVisibilityConfig extends StatelessWidget {
  /// Only runs if you're using the rendered [Widget]
  /// Calling [onPressed] does not trigger [onComplete]
  final Future<void> Function() onComplete;

  /// Resets the current config and applies the [ezHighContrastLight] | [ezHighContrastDark] color scheme
  /// With text theme built with [atkinsonHyperlegible] and is slightly larger than the default
  /// Spacing is also increased, but not as much as [EzBigButtonsConfig]
  const EzHighVisibilityConfig(this.onComplete, {super.key});

  static Future<void> onPressed() async {
    if (EzConfig.updateBoth || EzConfig.isDark) {
      // Reset //

      await EzConfig.removeKeys(darkColorKeys.keys.toSet());
      await EzConfig.removeKeys(darkDesignKeys.keys.toSet());
      await EzConfig.removeKeys(darkLayoutKeys.keys.toSet());
      await EzConfig.removeKeys(darkTextKeys.keys.toSet());

      // Update colors //

      await loadColorScheme(ezHighContrastDark, Brightness.dark);

      // Update layout //

      await EzConfig.setDouble(darkMarginKey, 12.5);
      if (EzConfig.onMobile) {
        await EzConfig.setDouble(darkPaddingKey, 17.5);
        await EzConfig.setDouble(darkSpacingKey, 30.0);
      } else {
        await EzConfig.setDouble(darkPaddingKey, 20.0);
        await EzConfig.setDouble(darkSpacingKey, 35.0);
      }
      await EzConfig.setBool(darkShowBackFABKey, false);
      await EzConfig.setBool(darkShowScrollKey, false);

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

    if (EzConfig.updateBoth || !EzConfig.isDark) {
      // Reset //

      await EzConfig.removeKeys(lightColorKeys.keys.toSet());
      await EzConfig.removeKeys(lightDesignKeys.keys.toSet());
      await EzConfig.removeKeys(lightLayoutKeys.keys.toSet());
      await EzConfig.removeKeys(lightTextKeys.keys.toSet());

      // Update colors //

      await loadColorScheme(ezHighContrastLight, Brightness.light);

      // Update layout //

      await EzConfig.setDouble(lightMarginKey, 12.5);
      if (EzConfig.onMobile) {
        await EzConfig.setDouble(lightPaddingKey, 17.5);
        await EzConfig.setDouble(lightSpacingKey, 30.0);
      } else {
        await EzConfig.setDouble(lightPaddingKey, 20.0);
        await EzConfig.setDouble(lightSpacingKey, 35.0);
      }
      await EzConfig.setBool(lightShowBackFABKey, false);
      await EzConfig.setBool(lightShowScrollKey, false);
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
              side: EzConfig.borderSide(darkOutline),
              shape: EzConfig.buttonShape.shape,
              textStyle: localBody,
              padding: EdgeInsets.all(EzConfig.onMobile ? 17.5 : 20.0),
            )
          : ElevatedButton.styleFrom(
              backgroundColor: lightSurface,
              foregroundColor: Colors.black,
              shadowColor: Colors.transparent,
              iconColor: Colors.black,
              overlayColor: Colors.black,
              side: EzConfig.borderSide(lightOutline),
              shape: EzConfig.buttonShape.shape,
              textStyle: localBody,
              padding: EdgeInsets.all(EzConfig.onMobile ? 17.5 : 20.0),
            ),
      onPressed: () async {
        await onPressed();
        await onComplete();
      },
      text: EzConfig.l10n.ssHighVisibility,
      textStyle: localBody,
    );
  }
}
