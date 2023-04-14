library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzScaffold extends PlatformScaffold {
  final Key? key;
  final Key? widgetKey;
  final BoxDecoration background;
  final EzAppBar appBar;
  final Widget body;
  final Widget? fab;
  final PlatformNavBar? bottomNavBar;

  /// Default: false
  final bool iosContentPadding;

  // Default -> false
  final bool iosContentBottomPadding;
  final Widget Function(BuildContext, int)? cupertinoTabChildBuilder;

  /// Standardizes building a [PlatformScaffold] styled from [EzConfig.prefs]
  /// Handling platform differences, like [floatingActionButton]s on iOS
  /// See [standardWindow] and [navWindow] for [body] recommendations
  EzScaffold({
    this.key,
    this.widgetKey,
    required this.background,
    required this.appBar,
    required this.body,
    this.fab,
    this.bottomNavBar,
    this.iosContentPadding = false,
    this.iosContentBottomPadding = false,
    this.cupertinoTabChildBuilder,
  });

  @override
  Widget build(BuildContext context) {
    late double margin = EzConfig.prefs[marginKey];

    return PlatformScaffold(
      appBar: appBar,
      bottomNavBar: bottomNavBar,
      iosContentPadding: iosContentPadding,
      iosContentBottomPadding: iosContentBottomPadding,
      cupertinoTabChildBuilder: cupertinoTabChildBuilder,

      // Remainder: body, fab && background
      // Differs based on platform

      // Material/Android
      material: (context, platform) => MaterialScaffoldData(
        // Get Material end drawer (aka trailing widget) form the appBar
        // This is why we must use an EzAppBar
        endDrawer: (appBar.trailing is EzDrawer) ? appBar.trailing : null,

        // Decoration in the background, draw everything to the safe area
        body: GestureDetector(
          onTap: closeFocus,
          child: Container(
            decoration: background,
            child: SafeArea(child: body),
          ),
        ),
        floatingActionButton: fab,
      ),

      // Cupertino/iOS
      cupertino: (context, platform) => CupertinoPageScaffoldData(
        body: GestureDetector(
          onTap: closeFocus,
          child: Container(
            // Decoration in the background, draw everything to the safe area
            decoration: background,
            child: SafeArea(
              child: (fab == null)
                  ? body
                  // Manually draw floating action buttons on iOS
                  : Stack(
                      children: [
                        body,
                        Positioned(
                          bottom: 16.0 + margin,
                          right: 16.0 + margin,
                          child: fab ?? Container(),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
