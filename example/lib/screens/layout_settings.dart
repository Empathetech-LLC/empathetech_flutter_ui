/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class LayoutSettingsScreen extends StatefulWidget {
  const LayoutSettingsScreen({super.key});

  @override
  State<LayoutSettingsScreen> createState() => _LayoutSettingsScreenState();
}

class _LayoutSettingsScreenState extends State<LayoutSettingsScreen> {
  // Gather the theme data //

  late bool isDark = PlatformTheme.of(context)!.isDark;

  final double margin = EzConfig.get(marginKey);
  final double spacing = EzConfig.get(spacingKey);

  late final EzSpacer spacer = EzSpacer(spacing);
  late final EzSpacer separator = EzSpacer(2 * spacing);

  late final EFUILang l10n = EFUILang.of(context)!;

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPageTitle(l10n.lsPageTitle);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      body: EzScreen(
        decorationImageKey: isDark ? darkPageImageKey : lightPageImageKey,
        child: EzScrollView(
          children: <Widget>[
            if (spacing > margin) EzSpacer(spacing - margin),
            // Margin
            const EzLayoutSetting(
              configKey: marginKey,
              type: LayoutSettingType.margin,
              min: minMargin,
              max: maxMargin,
              steps: 10,
              decimals: 1,
            ),
            spacer,

            // Padding
            const EzLayoutSetting(
              configKey: paddingKey,
              type: LayoutSettingType.padding,
              min: minPadding,
              max: maxPadding,
              steps: 10,
              decimals: 1,
            ),
            spacer,

            // Spacing
            const EzLayoutSetting(
              configKey: spacingKey,
              type: LayoutSettingType.spacing,
              min: minSpacing,
              max: maxSpacing,
              steps: 18,
              decimals: 0,
            ),
            separator,

            // Local reset all
            EzResetButton(
              dialogTitle: l10n.lsResetAll,
              onConfirm: () => EzConfig.removeKeys(layoutKeys.keys.toSet()),
            ),
            separator,

            // Help
            EzLink(
              EFUILang.of(context)!.gHowThisWorks,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
              url: Uri.parse(understandingLayout),
              semanticsLabel: EFUILang.of(context)!.gHowThisWorksHint,
              tooltip: understandingLayout,
            ),
            spacer,
          ],
        ),
      ),
    );
  }
}
