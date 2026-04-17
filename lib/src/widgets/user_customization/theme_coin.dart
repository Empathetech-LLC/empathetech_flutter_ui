/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EzThemeCoin extends StatefulWidget {
  final bool enabled;

  /// [EzIconButton] for toggling [EzConfig.updateBoth]
  const EzThemeCoin({super.key, this.enabled = true});

  @override
  State<EzThemeCoin> createState() => _EzThemeCoinState();
}

class _EzThemeCoinState extends State<EzThemeCoin> {
  bool both = EzConfig.updateBoth;

  @override
  Widget build(BuildContext context) {
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
          enabled: widget.enabled,
          icon: (widget.enabled && both)
              ? const FaIcon(FontAwesomeIcons.yinYang)
              : Icon(EzConfig.isDark ? Icons.dark_mode : Icons.light_mode),
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
