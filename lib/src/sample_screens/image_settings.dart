/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

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
  /// [darkImageKeys] or [lightImageKeys] are included by default
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

  bool clearColors = false;

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
                  setState(() {});
                },
                confirmIsDestructive: true,
                onDeny: () => Navigator.of(dialogContext).pop(),
              );

              return EzAlertDialog(
                title: Text(
                  l10n.isResetAll(themeProfile),
                  textAlign: TextAlign.center,
                ),
                contents: <Widget>[
                  EzSwitchPair(
                    key: ValueKey<bool>(clearColors),
                    text: l10n.isAndColors(themeProfile),
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
