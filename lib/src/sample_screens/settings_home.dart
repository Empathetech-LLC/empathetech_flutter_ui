/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

class EzSettingsHome extends StatefulWidget {
  /// [EzScreen.useImageDecoration] passthrough
  final bool useImageDecoration;

  /// Optionally remove 'Have fun!' part of the settings disclaimer
  /// There are some apps where fun is not appropriate
  final bool notFun;

  /// Locales to skip in the [EzLocaleSetting]
  /// Defaults to [english] to not dupe [americanEnglish]
  final Set<Locale>? skipLocales;

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
  /// See [randomSpacer] or [resetSpacer] for layout tuning
  final List<Widget>? additionalRoutes;

  /// Spacer after the navigation buttons and before the [EzConfigRandomizer]
  /// If null, [EzConfigRandomizer] will not be included
  final Widget? randomSpacer;

  /// Spacer between the [EzResetButton] and the navigation buttons, or [EzConfigRandomizer] if present
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
    this.useImageDecoration = true,
    this.notFun = false,
    this.skipLocales,
    this.localeSpacer = const EzSeparator(),
    this.additionalSettings,
    this.preNavSpacer = const EzSeparator(),
    required this.textSettingsPath,
    required this.layoutSettingsPath,
    required this.colorSettingsPath,
    required this.imageSettingsPath,
    this.additionalRoutes,
    this.randomSpacer = const EzSeparator(),
    this.resetSpacer = const EzSeparator(),
    this.skipKeys,
    this.footerSpacer = const EzSeparator(),
    this.footer,
  });

  @override
  State<EzSettingsHome> createState() => _EzSettingsHomeState();
}

class _EzSettingsHomeState extends State<EzSettingsHome> {
  // Gather the theme data //

  static const EzSpacer spacer = EzSpacer();
  static const EzSeparator separator = EzSeparator();

  late final EFUILang l10n = ezL10n(context);

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ezWindowNamer(context, l10n.ssPageTitle);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return EzScreen(
      useImageDecoration: widget.useImageDecoration,
      child: EzScrollView(
        children: <Widget>[
          // Functionality disclaimer
          EzWarning(widget.notFun
              ? (kIsWeb
                  ? l10n.ssSettingsGuideWeb.split('\n').first
                  : l10n.ssSettingsGuide.split('\n').first)
              : (kIsWeb ? l10n.ssSettingsGuideWeb : l10n.ssSettingsGuide)),
          separator,

          // Global settings
          const EzDominantHandSwitch(),
          spacer,

          const EzThemeModeSwitch(),
          spacer,

          EzLocaleSetting(skip: widget.skipLocales ?? <Locale>{english}),
          widget.localeSpacer,

          if (widget.additionalSettings != null) ...<Widget>[
            ...widget.additionalSettings!,
            widget.preNavSpacer,
          ],

          // Text settings
          if (widget.textSettingsPath != null) ...<Widget>[
            EzElevatedIconButton(
              onPressed: () => context.goNamed(widget.textSettingsPath!),
              icon: EzIcon(Icons.navigate_next),
              label: l10n.tsPageTitle,
            ),
            spacer,
          ],

          // Layout settings
          if (widget.layoutSettingsPath != null) ...<Widget>[
            EzElevatedIconButton(
              onPressed: () => context.goNamed(widget.layoutSettingsPath!),
              icon: EzIcon(Icons.navigate_next),
              label: l10n.lsPageTitle,
            ),
            spacer,
          ],

          // Color settings
          if (widget.colorSettingsPath != null) ...<Widget>[
            EzElevatedIconButton(
              onPressed: () => context.goNamed(widget.colorSettingsPath!),
              icon: EzIcon(Icons.navigate_next),
              label: l10n.csPageTitle,
            ),
            spacer,
          ],

          // Image settings
          if (widget.imageSettingsPath != null) ...<Widget>[
            EzElevatedIconButton(
              onPressed: () => context.goNamed(widget.imageSettingsPath!),
              icon: EzIcon(Icons.navigate_next),
              label: l10n.isPageTitle,
            ),
            spacer,
          ],

          if (widget.additionalRoutes != null) ...widget.additionalRoutes!,

          // Feeling lucky
          if (widget.randomSpacer != null) ...<Widget>[
            widget.randomSpacer!,
            const EzConfigRandomizer(),
          ],

          // Reset button
          widget.resetSpacer,
          EzResetButton(skip: widget.skipKeys),

          if (widget.footer != null) ...<Widget>[
            widget.footerSpacer,
            ...widget.footer!,
          ],
          separator,
        ],
      ),
    );
  }
}
