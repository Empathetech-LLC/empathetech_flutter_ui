/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../utils/export.dart';
import './export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class OpenUIScaffold extends StatelessWidget {
  final Widget body;
  final Widget? fab;

  /// Standardized [Scaffold] for all of the EFUI example app's screens
  const OpenUIScaffold({
    super.key,
    required this.body,
    this.fab,
  });

  @override
  Widget build(BuildContext context) {
    // Gather the theme data //

    final bool isLefty = EzConfig.get(isLeftyKey) ?? false;
    final EFUILang l10n = EFUILang.of(context)!;

    final Size appBarTextSize = measureText(
      appTitle,
      style: Theme.of(context).appBarTheme.titleTextStyle,
      context: context,
    );

    final double toolbarHeight =
        appBarTextSize.height + EzConfig.get(paddingKey);

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
        icon: const Icon(Icons.more_vert),
        tooltip: l10n.gOptions,
      ),
      menuChildren: <Widget>[
        BYOButton(parentContext: context, l10n: l10n),
        FeedbackButton(
          parentContext: context,
          scaffoldMessengerKey: scaffoldMessengerKey,
          l10n: l10n,
        ),
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

            // Actions (aka trailing aka right)
            actions:
                isLefty ? const <Widget>[EzBackAction()] : <Widget>[options],
          ),
        ),

        // Body
        body: body,
        floatingActionButton: fab,
      ),
    );

    return EzSwapScaffold(
      small: theBuild,
      large: theBuild,
      threshold: smallBreakpoint,
    );
  }
}
