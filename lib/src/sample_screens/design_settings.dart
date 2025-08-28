/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

// TODO: Update conditionals/spacers
// TODO: l10n

import '../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';

class EzDesignSettings extends StatefulWidget {
  /// Optional additional global design settings
  /// Will appear after the default global design settings
  /// BYO leading spacer, trailing will be a custom [EzDivider]
  final List<Widget>? additionalGlobalSettings;

  /// Optional credits for dark background image
  final String? darkBackgroundCredits;

  /// Optional credits for light background image
  final String? lightBackgroundCredits;

  /// Optional additional theme design settings
  /// Will appear after the default themed design settings
  /// BYO leading spacer, trailing will be [resetSpacer]
  final List<Widget>? additionalThemedSettings;

  /// Spacer before the [EzResetButton]
  final Widget resetSpacer;

  /// Additional [EzConfig] keys for the local [EzResetButton]
  /// [globalDesignKeys] && [darkDesignKeys] are included by default
  final Set<String>? darkThemeResetKeys;

  /// Additional [EzConfig] keys for the local [EzResetButton]
  /// [globalDesignKeys] && [lightDesignKeys] are included by default
  final Set<String>? lightThemeResetKeys;

  /// Empathetech image settings
  /// Recommended to use as a [Scaffold.body]
  const EzDesignSettings({
    super.key,
    this.additionalGlobalSettings,
    this.darkBackgroundCredits,
    this.lightBackgroundCredits,
    this.additionalThemedSettings,
    this.resetSpacer = const EzSeparator(),
    this.darkThemeResetKeys,
    this.lightThemeResetKeys,
  });

  @override
  State<EzDesignSettings> createState() => _EzDesignSettingsState();
}

class _EzDesignSettingsState extends State<EzDesignSettings> {
  // Gather the fixed theme data //

  static const EzSpacer spacer = EzSpacer();
  static const EzSeparator separator = EzSeparator();

  final double margin = EzConfig.get(marginKey);

  late final EFUILang l10n = ezL10n(context);

  // Define the build data //

  int redraw = 0;
  double animDuration = EzConfig.get(animationDurationKey);

  late final String darkString = l10n.gDark.toLowerCase();
  late final String lightString = l10n.gLight.toLowerCase();

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ezWindowNamer(context, l10n.dsPageTitle);
  }

  @override
  Widget build(BuildContext context) {
    // Gather the dynamic theme data //

    final bool isDark = isDarkTheme(context);
    final String themeProfile =
        isDark ? l10n.gDark.toLowerCase() : l10n.gLight.toLowerCase();

    double buttonOpacity = isDark
        ? EzConfig.get(darkButtonOpacityKey)
        : EzConfig.get(lightButtonOpacityKey);

    // Return the build //

    return EzScrollView(
      children: <Widget>[
        // Animation duration
        const Text('Animation duration'), // TODO: margin?
        Slider(
          value: animDuration,
          onChanged: (double value) => setState(() => animDuration = value),
          onChangeEnd: (double value) =>
              EzConfig.setDouble(animationDurationKey, value),
        ),

        // App icon TODO

        // Hide scroll
        spacer,
        EzSwitchPair(
          key: ValueKey<String>('scroll_$redraw'),
          text: l10n.lsScroll,
          valueKey: hideScrollKey,
        ),

        // Global/themed divider, w/ theme reminder
        separator,
        EzDivider(height: margin * 2),
        EzText(
          l10n.gEditingTheme(themeProfile),
          style: Theme.of(context).textTheme.labelLarge,
          textAlign: TextAlign.center,
        ),
        separator,

        // Background TODO: Add 'image' to button label
        EzScrollView(
          scrollDirection: Axis.horizontal,
          startCentered: true,
          mainAxisSize: MainAxisSize.min,
          child: isDark
              ? EzImageSetting(
                  key: UniqueKey(),
                  configKey: darkBackgroundImageKey,
                  credits: widget.darkBackgroundCredits,
                  label: l10n.dsBackground,
                  updateTheme: Brightness.dark,
                )
              : EzImageSetting(
                  key: UniqueKey(),
                  configKey: lightBackgroundImageKey,
                  credits: widget.lightBackgroundCredits,
                  label: l10n.dsBackground,
                  updateTheme: Brightness.light,
                ),
        ),
        spacer,

        const Text('Animation duration'), // TODO: margin?
        Slider(
          value: buttonOpacity,
          onChanged: (double value) => setState(() => buttonOpacity = value),
          onChangeEnd: (double value) => EzConfig.setDouble(
            isDark ? darkButtonOpacityKey : lightButtonOpacityKey,
            value,
          ),
        ),
        spacer,

        EzSwitchPair(
          text: 'Include outlines',
          valueKey: isDark ? darkIncludeOutlineKey : lightIncludeOutlineKey,
        ),
        spacer,

        EzSwitchPair(
          text: 'Glass buttons',
          valueKey: isDark ? darkGlassKey : lightGlassKey,
        ), // TODO: enabling this greys out above (not remove, just disable)

        // After background
        if (widget.additionalThemedSettings != null)
          ...widget.additionalThemedSettings!,

        // Reset button
        widget.resetSpacer,
        isDark
            ? EzResetButton(
                dialogTitle: l10n.dsResetAll(darkString),
                onConfirm: () async {
                  await EzConfig.removeKeys(globalDesignKeys.keys.toSet());
                  await EzConfig.removeKeys(darkDesignKeys.keys.toSet());

                  if (widget.darkThemeResetKeys != null) {
                    await EzConfig.removeKeys(widget.darkThemeResetKeys!);
                  }

                  setState(() => redraw = Random().nextInt(rMax));
                },
              )
            : EzResetButton(
                dialogTitle: l10n.dsResetAll(lightString),
                onConfirm: () async {
                  await EzConfig.removeKeys(globalDesignKeys.keys.toSet());
                  await EzConfig.removeKeys(lightDesignKeys.keys.toSet());

                  if (widget.lightThemeResetKeys != null) {
                    await EzConfig.removeKeys(widget.lightThemeResetKeys!);
                  }

                  setState(() => redraw = Random().nextInt(rMax));
                },
              ),
        separator,
      ],
    );
  }
}
