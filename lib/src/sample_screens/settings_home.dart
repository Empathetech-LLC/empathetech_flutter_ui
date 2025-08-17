/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

class EzSettingsHome extends StatefulWidget {
  /// Optionally remove 'Have fun!' part of the settings disclaimer
  /// There are some apps where fun is not appropriate
  final bool notFun;

  /// Locales to skip in the [EzLocaleSetting]
  /// Defaults to [english] to not dupe [americanEnglish]
  final Set<Locale>? skipLocales;

  /// [EzLocaleSetting.protest] passthrough
  final bool protest;

  /// [EzLocaleSetting.inDistress] passthrough
  final Set<String> inDistress;

  /// Spacer between the [EzLocaleSetting] and the next block
  /// [additionalSettings] if present, the navigation buttons if not
  final Widget localeSpacer;

  /// [Widget]s to be added below the [EzLocaleSetting] and above the navigation buttons
  /// See [localeSpacer] and [preNavSpacer] for layout tuning
  final List<Widget>? additionalSettings;

  /// If [additionalSettings] is not null, the spacer between it and the navigation buttons
  final Widget preNavSpacer;

  /// [GoRouter.goNamed] path to the text settings screen
  /// If null, no button will appear
  final String? textSettingsPath;

  /// [GoRouter.goNamed] path to the layout settings screen
  /// If null, no button will appear
  final String? layoutSettingsPath;

  /// [GoRouter.goNamed] path to the color settings screen
  /// If null, no button will appear
  final String? colorSettingsPath;

  /// [GoRouter.goNamed] path to the image settings screen
  /// If null, no button will appear
  final String? imageSettingsPath;

  /// Widgets to be added below any present routes and above randomize
  /// See [randomSpacer] and/or [resetSpacer] for layout tuning
  final List<Widget>? additionalRoutes;

  /// Spacer before the [EzQuickConfig]
  /// If null, [EzQuickConfig] will not be included
  final Widget? quickConfigSpacer;

  /// Spacer before the [EzConfigRandomizer]
  /// If null, [EzConfigRandomizer] will not be included
  final Widget? randomSpacer;

  /// Spacer before the [EzResetButton]
  /// [EzResetButton] is always included
  final Widget resetSpacer;

  /// [EzResetButton.skip] passthrough
  final Set<String>? skipKeys;

  /// Spacer before the [footer], if present
  final Widget footerSpacer;

  /// Widgets to be added below reset
  /// Do not include a trailing spacer, one will be provided
  final List<Widget>? footer;

  /// Empathetech settings landing page
  /// Contains global settings and [EzElevatedIconButton]s that lead to the rest of the settings pages
  /// Recommended to use as a [Scaffold.body]
  const EzSettingsHome({
    super.key,
    this.notFun = false,
    this.skipLocales,
    this.protest = false,
    this.inDistress = const <String>{'US'},
    this.localeSpacer = const EzDivider(),
    this.additionalSettings,
    this.preNavSpacer = const EzSeparator(),
    required this.textSettingsPath,
    required this.layoutSettingsPath,
    required this.colorSettingsPath,
    required this.imageSettingsPath,
    this.additionalRoutes,
    this.quickConfigSpacer = const EzDivider(),
    this.randomSpacer = const EzSpacer(),
    this.resetSpacer = const EzSpacer(),
    this.skipKeys,
    this.footerSpacer = const EzSeparator(),
    this.footer,
  });

  @override
  State<EzSettingsHome> createState() => _EzSettingsHomeState();
}

class _EzSettingsHomeState extends State<EzSettingsHome> {
  // Gather the fixed theme data //

  static const EzSpacer spacer = EzSpacer();
  static const EzSeparator separator = EzSeparator();

  late final double spacing = EzConfig.get(spacingKey);

  late final EFUILang l10n = ezL10n(context);

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ezWindowNamer(context, l10n.ssPageTitle);
  }

  // Define custom functions //

  List<Widget> navButtons() {
    late final Widget navIcon = EzIcon(Icons.navigate_next);
    final List<Widget> buttons = <Widget>[];

    if (widget.textSettingsPath != null) {
      buttons.add(EzElevatedIconButton(
        onPressed: () => context.goNamed(widget.textSettingsPath!),
        icon: navIcon,
        label: l10n.tsPageTitle,
      ));
    }

    if (widget.layoutSettingsPath != null) {
      if (buttons.isNotEmpty) buttons.add(spacer);

      buttons.add(EzElevatedIconButton(
        onPressed: () => context.goNamed(widget.layoutSettingsPath!),
        icon: navIcon,
        label: l10n.lsPageTitle,
      ));
    }

    if (widget.colorSettingsPath != null) {
      if (buttons.isNotEmpty) buttons.add(spacer);

      buttons.add(EzElevatedIconButton(
        onPressed: () => context.goNamed(widget.colorSettingsPath!),
        icon: navIcon,
        label: l10n.csPageTitle,
      ));
    }

    if (widget.imageSettingsPath != null) {
      if (buttons.isNotEmpty) buttons.add(spacer);

      buttons.add(EzElevatedIconButton(
        onPressed: () => context.goNamed(widget.imageSettingsPath!),
        icon: navIcon,
        label: l10n.isPageTitle,
      ));
    }

    if (widget.additionalRoutes != null) {
      if (buttons.isNotEmpty) buttons.add(spacer);
      buttons.addAll(widget.additionalRoutes!);
    }

    return buttons;
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return EzScrollView(
      children: <Widget>[
        // Restart disclaimer
        EzWarning(widget.notFun
            ? (kIsWeb
                ? l10n.ssSettingsGuideWeb.split('\n').first
                : l10n.ssSettingsGuide.split('\n').first)
            : (kIsWeb ? l10n.ssSettingsGuideWeb : l10n.ssSettingsGuide)),
        separator,

        // Right/left
        const EzDominantHandSwitch(),
        spacer,

        // Theme mode
        const EzThemeModeSwitch(),
        spacer,

        // Language
        EzLocaleSetting(
          skip: widget.skipLocales ?? <Locale>{english},
          protest: widget.protest,
          inDistress: widget.inDistress,
        ),
        widget.localeSpacer,

        // Additional settings
        if (widget.additionalSettings != null) ...<Widget>[
          ...widget.additionalSettings!,
          widget.preNavSpacer,
        ],

        // Navigation buttons
        ...navButtons(),

        // Quick config
        if (widget.quickConfigSpacer != null) ...<Widget>[
          widget.quickConfigSpacer!,
          const EzQuickConfig(),
        ],

        // Feeling lucky
        if (widget.randomSpacer != null) ...<Widget>[
          widget.randomSpacer!,
          const EzConfigRandomizer(),
        ],

        // Reset button
        widget.resetSpacer,
        EzResetButton(skip: widget.skipKeys),

        // Footer
        if (widget.footer != null) ...<Widget>[
          widget.footerSpacer,
          ...widget.footer!,
        ],
        separator,
      ],
    );
  }
}
