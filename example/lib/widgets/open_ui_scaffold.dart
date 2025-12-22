/* open_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import './export.dart';
import '../utils/export.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  /// [FloatingActionButton]s to add on top of the [EzUpdaterFAB]
  /// BYO spacing widgets
  final List<Widget>? fabs;

  /// Standardized [Scaffold] for all of the EFUI example app's screens
  const OpenUIScaffold({
    super.key,
    this.title = appName,
    this.running = false,
    this.showSettings = true,
    this.onUpload,
    required this.body,
    this.fabs,
  });

  @override
  Widget build(BuildContext context) {
    // Gather the fixed theme data //

    final double toolbarHeight =
        ezToolbarHeight(context: context, title: appName);

    // Define custom widgets //

    final Widget options = MenuAnchor(
      builder: (_, MenuController controller, ___) => IconButton(
        onPressed: () =>
            (controller.isOpen) ? controller.close() : controller.open(),
        tooltip: ezL10n(context).gOptions,
        icon: Icon(Icons.more_vert, semanticLabel: ezL10n(context).gOptions),
      ),
      menuChildren: <Widget>[
        if (showSettings) SettingsButton(context),
        if (onUpload != null) UploadButton(context, onUpload: onUpload!),
        EzFeedbackMenuButton(
          parentContext: context,
          appName: appName,
          supportEmail: 'support@empathetech.net',
        ),
        const OpenSourceButton(),
      ],
    );

    // Return the build //

    return EzAdaptiveParent(
      small: Consumer<EzThemeProvider>(
        key: ValueKey<int>(EzConfig.theme.seed),
        builder: (_, EzThemeProvider theme, __) => SelectionArea(
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
                    : (EzConfig.isLefty ? options : const EzBackAction()),
                leadingWidth: toolbarHeight,

                // Title
                title: Text(title, textAlign: TextAlign.center),
                centerTitle: true,
                titleSpacing: 0,

                // Actions (aka trailing aka right)
                actions: <Widget>[
                  running
                      ? const SizedBox.shrink()
                      : (EzConfig.isLefty ? const EzBackAction() : options)
                ],
              ),
            ),

            // Body
            body: body,

            // FAB
            floatingActionButton: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const EzUpdaterFAB(
                  appVersion: '2.3.2',
                  versionSource:
                      'https://raw.githubusercontent.com/Empathetech-LLC/empathetech_flutter_ui/refs/heads/main/example/APP_VERSION',
                  gPlay:
                      'https://play.google.com/store/apps/details?id=net.empathetech.open_ui',
                  appStore:
                      'https://apps.apple.com/us/app/open-ui/id6499560244',
                  github:
                      'https://github.com/Empathetech-LLC/empathetech_flutter_ui/releases',
                ),
                if (fabs != null) ...fabs!
              ],
            ),
            floatingActionButtonLocation: EzConfig.isLefty
                ? FloatingActionButtonLocation.startFloat
                : FloatingActionButtonLocation.endFloat,

            // Prevents the keyboard from pushing the body up
            resizeToAvoidBottomInset: false,
          ),
        ),
      ),
    );
  }
}
