/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class LayoutSettings extends StatefulWidget {
  /// Dark theme value for [EzScreen.decorationImageKey]
  final String? darkBackgroundImageKey;

  /// Light theme value for [EzScreen.decorationImageKey]
  final String? lightBackgroundImageKey;

  const LayoutSettings({
    super.key,
    this.darkBackgroundImageKey,
    this.lightBackgroundImageKey,
  });

  @override
  State<LayoutSettings> createState() => _LayoutSettingsState();
}

class _LayoutSettingsState extends State<LayoutSettings> {
  // Gather the theme data //

  late bool isDark = PlatformTheme.of(context)!.isDark;

  final double margin = EzConfig.get(marginKey);
  final double spacing = EzConfig.get(spacingKey);

  static const EzSpacer spacer = EzSpacer();
  static const EzSeparator separator = EzSeparator();

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
    return EzScreen.hScroll(
      decorationImageKey: isDark
          ? widget.darkBackgroundImageKey
          : widget.lightBackgroundImageKey,
      kid: EzScrollView(
        children: <Widget>[
          if (spacing > margin) EzSpacer(space: spacing - margin),
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
            onConfirm: () async {
              await EzConfig.removeKeys(layoutKeys.keys.toSet());
            },
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
    );
  }
}
