/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzDesignSettings extends StatefulWidget {
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
  /// [darkImageKeys] or [lightImageKeys] are included by default
  final Set<String>? resetKeys;

  /// Empathetech image settings
  /// Recommended to use as a [Scaffold.body]
  const EzDesignSettings({
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
  State<EzDesignSettings> createState() => _EzDesignSettingsState();
}

class _EzDesignSettingsState extends State<EzDesignSettings> {
  // Gather the fixed theme data //

  static const EzSeparator separator = EzSeparator();
  final EzSpacer margin = EzMargin();

  late final EFUILang l10n = ezL10n(context);

  // Define the build data //

  bool clearColors = false;
  int redraw = 0;

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ezWindowNamer(context, l10n.dsPageTitle);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    final bool isDark = isDarkTheme(context);
    final String themeProfile =
        isDark ? l10n.gDark.toLowerCase() : l10n.gLight.toLowerCase();

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

        // After background
        if (widget.afterBackground != null) ...<Widget>[
          widget.postfixSpacer,
          ...widget.afterBackground!,
        ],

        // TODO: Wrap in conditionals/spacers
        // Hide scroll
        separator,
        EzSwitchPair(
          key: ValueKey<String>('scroll_$redraw'),
          text: l10n.lsScroll,
          valueKey: hideScrollKey,
        ),

        // Local reset all
        widget.resetSpacer,
        EzElevatedIconButton(
          icon: EzIcon(PlatformIcons(context).refresh),
          label: l10n.gResetAll,
          onPressed: () => showPlatformDialog(
            context: context,
            builder: (BuildContext dialogContext) =>
                StatefulBuilder(builder: (_, StateSetter dialogState) {
              late final List<Widget> materialActions;
              late final List<Widget> cupertinoActions;

              (materialActions, cupertinoActions) = ezActionPairs(
                context: context,
                onConfirm: () async {
                  await EzConfig.removeKeys(
                    isDark ? darkImageKeys : lightImageKeys,
                  );

                  if (clearColors) {
                    await EzConfig.removeKeys(
                      isDark ? darkColorKeys.toSet() : lightColorKeys.toSet(),
                    );
                    await EzConfig.remove(
                      isDark
                          ? darkTextBackgroundOpacityKey
                          : lightTextBackgroundOpacityKey,
                    );
                  }

                  if (widget.resetKeys != null) {
                    await EzConfig.removeKeys(widget.resetKeys!);
                  }

                  if (dialogContext.mounted) {
                    Navigator.of(dialogContext).pop();
                  }
                  setState(() => redraw = Random().nextInt(rMax));
                },
                confirmIsDestructive: true,
                onDeny: () => Navigator.of(dialogContext).pop(),
              );

              return EzAlertDialog(
                title: Text(
                  l10n.dsResetAll(themeProfile),
                  textAlign: TextAlign.center,
                ),
                contents: <Widget>[
                  EzSwitchPair(
                    key: ValueKey<bool>(clearColors),
                    text: l10n.dsAndColors(themeProfile),
                    textAlign: TextAlign.center,
                    value: clearColors,
                    onChanged: (bool? choice) {
                      clearColors = (choice == null) ? false : choice;
                      dialogState(() {});
                      setState(() {});
                    },
                  ),
                  const EzSpacer(),
                  Text(
                    l10n.gUndoWarn,
                    textAlign: TextAlign.center,
                  ),
                ],
                materialActions: materialActions,
                cupertinoActions: cupertinoActions,
                needsClose: false,
              );
            }),
          ),
        ),
        separator,
      ],
    );
  }
}
