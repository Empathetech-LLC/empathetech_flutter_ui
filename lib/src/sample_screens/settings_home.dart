/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

class EzSettingsHome extends StatefulWidget {
  /// Remove the 'Have fun!' part of the settings disclaimer
  /// There are some apps where fun is not appropriate
  final bool notFun;

  /// [EzScreen.useImageDecoration] passthrough
  final bool useImageDecoration;

  /// Widgets to be added below language and above any present routes
  /// Do not include a trailing spacer, one will be provided
  final List<Widget>? additionalSettings;

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
  /// Do not include a trailing spacer, one will be provided
  final List<Widget>? additionalRoutes;

  /// Whether to allow settings randomization
  /// We think it's fun, but it might not always be appropriate
  final bool allowRandom;

  /// Widgets to be added below reset
  /// Do not include a trailing spacer, one will be provided
  final List<Widget>? footer;

  /// Empathetech settings landing page
  /// Contains global settings and [EzElevatedIconButton]s that lead to the rest of the settings pages
  /// Recommended to use as a [Scaffold.body]
  const EzSettingsHome({
    super.key,
    this.notFun = false,
    this.useImageDecoration = true,
    this.additionalSettings,
    required this.textSettingsPath,
    required this.layoutSettingsPath,
    required this.colorSettingsPath,
    required this.imageSettingsPath,
    this.additionalRoutes,
    this.allowRandom = true,
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

          const EzLocaleSetting(),
          separator,

          if (widget.additionalSettings != null) ...<Widget>[
            ...widget.additionalSettings!,
            separator,
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

          // Turn trailing spacer (if present) into a separator
          if (widget.textSettingsPath != null ||
              widget.layoutSettingsPath != null ||
              widget.colorSettingsPath != null ||
              widget.imageSettingsPath != null)
            spacer,

          if (widget.additionalRoutes != null) ...<Widget>[
            ...widget.additionalRoutes!,
            separator,
          ],

          // Feeling lucky
          if (widget.allowRandom) ...<Widget>[
            const EzConfigRandomizer(),
            separator,
          ],

          // Reset button
          const EzResetButton(),
          separator,

          if (widget.footer != null) ...<Widget>[
            ...widget.footer!,
            separator,
          ],
        ],
      ),
    );
  }
}
