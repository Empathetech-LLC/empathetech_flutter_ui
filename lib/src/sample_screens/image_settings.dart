/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzImageSettings extends StatefulWidget {
  /// Optional additional settings
  /// Before the main settings
  /// See [prefixSpacer] for layout tuning
  final List<Widget>? beforeBackground;

  /// If [beforeBackground] is not null, the spacer between it and the main settings
  final Widget prefixSpacer;

  /// Optional credits for dark background image
  final String? darkBackgroundCredits;

  /// Optional credits for light background image
  final String? lightBackgroundCredits;

  /// Spacer between the main settings and [afterBackground], if present
  final Widget postfixSpacer;

  /// Optional additional settings
  /// After the main settings
  /// See [postfixSpacer] and [resetSpacer] for layout tuning
  final List<Widget>? afterBackground;

  /// Spacer between the main (or [afterBackground], if present) settings and the trailing [EzResetButton]
  final Widget resetSpacer;

  /// Additional [EzConfig] keys for the local [EzResetButton]
  /// [imageKeys] are included by default
  final Set<String>? resetKeys;

  /// Empathetech image settings
  /// Recommended to use as a [Scaffold.body]
  const EzImageSettings({
    super.key,
    this.beforeBackground,
    this.prefixSpacer = const EzSeparator(),
    this.darkBackgroundCredits,
    this.lightBackgroundCredits,
    this.postfixSpacer = const EzSeparator(),
    this.afterBackground,
    this.resetSpacer = const EzSeparator(),
    this.resetKeys,
  });

  @override
  State<EzImageSettings> createState() => _EzImageSettingsState();
}

class _EzImageSettingsState extends State<EzImageSettings> {
  // Gather the theme data //

  static const EzSeparator separator = EzSeparator();

  final EzSpacer margin = EzMargin();

  late bool isDark = isDarkTheme(context);
  late final EFUILang l10n = ezL10n(context);

  // Define the build data //

  late final String themeProfile =
      isDark ? l10n.gDark.toLowerCase() : l10n.gLight.toLowerCase();

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ezWindowNamer(context, l10n.isPageTitle);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return EzScrollView(
      children: <Widget>[
        // Current theme reminder
        EzText(
          l10n.gEditingTheme(themeProfile),
          style: Theme.of(context).textTheme.labelLarge,
          textAlign: TextAlign.center,
        ),
        margin,

        // Before background
        if (widget.beforeBackground != null) ...<Widget>[
          ...widget.beforeBackground!,
          widget.prefixSpacer,
        ],

        // Background
        EzScrollView(
          scrollDirection: Axis.horizontal,
          startCentered: true,
          mainAxisSize: MainAxisSize.min,
          child: isDark
              ? EzImageSetting(
                  key: UniqueKey(),
                  configKey: darkBackgroundImageKey,
                  credits: widget.darkBackgroundCredits,
                  label: l10n.isBackground,
                  updateTheme: Brightness.dark,
                )
              : EzImageSetting(
                  key: UniqueKey(),
                  configKey: lightBackgroundImageKey,
                  credits: widget.lightBackgroundCredits,
                  label: l10n.isBackground,
                  updateTheme: Brightness.light,
                ),
        ),

        // After background
        if (widget.afterBackground != null) ...<Widget>[
          widget.postfixSpacer,
          ...widget.afterBackground!,
        ],

        // Local reset all
        widget.resetSpacer,
        EzResetButton(
          dialogTitle: l10n.isResetAll(themeProfile),
          onConfirm: () async {
            await EzConfig.removeKeys(imageKeys.keys.toSet());
            if (widget.resetKeys != null) {
              await EzConfig.removeKeys(widget.resetKeys!);
            }
          },
        ),
        separator,
      ],
    );
  }
}
