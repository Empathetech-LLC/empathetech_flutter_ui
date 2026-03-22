/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:go_router/go_router.dart';

class EzSettingsHub extends StatefulWidget {
  /// Defaults to [EzHeader] when null
  /// Provide a [SizedBox.shrink] to remove
  final Widget? header;

  /// [EzLocaleSetting.inDistress] passthrough
  final Set<String> inDistress;

  /// Locales to skip in the [EzLocaleSetting]
  /// Defaults to [english] to not dupe [americanEnglish]
  final Set<Locale>? skipLocales;

  /// Spacer between the [EzLocaleSetting] and the next block
  /// [additionalSettings] if present, the navigation buttons if not
  final Widget localeSpacer;

  /// [Widget]s to be added below the [EzLocaleSetting] and above the navigation buttons
  /// BYO trailing spacer, see [localeSpacer] for leading spacer
  final List<Widget>? additionalSettings;

  /// [GoRouter.goNamed] path or URL to the color settings screen
  /// If a URL string is provided, the [EzElevatedIconButton] will be wrapped in a [Link]
  /// If null, no button will appear
  final String colorSettingsPath;

  /// [GoRouter.goNamed] path or URL to the design settings screen
  /// If a URL string is provided, the [EzElevatedIconButton] will be wrapped in a [Link]
  /// If null, no button will appear
  final String designSettingsPath;

  /// [GoRouter.goNamed] path or URL to the layout settings screen
  /// If a URL string is provided, the [EzElevatedIconButton] will be wrapped in a [Link]
  /// If null, no button will appear
  final String layoutSettingsPath;

  /// [GoRouter.goNamed] path or URL to the text settings screen
  /// If a URL string is provided, the [EzElevatedIconButton] will be wrapped in a [Link]
  /// If null, no button will appear
  final String textSettingsPath;

  /// Widgets to be added directly below any present routes
  /// BYO leading spacer, trailing spacer will be one of the parameters below
  final List<Widget>? additionalRoutes;

  /// [EzConfig.saveConfig] passthrough
  final String appName;

  /// [EzConfig.saveConfig] passthrough
  final String? androidPackage;

  /// [EzConfig.saveConfig] passthrough
  final Set<String>? saveSkip;

  /// Spacer before the [EzQuickConfig]
  /// If null, [EzQuickConfig] will not be included
  final Widget? quickConfigSpacer;

  /// Spacer before the [EzConfigRandomizer]
  /// If null, [EzConfigRandomizer] will not be included
  final Widget? randomSpacer;

  /// Spacer before the [EzResetButton]
  /// [EzResetButton] is always included
  final Widget resetSpacer;

  /// [EzResetButton.resetSkip] passthrough
  final Set<String>? resetSkip;

  /// Widgets to be added below the [EzResetButton]
  /// Defaults to an [EzSeparator], if provided BYO trailing spacer
  final List<Widget> footer;

  /// Empathetech settings landing page
  /// Contains global settings and [EzElevatedIconButton]s that lead to the rest of the settings pages
  /// Recommended to use as a [Scaffold.body]
  const EzSettingsHub({
    super.key,
    this.header,
    this.skipLocales,
    this.inDistress = const <String>{'US'},
    this.localeSpacer = const EzDivider(),
    this.additionalSettings,
    required this.colorSettingsPath,
    required this.designSettingsPath,
    required this.layoutSettingsPath,
    required this.textSettingsPath,
    this.additionalRoutes,
    required this.appName,
    this.androidPackage,
    this.saveSkip,
    this.quickConfigSpacer = const EzDivider(),
    this.randomSpacer = const EzSpacer(),
    this.resetSpacer = const EzSpacer(),
    this.resetSkip,
    this.footer = const <Widget>[EzSeparator()],
  });

  @override
  State<EzSettingsHub> createState() => _EzSettingsHubState();
}

class _EzSettingsHubState extends State<EzSettingsHub> {
  // Set the page title //

  @override
  void initState() {
    super.initState();
    ezWindowNamer(EzConfig.l10n.ssPageTitle);
  }

