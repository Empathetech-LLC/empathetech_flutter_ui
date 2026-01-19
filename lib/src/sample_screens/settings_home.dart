/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:go_router/go_router.dart';

class EzSettingsHome extends StatefulWidget {
  /// Optionally remove the 'Have fun!' part of the settings disclaimer
  /// There are apps where it's not appropriate
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
  /// BYO trailing spacer, see [localeSpacer] for leading spacer
  final List<Widget>? additionalSettings;

  /// [GoRouter.goNamed] path or URL to the color settings screen
  /// If a URL string is provided, the [EzElevatedIconButton] will be wrapped in a [Link]
  /// If null, no button will appear
  final String? colorSettingsPath;

  /// [GoRouter.goNamed] path or URL to the design settings screen
  /// If a URL string is provided, the [EzElevatedIconButton] will be wrapped in a [Link]
  /// If null, no button will appear
  final String? designSettingsPath;

  /// [GoRouter.goNamed] path or URL to the layout settings screen
  /// If a URL string is provided, the [EzElevatedIconButton] will be wrapped in a [Link]
  /// If null, no button will appear
  final String? layoutSettingsPath;

  /// [GoRouter.goNamed] path or URL to the text settings screen
  /// If a URL string is provided, the [EzElevatedIconButton] will be wrapped in a [Link]
  /// If null, no button will appear
  final String? textSettingsPath;

  /// Widgets to be added directly below any present routes
  /// BYO leading spacer, trailing spacer will be one of the parameters below
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

  /// [EzConfigRandomizer.extraKeys] passthrough
  final List<String>? extraKeys;

  /// [EzConfigRandomizer.appName] passthrough
  final String appName;

  /// [EzConfigRandomizer.androidPackage] passthrough
  final String? androidPackage;

  /// Widgets to be added below the [EzResetButton]
  /// BYO leading spacer, trailing is always [EzSeparator]
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
    required this.colorSettingsPath,
    required this.designSettingsPath,
    required this.layoutSettingsPath,
    required this.textSettingsPath,
    this.additionalRoutes,
    this.quickConfigSpacer = const EzDivider(),
    this.randomSpacer = const EzSpacer(),
    this.extraKeys,
    required this.appName,
    this.androidPackage,
    this.resetSpacer = const EzSpacer(),
    this.skipKeys,
    this.footer,
  });

  @override
  State<EzSettingsHome> createState() => _EzSettingsHomeState();
}

class _EzSettingsHomeState extends State<EzSettingsHome> {
  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ezWindowNamer(context, EzConfig.l10n.ssPageTitle);
  }

  // Define custom functions //

  List<Widget> navButtons() {
    final List<Widget> buttons = <Widget>[];
    const Widget navIcon = Icon(Icons.navigate_next);

    if (widget.colorSettingsPath != null) {
      ezUrlCheck(widget.colorSettingsPath!)
          ? buttons.add(Link(
              uri: Uri.parse(widget.colorSettingsPath!),
              builder: (_, FollowLink? followLink) => EzElevatedIconButton(
                onPressed: followLink,
                icon: navIcon,
                label: EzConfig.l10n.csPageTitle,
              ),
            ))
          : buttons.add(EzElevatedIconButton(
              onPressed: () => context.goNamed(widget.colorSettingsPath!),
              icon: navIcon,
              label: EzConfig.l10n.csPageTitle,
            ));
    }

    if (widget.designSettingsPath != null) {
      if (buttons.isNotEmpty) buttons.add(EzConfig.spacer);

      ezUrlCheck(widget.designSettingsPath!)
          ? buttons.add(Link(
              uri: Uri.parse(widget.designSettingsPath!),
              builder: (_, FollowLink? followLink) => EzElevatedIconButton(
                onPressed: followLink,
                icon: navIcon,
                label: EzConfig.l10n.dsPageTitle,
              ),
            ))
          : buttons.add(EzElevatedIconButton(
              onPressed: () => context.goNamed(widget.designSettingsPath!),
              icon: navIcon,
              label: EzConfig.l10n.dsPageTitle,
            ));
    }

    if (widget.layoutSettingsPath != null) {
      if (buttons.isNotEmpty) buttons.add(EzConfig.spacer);

      ezUrlCheck(widget.layoutSettingsPath!)
          ? buttons.add(Link(
              uri: Uri.parse(widget.layoutSettingsPath!),
              builder: (_, FollowLink? followLink) => EzElevatedIconButton(
                onPressed: followLink,
                icon: navIcon,
                label: EzConfig.l10n.lsPageTitle,
              ),
            ))
          : buttons.add(EzElevatedIconButton(
              onPressed: () => context.goNamed(widget.layoutSettingsPath!),
              icon: navIcon,
              label: EzConfig.l10n.lsPageTitle,
            ));
    }

    if (widget.textSettingsPath != null) {
      if (buttons.isNotEmpty) buttons.add(EzConfig.spacer);

      ezUrlCheck(widget.textSettingsPath!)
          ? buttons.add(Link(
              uri: Uri.parse(widget.textSettingsPath!),
              builder: (_, FollowLink? followLink) => EzElevatedIconButton(
                onPressed: followLink,
                icon: navIcon,
                label: EzConfig.l10n.tsPageTitle,
              ),
            ))
          : buttons.add(EzElevatedIconButton(
              onPressed: () => context.goNamed(widget.textSettingsPath!),
              icon: navIcon,
              label: EzConfig.l10n.tsPageTitle,
            ));
    }

    if (widget.additionalRoutes != null) {
      buttons.addAll(widget.additionalRoutes!);
    }

    return buttons;
  }

  // Return the build //

  @override
  Widget build(BuildContext context) => EzScrollView(
        children: <Widget>[
          EzHeader(),

          // Right/left
          const EzDominantHandSwitch(),
          EzConfig.spacer,

          // Theme mode
          const EzThemeModeSwitch(),
          EzConfig.spacer,

          // Language
          EzLocaleSetting(
            skip: widget.skipLocales ?? <Locale>{english},
            protest: widget.protest,
            inDistress: widget.inDistress,
          ),
          widget.localeSpacer,

          // Additional settings
          if (widget.additionalSettings != null) ...widget.additionalSettings!,

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
            EzConfigRandomizer(
              extraKeys: widget.extraKeys,
              appName: widget.appName,
              androidPackage: widget.androidPackage,
            ),
          ],

          // Reset button
          widget.resetSpacer,
          EzResetButton(
            androidPackage: widget.androidPackage,
            appName: widget.appName,
            extraKeys: widget.extraKeys,
            skip: widget.skipKeys,
          ),

          // Footer
          if (widget.footer != null) ...widget.footer!,
          EzConfig.separator,
        ],
      );
}
