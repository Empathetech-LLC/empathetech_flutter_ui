/* empathetech_flutter_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

class SettingsHome extends StatefulWidget {
  /// For [EzScreen.useImageDecoration]
  final bool useImageDecoration;

  /// Widgets to be added below language and above any present routes
  /// Do not include a trailing spacer, one will be provided
  final List<Widget>? additionalSettings;

  /// Nullable [goNamed] path to the text settings screen
  /// If null, no button will appear
  final String? textSettingsPath;

  /// Nullable [goNamed] path to the layout settings screen
  /// If null, no button will appear
  final String? layoutSettingsPath;

  /// Nullable [goNamed] path to the color settings screen
  /// If null, no button will appear
  final String? colorSettingsPath;

  /// Nullable [goNamed] path to the image settings screen
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

  const SettingsHome({
    super.key,
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
  State<SettingsHome> createState() => _SettingsHomeState();
}

class _SettingsHomeState extends State<SettingsHome> {
  // Gather the theme data //

  static const EzSpacer spacer = EzSpacer();
  static const EzSeparator separator = EzSeparator();

  late final EFUILang l10n = EFUILang.of(context)!;

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ezWindowNamer(l10n.ssPageTitle, Theme.of(context).colorScheme.primary);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return EzScreen(
      useImageDecoration: widget.useImageDecoration,
      child: EzScrollView(
        children: <Widget>[
          // Functionality disclaimer
          EzWarning(kIsWeb ? l10n.ssSettingsGuideWeb : l10n.ssSettingsGuide),
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
