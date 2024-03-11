import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class ExampleScaffold extends StatelessWidget {
  final String title;
  final String? titleSemantics;
  final Widget body;
  final Widget? fab;

  /// Standardized [Scaffold] for all of the EFUI example app's screens
  const ExampleScaffold({
    super.key,
    this.title = efuiL,
    this.titleSemantics = efuiLFix,
    required this.body,
    this.fab,
  });

  @override
  Widget build(BuildContext context) {
    // Gather the theme data //

    final bool isLefty = EzConfig.get(isLeftyKey) ?? false;

    final double toolbarHeight = MediaQuery.textScalerOf(context)
            .scale(Theme.of(context).appBarTheme.titleTextStyle!.fontSize!) *
        3;

    // Return the build //

    final Scaffold theBuild = Scaffold(
      // AppBar
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, toolbarHeight),
        child: AppBar(
          excludeHeaderSemantics: true,
          toolbarHeight: toolbarHeight,

          // Leading (aka left)
          automaticallyImplyLeading: !isLefty,
          leadingWidth: toolbarHeight,

          // Title
          title: Text(title, semanticsLabel: titleSemantics),

          // Actions (aka trailing aka right)
          actions: isLefty ? <Widget>[const EzBackAction()] : null,
        ),
      ),

      // Body
      body: body,
      floatingActionButton: fab,
    );

    return SelectionArea(
      child: EzSwapScaffold(
        small: theBuild,
        large: theBuild,
        threshold: smallBreakpoint,
      ),
    );
  }
}
