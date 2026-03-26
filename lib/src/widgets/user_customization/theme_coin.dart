/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzThemeCoin extends StatefulWidget {
  /// [EzIconButton] for toggling [EzConfig.updateBoth]
  const EzThemeCoin({super.key});

  @override
  State<EzThemeCoin> createState() => _EzThemeCoinState();
}

class _EzThemeCoinState extends State<EzThemeCoin> {
  bool both = EzConfig.updateBoth;

  @override
  Widget build(BuildContext context) {
    final IconData icon = both
        ? Icons.contrast
        : (EzConfig.isDark ? Icons.dark_mode : Icons.light_mode);

    final String editing = EzConfig.l10n.gEditing +
        (both
            ? EzConfig.l10n.gBothThemes
            : (EzConfig.isDark
                ? EzConfig.l10n.gDarkTheme
                : EzConfig.l10n.gLightTheme));
    final String reverse = both
        ? (EzConfig.isDark
            ? '${EzConfig.l10n.gThe} ${EzConfig.l10n.gDarkTheme.toLowerCase()}'
            : '${EzConfig.l10n.gThe} ${EzConfig.l10n.gLightTheme.toLowerCase()}')
        : EzConfig.l10n.gBothThemes;

    return Semantics(
      button: true,
      hint: '$editing. ${EzConfig.l10n.gEditingHint} $reverse.',
      child: ExcludeSemantics(
        child: EzIconButton(
          icon: Icon(icon),
          onPressed: () async {
            await EzConfig.setBool(updateBothKey, !both);
            setState(() => both = !both);
          },
          tooltip: editing,
        ),
      ),
    );
  }
}
