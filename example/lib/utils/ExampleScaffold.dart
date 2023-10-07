import './utils.dart';

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

    final bool leftHandedUser = EzConfig.instance.dominantHand == Hand.left;

    final TextStyle? titleStyle = Theme.of(context).appBarTheme.titleTextStyle;

    final double textScalar = MediaQuery.of(context).textScaleFactor;
    final double toolbarHeight = titleStyle!.fontSize! * textScalar * 2;

    // Define AppBar widget(s) //

    final Widget appBar = EzSelectableText.rich(
      EzLink(
        text: 'EFUI',
        style: titleStyle,
        action: () => context.goNamed(homeRoute),
        semanticsLabel: Phrases.of(context)!.homeLinkHint,
      ),
    );

    // Return the build //

    return Scaffold(
      // AppBar
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, toolbarHeight),
        child: AppBar(
          excludeHeaderSemantics: true,
          toolbarHeight: toolbarHeight,

          // Leading
          automaticallyImplyLeading: (leftHandedUser) ? false : true,

          // Title
          title: appBar,
          titleSpacing: 0,
          centerTitle: true,

          // Actions (aka trailing)
          actions: (leftHandedUser) ? [EzBackAction()] : null,
        ),
      ),

      // Body
      body: body,
      floatingActionButton: null,
    );
  }
}
