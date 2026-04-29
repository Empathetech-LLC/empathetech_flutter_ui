/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzBigButtonsConfig extends StatelessWidget {
  /// Doesn't replace, only modifies: larger touch points from default
  /// Slight bump to all layout values, for easier tapping
  const EzBigButtonsConfig({super.key});

  static Future<void> onPressed() async {
    // Don't reset //

    if (EzConfig.updateBoth || EzConfig.isDark) {
      // Design settings //

      await EzConfig.setDouble(darkMarginKey, 12.0);
      if (EzConfig.onMobile) {
        await EzConfig.setDouble(darkPaddingKey, 21.0);
        await EzConfig.setDouble(darkSpacingKey, 30.0);
      } else {
        await EzConfig.setDouble(darkPaddingKey, 24.0);
        await EzConfig.setDouble(darkSpacingKey, 36.0);
      }

      await EzConfig.setBool(darkShowBackFABKey, true);

      await EzConfig.setString(darkButtonShapeKey, EzButtonShape.roundRect.value);

      await EzConfig.setBool(darkShowScrollKey, true);

      // Text settings //

      if (EzConfig.iconSize < 25.0) {
        await EzConfig.setDouble(darkIconSizeKey, 25.0);
      }
    }

    if (EzConfig.updateBoth || !EzConfig.isDark) {
      // Design settings //

      await EzConfig.setDouble(lightMarginKey, 12.0);
      if (EzConfig.onMobile) {
        await EzConfig.setDouble(lightPaddingKey, 21.0);
        await EzConfig.setDouble(lightSpacingKey, 30.0);
      } else {
        await EzConfig.setDouble(lightPaddingKey, 24.0);
        await EzConfig.setDouble(lightSpacingKey, 36.0);
      }

      await EzConfig.setBool(lightShowBackFABKey, true);

      await EzConfig.setString(lightButtonShapeKey, EzButtonShape.roundRect.value);

      await EzConfig.setBool(lightShowScrollKey, true);

      // Text settings //

      if (EzConfig.iconSize < 25.0) {
        await EzConfig.setDouble(lightIconSizeKey, 25.0);
      }
    }
  }

  @override
  Widget build(BuildContext context) => EzElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: EzButtonShape.roundRect.shape,
          padding: EdgeInsets.all(EzConfig.onMobile ? 22.5 : 25.0),
        ),
        onPressed: () async {
          await onPressed();
          await EzConfig.rebuildUI();
        },
        text: EzConfig.l10n.ssBigButtons,
      );
}
