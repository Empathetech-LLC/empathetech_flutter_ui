/* open_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import './export.dart';
import '../models/export.dart';
import '../utils/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class OpenUIScaffold extends StatelessWidget {
  /// [AppBar.title] passthrough (via [Text] widget)
  final String title;

  /// For generator pages; whether there are things running
  final bool running;

  /// Whether to include [SettingsButton] in the [MenuAnchor]
  final bool showSettings;

  /// Whether to include [UploadButton] in the [MenuAnchor]
  final Future<void> Function(EAGConfig)? onUpload;

  /// [Scaffold.body] passthrough
  final Widget body;

  /// [FloatingActionButton]
  final Widget? fab;

  /// Standardized [Scaffold] for all of the EFUI example app's screens
  const OpenUIScaffold({
    super.key,
    this.title = appTitle,
    this.running = false,
    this.showSettings = true,
    this.onUpload,
    required this.body,
    this.fab,
  });

  @override
  Widget build(BuildContext context) {
    // Gather the theme data //

    final bool isLefty = EzConfig.get(isLeftyKey) ?? false;
    final EFUILang l10n = ezL10n(context);

    final double toolbarHeight = ezToolbarHeight(context, appTitle);

    // Define custom widgets //

    late final MenuAnchor options = MenuAnchor(
      builder: (_, MenuController controller, ___) => IconButton(
        onPressed: () =>
            (controller.isOpen) ? controller.close() : controller.open(),
        tooltip: l10n.gOptions,
        icon: Icon(Icons.more_vert, semanticLabel: l10n.gOptions),
      ),
      menuChildren: <Widget>[
        if (showSettings) SettingsButton(context),
        if (onUpload != null) UploadButton(context, onUpload: onUpload!),
        EzFeedbackMenuButton(
          parentContext: context,
          appName: appTitle,
          supportEmail: 'support@empathetech.net',
        ),
        const OpenSourceButton(),
      ],
    );

    // Return the build //

    final Widget theBuild = SelectionArea(
      child: Scaffold(
        // AppBar
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, toolbarHeight),
          child: AppBar(
            excludeHeaderSemantics: true,
            toolbarHeight: toolbarHeight,

            // Leading (aka left)
            leading: running
                ? const SizedBox.shrink()
                : (isLefty ? options : const EzBackAction()),
            leadingWidth: toolbarHeight,

            // Title
            title: Text(title, textAlign: TextAlign.center),
            centerTitle: true,
            titleSpacing: 0,

            // Actions (aka trailing aka right)
            actions: <Widget>[
              running
                  ? const SizedBox.shrink()
                  : (isLefty ? const EzBackAction() : options)
            ],
          ),
        ),

        // Body
        body: body,

        // FAB
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: fab == null
              ? <Widget>[const EzUpdater()]
              : <Widget>[const EzUpdater(), const EzSpacer(), fab!],
        ),
        floatingActionButtonLocation: isLefty
            ? FloatingActionButtonLocation.startFloat
            : FloatingActionButtonLocation.endFloat,

        // Prevents the keyboard from pushing the body up
        resizeToAvoidBottomInset: false,
      ),
    );

    return EzSwapScaffold(
      small: theBuild,
      large: theBuild,
      threshold: smallBreakpoint,
    );
  }
}
