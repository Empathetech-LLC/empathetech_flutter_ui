import 'utils.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class LayoutSize extends InheritedWidget {
  /// true == small screen
  /// false == large screen
  final bool isLimited;

  /// [Scaffold] to be displayed
  final Widget child;

  /// Wrapper object for responding to screen space changes
  /// Currently uses the bool [isLimited] for switching between a small and large build
  /// Could be expanded limitlessly by replacing [isLimited] with a custom enum
  const LayoutSize({
    Key? key,
    required this.isLimited,
    required this.child,
  }) : super(key: key, child: child);

  static LayoutSize? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LayoutSize>();
  }

  @override
  bool updateShouldNotify(LayoutSize old) => isLimited != old.isLimited;
}

class ExampleScaffold extends StatelessWidget {
  final Key? key;
  final Widget body;
  final Widget? fab;

  const ExampleScaffold({
    this.key,
    required this.body,
    required this.fab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Gather theme data //

    final bool leftHandedUser = EzConfig.instance.dominantSide == Hand.left;

    final TextStyle? appBarTextStyle = Theme.of(context).appBarTheme.titleTextStyle;
    final double textScalar = MediaQuery.of(context).textScaleFactor;

    final double buttonSpacer = EzConfig.instance.prefs[buttonSpacingKey];

    // Set toolbar height to a value that creates equal space above and below the text links
    final double toolbarHeight =
        appBarTextStyle!.fontSize! * MediaQuery.of(context).textScaleFactor * 3;

    // Define shared widget(s) //

    final TitleBar titleBar = TitleBar(
      style: appBarTextStyle,
      scalar: textScalar,
      spacer: buttonSpacer,
    );

    final double threshold = titleBar.width;

    // Define builds //

    /* These aren't actually different in the example app
     * But they can be in yours!
     */

    final _SmallBuild smallBuild = _SmallBuild(
      leftHandedUser: leftHandedUser,
      toolbarHeight: toolbarHeight,
      titleBar: titleBar,
      body: body,
      fab: fab,
    );

    final _LargeBuild largeBuild = _LargeBuild(
      leftHandedUser: leftHandedUser,
      toolbarHeight: toolbarHeight,
      titleBar: titleBar,
      body: body,
      fab: fab,
    );

    // Build //

    return (widthOf(context) <= threshold)
        ? LayoutSize(isLimited: true, child: smallBuild)
        : LayoutSize(isLimited: false, child: largeBuild);
  }
}

class _SmallBuild extends StatelessWidget {
  final double width = double.infinity;
  final bool leftHandedUser;
  final double toolbarHeight;
  final TitleBar titleBar;
  final Widget body;
  final Widget? fab;

  /// [ExampleScaffold] for when there is limited screen space
  /// Has a mobile-like layout
  const _SmallBuild({
    required this.leftHandedUser,
    required this.toolbarHeight,
    required this.titleBar,
    required this.body,
    required this.fab,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(width, toolbarHeight),
        child: AppBar(
          toolbarHeight: toolbarHeight,

          // Leading
          automaticallyImplyLeading: (leftHandedUser) ? false : true,

          // Title
          title: titleBar,
          titleSpacing: 0,
          centerTitle: true,

          // Actions (aka trailing)
          actions: (leftHandedUser) ? [EzBackAction()] : null,
        ),
      ),

      // Body
      body: body,

      // FAB
      floatingActionButton: fab,
      floatingActionButtonLocation: (leftHandedUser)
          ? FloatingActionButtonLocation.startFloat
          : FloatingActionButtonLocation.endFloat,
    );
  }
}

class _LargeBuild extends StatelessWidget {
  final double width = double.infinity;
  final bool leftHandedUser;
  final double toolbarHeight;
  final TitleBar titleBar;
  final Widget body;
  final Widget? fab;

  /// [ExampleScaffold] for when there is ample screen space
  /// Has a desktop-like layout
  const _LargeBuild({
    required this.leftHandedUser,
    required this.toolbarHeight,
    required this.titleBar,
    required this.body,
    required this.fab,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(width, toolbarHeight),
        child: AppBar(
          toolbarHeight: toolbarHeight,

          // Leading
          automaticallyImplyLeading: (leftHandedUser) ? false : true,

          // Title
          title: titleBar,
          titleSpacing: 0,
          centerTitle: true,

          // Actions (aka trailing)
          actions: (leftHandedUser) ? [EzBackAction()] : null,
        ),
      ),

      // Body
      body: body,

      // FAB
      floatingActionButton: fab,
      floatingActionButtonLocation: (leftHandedUser)
          ? FloatingActionButtonLocation.startFloat
          : FloatingActionButtonLocation.endFloat,
    );
  }
}
