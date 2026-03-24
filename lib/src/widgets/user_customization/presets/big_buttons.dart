/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzBigButtonsConfig extends StatelessWidget {
  /// Only runs if you're using the rendered [Widget]
  /// Calling [onPressed] does not trigger [onComplete]
  final Future<void> Function() onComplete;

  /// Only modifies the layout settings and icon size
  /// Slight bump to all layout values, for easier tapping
  const EzBigButtonsConfig(this.onComplete, {super.key});

  static Future<void> onPressed() async {
    if (EzConfig.updateBoth || EzConfig.isDark) {
      // Update layout
      await EzConfig.setDouble(darkMarginKey, 12.5);
      if (EzConfig.onMobile) {
        await EzConfig.setDouble(darkPaddingKey, 22.5);
        await EzConfig.setDouble(darkSpacingKey, 35.0);
      } else {
        await EzConfig.setDouble(darkPaddingKey, 25.0);
        await EzConfig.setDouble(darkSpacingKey, 40.0);
      }
      await EzConfig.setBool(darkShowBackFABKey, true);
      await EzConfig.setBool(darkShowScrollKey, true);

      // Conditionally update text
      if (EzConfig.iconSize < 25.0) {
        await EzConfig.setDouble(darkIconSizeKey, 25.0);
      }
    }

    if (EzConfig.updateBoth || !EzConfig.isDark) {
      // Update layout
      await EzConfig.setDouble(lightMarginKey, 12.5);
      if (EzConfig.onMobile) {
        await EzConfig.setDouble(lightPaddingKey, 22.5);
        await EzConfig.setDouble(lightSpacingKey, 35.0);
      } else {
        await EzConfig.setDouble(lightPaddingKey, 25.0);
        await EzConfig.setDouble(lightSpacingKey, 40.0);
      }
      await EzConfig.setBool(lightShowBackFABKey, true);
      await EzConfig.setBool(lightShowScrollKey, true);

      // Conditionally update text
      if (EzConfig.iconSize < 25.0) {
        await EzConfig.setDouble(lightIconSizeKey, 25.0);
      }
    }
  }

  @override
  Widget build(BuildContext context) => EzElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(EzConfig.onMobile ? 22.5 : 25.0),
        ),
        onPressed: () async {
          await onPressed();
          await onComplete();
        },
        text: EzConfig.l10n.ssBigButtons,
      );
}
