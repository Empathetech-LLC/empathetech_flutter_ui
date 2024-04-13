import 'utils.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class ExampleScaffold extends StatelessWidget {
  final Widget body;
  final Widget? fab;

  /// Standardized [Scaffold] for all of the EFUI example app's screens
  const ExampleScaffold({
    super.key,
    required this.body,
    this.fab,
  });

  @override
  Widget build(BuildContext context) {
    // Gather the theme data //

    const FeedbackButton feedback = FeedbackButton();

    final bool isLefty = EzConfig.get(isLeftyKey) ?? false;

    final Size appBarTextSize = measureText(
      appTitle,
      style: Theme.of(context).appBarTheme.titleTextStyle,
      context: context,
    );

    final double toolbarHeight =
        appBarTextSize.height + EzConfig.get(paddingKey);

    // Return the build //

    final Scaffold theBuild = Scaffold(
      // AppBar
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, toolbarHeight),
        child: AppBar(
          excludeHeaderSemantics: true,
          toolbarHeight: toolbarHeight,

          // Leading (aka left)
          leading: isLefty ? feedback : null,
          leadingWidth: toolbarHeight,

          // Title
          title: const Text(appTitle),

          // Actions (aka trailing aka right)
          actions: isLefty
              ? const <Widget>[EzBackAction()]
              : const <Widget>[feedback],
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
