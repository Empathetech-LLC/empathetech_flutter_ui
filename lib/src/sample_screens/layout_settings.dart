/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzLayoutSettings extends StatefulWidget {
  /// [EzScreen.useImageDecoration] passthrough
  final bool useImageDecoration;

  /// Optional additional settings
  /// Will appear just above the reset button
  /// A trailing [EzSeparator] will be added automatically
  final List<Widget>? additionalSettings;

  /// Empathetech layout settings
  /// Recommended to use as a [Scaffold.body]
  const EzLayoutSettings({
    super.key,
    this.useImageDecoration = true,
    this.additionalSettings,
  });

  @override
  State<EzLayoutSettings> createState() => _EzLayoutSettingsState();
}

class _EzLayoutSettingsState extends State<EzLayoutSettings> {
  // Gather the theme data //

  final double margin = EzConfig.get(marginKey);
  final double spacing = EzConfig.get(spacingKey);

  static const EzSpacer spacer = EzSpacer();
  static const EzSeparator separator = EzSeparator();

  late bool isDark = isDarkTheme(context);
  late final EFUILang l10n = ezL10n(context);

  late final TextStyle style = Theme.of(context).textTheme.bodyLarge!;

  // Define build data //

  bool hideScroll = EzConfig.get(hideScrollKey) ?? false;

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ezWindowNamer(context, l10n.lsPageTitle);
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
            type: EzLayoutSettingType.margin,
            min: minMargin,
            max: maxMargin,
            steps: 6,
            decimals: 1,
          ),
          spacer,

          // Padding
          const EzLayoutSetting(
            configKey: paddingKey,
            type: EzLayoutSettingType.padding,
            min: minPadding,
            max: maxPadding,
            steps: 12,
            decimals: 1,
          ),
          spacer,

          // Spacing
          const EzLayoutSetting(
            configKey: spacingKey,
            type: EzLayoutSettingType.spacing,
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
              Flexible(
                child: EzText(
                  l10n.lsScroll,
                  style: style,
                  textAlign: TextAlign.center,
                ),
              ),
              EzCheckbox(
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
          separator,
        ],
      ),
    );
  }
}
