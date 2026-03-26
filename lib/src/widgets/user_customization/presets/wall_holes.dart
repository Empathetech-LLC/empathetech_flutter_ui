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

  static Future<void> onPressed(BuildContext context) async {
    if (EzConfig.updateBoth || EzConfig.isDark) {
      // Update colors //

      // Update design //

      await EzConfig.setString(
          darkTransitionTypeKey, EzPageTransition.flip.value);
      await EzConfig.setBool(darkTransitionFadeKey, true);

      await EzConfig.setString(darkBackgroundImageKey, whackyPath);
      await EzConfig.setString(
          '$darkBackgroundImageKey$boxFitSuffix', BoxFit.cover.name);

      // Update layout //

      // Update text
    }

    if (EzConfig.updateBoth || !EzConfig.isDark) {
      // Update colors //

      // Update design //

      await EzConfig.setString(
          lightTransitionTypeKey, EzPageTransition.flip.value);
      await EzConfig.setBool(lightTransitionFadeKey, true);

      await EzConfig.setString(lightBackgroundImageKey, whackyPath);
      await EzConfig.setString(
          '$lightBackgroundImageKey$boxFitSuffix', BoxFit.cover.name);

      // Update layout //

      // Update text
    }
  }

  @override
  Widget build(BuildContext context) {
    return EzElevatedButton(
      style: ElevatedButton.styleFrom(),
      onPressed: () async => await onPressed(context),
      text: EzConfig.l10n.ssWhacky,
    );
  }
}
