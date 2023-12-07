import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExampleScaffold extends StatelessWidget {
  final Key? key;
  final Widget body;

  /// Standardized [Scaffold] for all of the EFUI example app's screens
  const ExampleScaffold({this.key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Gather theme data //

    final bool leftHandedUser = (EzConfig.get(isRightHandKey) == false);

    final TextStyle? titleStyle = Theme.of(context)
        .appBarTheme
        .titleTextStyle
        ?.copyWith(color: Theme.of(context).colorScheme.onSurface);

    final TextScaler textScaler = MediaQuery.textScalerOf(context);
    final double toolbarHeight = textScaler.scale(titleStyle!.fontSize!) * 2;

    // Define AppBar widget(s) //

    final EzLink titleLink = EzLink(
      'EFUI',
      style: titleStyle,
      textAlign: TextAlign.center,
      onTap: () => context.goNamed(homeRoute),
      semanticsLabel: EFUILang.of(context)!.gHomeHint,
    );

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
            automaticallyImplyLeading: (leftHandedUser) ? false : true,

            // Title
            title: titleLink,
            titleSpacing: 0,
            centerTitle: true,

            // Actions (aka trailing)
            actions: (leftHandedUser) ? [EzBackAction()] : null,
          ),
        ),

        // Body
        body: body,
        floatingActionButton: null,
      ),
    );
  }
}
