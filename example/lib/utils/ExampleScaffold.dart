import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class ExampleScaffold extends StatelessWidget {
  final Key? key;
  final Widget body;
  final Widget? fab;

  /// Standardized [Scaffold] for all of the EFUI example app's screens
  const ExampleScaffold({
    this.key,
    required this.body,
    this.fab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Gather the theme data //

    final bool isRighty = EzConfig.get(isRightHandKey) ?? true;

    final TextStyle? titleStyle = Theme.of(context).appBarTheme.titleTextStyle;

    final TextScaler textScaler = MediaQuery.textScalerOf(context);
    final double toolbarHeight = textScaler.scale(titleStyle!.fontSize!) * 2;

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
            automaticallyImplyLeading: isRighty,

            // Title
            title: Text(efui, semanticsLabel: efuiFix),
            titleSpacing: 0,
            centerTitle: true,

            // Actions (aka trailing)
            actions: isRighty ? null : [EzBackAction()],
          ),
        ),

        // Body
        body: body,
        floatingActionButton: fab,
      ),
    );
  }
}
