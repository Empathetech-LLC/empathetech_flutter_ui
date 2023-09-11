import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

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
  final Widget fab;

  /// Optional [TabBar] widget for pages with sub-pages
  final TabBar? tabBar;

  const ExampleScaffold({
    this.key,
    this.tabBar,
    required this.body,
    required this.fab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Gather theme data //

    final bool leftHandedUser = EzConfig.instance.dominantSide == Hand.left;
    final bool isLight = !PlatformTheme.of(context)!.isDark;

    // Reverse the colors of the app bar to highlight it
    final Color appBarColor = Theme.of(context).colorScheme.onBackground;
    final Color appBarTextColor = Theme.of(context).colorScheme.background;

    final TextStyle appBarTextStyle = buildHeadlineSmall(appBarTextColor);
    final TextStyle drawerTextStyle = buildHeadlineSmall(appBarColor);
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

    final double margin = EzConfig.instance.prefs[marginKey];
    final double buttonSpacer = EzConfig.instance.prefs[buttonSpacingKey];

    // Set toolbar height to equal space above and below text links
    final double toolbarHeight =
        appBarTextStyle.fontSize! * MediaQuery.of(context).textScaleFactor * 3;

    final double tabBarHeight = (tabBar == null) ? 0 : toolbarHeight * (2 / 3);

    // Return build(s) //

    final _SmallBuild smallBuild = _SmallBuild(
      appBarTheme: appBarTheme,
      leftHandedUser: leftHandedUser,
      toolbarHeight: toolbarHeight,
      tabBar: tabBar,
      tabBarHeight: tabBarHeight,
      body: body,
      fab: fab,
    );

    final _LargeBuild largeBuild = _LargeBuild(
      appBarTheme: appBarTheme,
      leftHandedUser: leftHandedUser,
      toolbarHeight: toolbarHeight,
      tabBar: tabBar,
      tabBarHeight: tabBarHeight,
      body: body,
      fab: fab,
    );

    return (widthOf(context) <= threshold)
        ? LayoutSize(isLimited: true, child: smallBuild)
        : LayoutSize(isLimited: false, child: largeBuild);
  }
}

class _SmallBuild extends StatelessWidget {
  final AppBarTheme appBarTheme;
  final ExternalLinks iconLinks;
  final InternalLinks drawer;
  final EmpathetechLogo logo;
  final TabBar? tabBar;
  final double width = double.infinity;
  final double toolbarHeight;
  final double tabBarHeight;
  final bool leftHandedUser;
  final Widget body;
  final Widget fab;

  /// [ExampleScaffold] for when there is limited screen space
  /// Has a mobile-like layout
  const _SmallBuild({
    required this.appBarTheme,
    required this.iconLinks,
    required this.drawer,
    required this.logo,
    required this.tabBar,
    required this.toolbarHeight,
    required this.tabBarHeight,
    required this.leftHandedUser,
    required this.body,
    required this.fab,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(width, toolbarHeight + tabBarHeight),
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
            leading: (leftHandedUser) ? null : iconLinks,
            leadingWidth: (leftHandedUser)
                ? null // Drawer
                : iconLinks.width, // ExternalLinks

            // Title
            title: logo,
            titleSpacing: 0,
            centerTitle: true,

            // Actions (aka trailing)
            actions: (leftHandedUser) ? iconLinks.rowChildren : null,

            // Bottom (aka tab bar)
            bottom: (tabBar != null)
                ? PreferredSize(
                    child: tabBar!,
                    preferredSize: Size(width, tabBarHeight),
                  )
                : null,
          ),
        ),
      ),

      // Drawer replaces leading
      drawer: (leftHandedUser) ? drawer : null,

      // End drawer replaces actions
      endDrawer: (leftHandedUser) ? null : drawer,

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
  final AppBarTheme appBarTheme;
  final ExternalLinks iconLinks;
  final InternalLinks pageLinks;
  final EmpathetechLogo logo;
  final TabBar? tabBar;
  final double width = double.infinity;
  final double toolbarHeight;
  final double tabBarHeight;
  final bool leftHandedUser;
  final Widget body;
  final Widget fab;

  /// [ExampleScaffold] for when there is ample screen space
  /// Has a traditional footer-less web page layout
  const _LargeBuild({
    required this.appBarTheme,
    required this.iconLinks,
    required this.pageLinks,
    required this.logo,
    required this.tabBar,
    required this.toolbarHeight,
    required this.tabBarHeight,
    required this.leftHandedUser,
    required this.body,
    required this.fab,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(width, toolbarHeight + tabBarHeight),
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
            leading: (leftHandedUser) ? iconLinks : logo,
            leadingWidth: (leftHandedUser)
                ? iconLinks.width // ExternalLinks
                : toolbarHeight, // Logo

            // Title
            title: pageLinks,
            titleSpacing: 0,
            centerTitle: true,

            // Action (aka trailing)
            actions: (leftHandedUser) ? [logo] : iconLinks.rowChildren,

            // Bottom (aka tab bar)
            bottom: (tabBar != null)
                ? PreferredSize(
                    child: tabBar!,
                    preferredSize: Size(width, tabBarHeight),
                  )
                : null,
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
