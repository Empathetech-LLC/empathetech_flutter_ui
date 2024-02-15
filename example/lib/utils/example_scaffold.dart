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

    final TextStyle titleStyle = Theme.of(context).appBarTheme.titleTextStyle!;

    final double toolbarHeight =
        MediaQuery.textScalerOf(context).scale(titleStyle.fontSize!) * 3;

    // Define AppBar widget(s) //

    // Return the build //

    return SelectionArea(
      child: Scaffold(
        // AppBar
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, toolbarHeight),
          child: AppBar(
            excludeHeaderSemantics: true,
            toolbarHeight: toolbarHeight,

            // Leading
            automaticallyImplyLeading: !isLefty,
            leadingWidth: toolbarHeight,

            // Title
            title: Text(title, semanticsLabel: titleSemantics),
            titleSpacing: 0,
            centerTitle: true,

            // Actions (aka trailing)
            actions: isLefty ? <Widget>[const EzBackAction()] : null,
          ),
        ),

        // Body
        body: body,
        floatingActionButton: fab,
      ),
    );
  }
}
