/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import './export.dart';
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

  /// [FloatingActionButton]s to add on top of the [EzUpdaterFAB]
  /// BYO spacing widgets
  final List<Widget>? fabs;

  /// Standardized [Scaffold] for all of the EFUI example app's screens
  const OpenUIScaffold(
    this.body, {
    super.key,
    this.title = appName,
    this.running = false,
    this.showSettings = true,
    this.onUpload,
    this.fabs,
  });

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final double toolbarHeight =
        ezToolbarHeight(context: context, title: appName);

    // Define custom widgets //

    final Widget options = MenuAnchor(
      builder: (_, MenuController controller, ___) => IconButton(
        onPressed: () =>
            (controller.isOpen) ? controller.close() : controller.open(),
        tooltip: EzConfig.l10n.gOptions,
        icon: Icon(Icons.more_vert, semanticLabel: EzConfig.l10n.gOptions),
      ),
      menuChildren: <Widget>[
        if (showSettings) SettingsButton(context),
        if (onUpload != null) UploadButton(context, onUpload: onUpload!),
        const OpenSourceButton(),
      ],
    );

    // Return the build //

    return EzAdaptiveParent(
      small: SelectionArea(
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
            children: <Widget>[updater, if (fabs != null) ...fabs!],
          ),
          floatingActionButtonLocation: EzConfig.isLefty
              ? FloatingActionButtonLocation.startFloat
              : FloatingActionButtonLocation.endFloat,

          // Prevents the keyboard from pushing the body up
          resizeToAvoidBottomInset: false,
        ),
      ),
    );
  }
}
