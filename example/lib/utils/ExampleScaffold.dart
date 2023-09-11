import 'utils.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class LayoutSize extends InheritedWidget {
  final bool isLimited;

  const LayoutSize({
    Key? key,
    required Widget child,
    required this.isLimited,
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

    // Reverse the colors of the app bar to highlight it
    final Color appBarColor = Theme.of(context).colorScheme.onBackground;
    final Color appBarTextColor = Theme.of(context).colorScheme.background;

    final TextStyle appBarTextStyle = buildHeadlineSmall(appBarTextColor);
    final double textScalar = MediaQuery.of(context).textScaleFactor;

    final double iconSize = appBarTextStyle.fontSize!;
    final IconThemeData appBarIconData = IconThemeData(
      color: appBarTextColor,
      size: iconSize,
    );

    final AppBarTheme appBarTheme = AppBarTheme(
      color: appBarColor,
      iconTheme: appBarIconData,
      actionsIconTheme: appBarIconData,
      titleTextStyle: appBarTextStyle,
    );

    final double buttonSpacer = EzConfig.instance.prefs[buttonSpacingKey];

    // Set toolbar height to equal space above and below text links
    final double toolbarHeight =
        appBarTextStyle.fontSize! * MediaQuery.of(context).textScaleFactor * 3;

    // Define shared widget(s) //

    final TitleBar titleBar = TitleBar(
      style: appBarTextStyle,
      scalar: textScalar,
      spacer: buttonSpacer,
    );

    final double threshold = titleBar.width;

    // Return build(s) //

    final _SmallBuild smallBuild = _SmallBuild(
      appBarTheme: appBarTheme,
      leftHandedUser: leftHandedUser,
      toolbarHeight: toolbarHeight,
      titleBar: titleBar,
      body: body,
      fab: fab,
    );

    final _LargeBuild largeBuild = _LargeBuild(
      appBarTheme: appBarTheme,
      leftHandedUser: leftHandedUser,
      toolbarHeight: toolbarHeight,
      titleBar: titleBar,
      body: body,
      fab: fab,
    );

    return (widthOf(context) <= threshold)
        ? LayoutSize(isLimited: true, child: smallBuild)
        : LayoutSize(isLimited: false, child: largeBuild);
  }
}

class _SmallBuild extends StatelessWidget {
  final double width = double.infinity;
  final AppBarTheme appBarTheme;
  final bool leftHandedUser;
  final double toolbarHeight;
  final TitleBar titleBar;
  final Widget body;
  final Widget? fab;

  /// [ExampleScaffold] for when there is limited screen space
  /// Has a mobile-like layout
  const _SmallBuild({
    required this.appBarTheme,
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
        child: Theme(
          data: Theme.of(context).copyWith(
            appBarTheme: appBarTheme,
            tabBarTheme: Theme.of(context)
                .tabBarTheme
                .copyWith(labelColor: appBarTheme.titleTextStyle?.color),
          ),
          child: AppBar(
            toolbarHeight: toolbarHeight,

            // Leading
            automaticallyImplyLeading: (leftHandedUser) ? true : false,

            // Title
            title: titleBar,
            titleSpacing: 0,
            centerTitle: true,
          ),
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
  final AppBarTheme appBarTheme;
  final bool leftHandedUser;
  final double toolbarHeight;
  final TitleBar titleBar;
  final Widget body;
  final Widget? fab;

  /// [ExampleScaffold] for when there is ample screen space
  /// Has a traditional footer-less web page layout
  const _LargeBuild({
    required this.appBarTheme,
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
        child: Theme(
          data: Theme.of(context).copyWith(
            appBarTheme: appBarTheme,
            tabBarTheme: Theme.of(context)
                .tabBarTheme
                .copyWith(labelColor: appBarTheme.titleTextStyle?.color),
          ),
          child: AppBar(
            toolbarHeight: toolbarHeight,

            // Leading
            automaticallyImplyLeading: false,

            // Title
            title: titleBar,
            titleSpacing: 0,
            centerTitle: true,
          ),
        ),
      ),
      drawer: null,
      endDrawer: null,

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