  // Return the build //

  void redraw() => setState(() {});

  @override
  Widget build(BuildContext context) => EzScrollView(children: <Widget>[
        widget.header ?? EzHeader(),

        // Right/left
        EzDominantHandSwitch(redraw),
        EzConfig.spacer,

        // Theme mode
        EzThemeModeSwitch(redraw),
        EzConfig.spacer,

        // Language
        EzLocaleSetting(
          redraw,
          skip: widget.skipLocales ?? <Locale>{english},
          inDistress: widget.inDistress,
        ),
        widget.localeSpacer,

        // Additional settings
        if (widget.additionalSettings != null) ...widget.additionalSettings!,

        // Color nav
        ezUrlCheck(widget.colorSettingsPath)
            ? Link(
                uri: Uri.parse(widget.colorSettingsPath),
                builder: (_, FollowLink? followLink) => EzElevatedIconButton(
                  onPressed: followLink,
                  icon: const Icon(Icons.navigate_next),
                  label: EzConfig.l10n.csPageTitle,
                ),
              )
            : EzElevatedIconButton(
                onPressed: () => context.goNamed(widget.colorSettingsPath),
                icon: const Icon(Icons.navigate_next),
                label: EzConfig.l10n.csPageTitle,
              ),
        EzConfig.spacer,

        // Design nav
        ezUrlCheck(widget.designSettingsPath)
            ? Link(
                uri: Uri.parse(widget.designSettingsPath),
                builder: (_, FollowLink? followLink) => EzElevatedIconButton(
                  onPressed: followLink,
                  icon: const Icon(Icons.navigate_next),
                  label: EzConfig.l10n.dsPageTitle,
                ),
              )
            : EzElevatedIconButton(
                onPressed: () => context.goNamed(widget.designSettingsPath),
                icon: const Icon(Icons.navigate_next),
                label: EzConfig.l10n.dsPageTitle,
              ),
        EzConfig.spacer,

        // Layout nav
        ezUrlCheck(widget.layoutSettingsPath)
            ? Link(
                uri: Uri.parse(widget.layoutSettingsPath),
                builder: (_, FollowLink? followLink) => EzElevatedIconButton(
                  onPressed: followLink,
                  icon: const Icon(Icons.navigate_next),
                  label: EzConfig.l10n.lsPageTitle,
                ),
              )
            : EzElevatedIconButton(
                onPressed: () => context.goNamed(widget.layoutSettingsPath),
                icon: const Icon(Icons.navigate_next),
                label: EzConfig.l10n.lsPageTitle,
              ),
        EzConfig.spacer,

        // Text nav
        ezUrlCheck(widget.textSettingsPath)
            ? Link(
                uri: Uri.parse(widget.textSettingsPath),
                builder: (_, FollowLink? followLink) => EzElevatedIconButton(
                  onPressed: followLink,
                  icon: const Icon(Icons.navigate_next),
                  label: EzConfig.l10n.tsPageTitle,
                ),
              )
            : EzElevatedIconButton(
                onPressed: () => context.goNamed(widget.textSettingsPath),
                icon: const Icon(Icons.navigate_next),
                label: EzConfig.l10n.tsPageTitle,
              ),

        // Additional routes
        if (widget.additionalRoutes != null) ...widget.additionalRoutes!,

        // Quick config
        if (widget.quickConfigSpacer != null) ...<Widget>[
          widget.quickConfigSpacer!,
          EzQuickConfig(redraw),
        ],

        // Feeling lucky
        if (widget.randomSpacer != null) ...<Widget>[
          widget.randomSpacer!,
          EzConfigRandomizer(
            redraw,
            appName: widget.appName,
            androidPackage: widget.androidPackage,
            saveSkip: widget.saveSkip,
          ),
        ],

        // Reset button
        widget.resetSpacer,
        EzResetButton(
          redraw,
          appName: widget.appName,
          androidPackage: widget.androidPackage,
          resetSkip: widget.resetSkip,
          saveSkip: widget.saveSkip,
        ),

        // Footer
        ...widget.footer,
      ]);
}
