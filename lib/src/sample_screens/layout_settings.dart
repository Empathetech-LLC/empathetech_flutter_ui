/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class LayoutSettings extends StatefulWidget {
  /// For [EzScreen.useImageDecoration]
  final bool useImageDecoration;

  /// Optional additional settings
  final List<Widget>? additionalSettings;

  const LayoutSettings({
    super.key,
    this.useImageDecoration = true,
    this.additionalSettings,
  });

  @override
  State<LayoutSettings> createState() => _LayoutSettingsState();
}

class _LayoutSettingsState extends State<LayoutSettings> {
  // Gather the theme data //

  final double margin = EzConfig.get(marginKey);
  final double spacing = EzConfig.get(spacingKey);

  static const EzSpacer spacer = EzSpacer();
  static const EzSeparator separator = EzSeparator();
  late final EzSpacer marginer = EzSpacer(space: margin);

  late bool isDark = isDarkTheme(context);
  late final EFUILang l10n = EFUILang.of(context)!;

  late final TextStyle style = Theme.of(context).textTheme.bodyLarge!;

  // Define build data //

  bool hideScroll = EzConfig.get(hideScrollKey) ?? false;

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPageTitle(l10n.lsPageTitle, Theme.of(context).colorScheme.primary);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return EzScreen(
      useImageDecoration: widget.useImageDecoration,
      child: EzScrollView(
        children: <Widget>[
          if (spacing > margin) EzSpacer(space: spacing - margin),

          // Margin
          const EzLayoutSetting(
            configKey: marginKey,
            type: LayoutSettingType.margin,
            min: minMargin,
            max: maxMargin,
            steps: 6,
            decimals: 1,
          ),
          spacer,

          // Padding
          const EzLayoutSetting(
            configKey: paddingKey,
            type: LayoutSettingType.padding,
            min: minPadding,
            max: maxPadding,
            steps: 12,
            decimals: 1,
          ),
          spacer,

          // Spacing
          const EzLayoutSetting(
            configKey: spacingKey,
            type: LayoutSettingType.spacing,
            min: minSpacing,
            max: maxSpacing,
            steps: 13,
            decimals: 0,
          ),
          separator,

          // Hide scroll
          EzRow(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              marginer,
              EzTextBackground(
                Text(
                  'Hide scroll bars?',
                  style: style,
                  textAlign: TextAlign.center,
                ),
              ),
              marginer,
              Checkbox(
                value: hideScroll,
                onChanged: (bool? value) async {
                  if (value == null) return;
                  await EzConfig.setBool(hideScrollKey, value);
                  setState(() => hideScroll = value);
                },
              ),
            ],
          ),
          separator,

          // Additional settings
          if (widget.additionalSettings != null) ...<Widget>[
            ...widget.additionalSettings!,
            separator,
          ],

          // Local reset all
          EzResetButton(
            dialogTitle: l10n.lsResetAll,
            onConfirm: () async {
              await EzConfig.removeKeys(layoutKeys.keys.toSet());
            },
          ),
          spacer,
        ],
      ),
    );
  }
}
