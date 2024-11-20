/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import './export.dart';
import '../utils/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class OpenUIScaffold extends StatelessWidget {
  final bool settingsMenu;

  final Widget body;

  /// [FloatingActionButton]
  final Widget? fab;

  /// Standardized [Scaffold] for all of the EFUI example app's screens
  const OpenUIScaffold({
    super.key,
    this.settingsMenu = true,
    required this.body,
    this.fab,
  });

  @override
  Widget build(BuildContext context) {
    // Gather the theme data //

    final bool isLefty = EzConfig.get(isLeftyKey) ?? false;
    final EFUILang l10n = EFUILang.of(context)!;

    final double toolbarHeight = measureText(
          appTitle,
          style: Theme.of(context).appBarTheme.titleTextStyle,
          context: context,
        ).height +
        EzConfig.get(marginKey);

    // Define custom widgets //

    late final MenuAnchor options = MenuAnchor(
      builder: (_, MenuController controller, ___) => IconButton(
        onPressed: () {
          if (controller.isOpen) {
            controller.close();
          } else {
            controller.open();
          }
        },
        tooltip: l10n.gOptions,
        icon: const Icon(Icons.more_vert),
      ),
      menuChildren: <Widget>[
        if (settingsMenu) const SettingsButton(),
        EzFeedbackMenuButton(l10n: l10n, appName: appTitle),
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
            leading: isLefty ? options : null,
            leadingWidth: toolbarHeight,

            // Title
            title: const Text(appTitle),
            centerTitle: true,
            titleSpacing: 0,

            // Actions (aka trailing aka right)
            actions:
                isLefty ? const <Widget>[EzBackAction()] : <Widget>[options],
          ),
        ),

        // Body
        body: body,

        // FAB
        floatingActionButton: fab,
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
