library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzWebScaffold extends Scaffold {
  final Key? key;
  final BoxDecoration background;
  final PreferredSizeWidget appBar;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget body;
  final Widget? fab;
  final int? index;
  final List<BottomNavigationBarItem>? items;
  final void Function(int)? onChanged;

  /// Standardizes building a [Scaffold] styled from [EzConfig.prefs]
  /// It's recommended to use [standardWindow] for the [body]
  EzWebScaffold({
    this.key,
    required this.appBar,
    this.drawer,
    this.endDrawer,
    required this.background,
    required this.body,
    this.fab,
    this.index,
    this.items,
    this.onChanged,
  }) : super(
          key: key,
          appBar: appBar,
          drawer: drawer,
          endDrawer: endDrawer,
          body: Container(
            decoration: background,
            child: body,
          ),
          floatingActionButton: fab,
          bottomNavigationBar: (index != null && items != null && onChanged != null)
              ? BottomNavigationBar(
                  currentIndex: index,
                  items: items,
                  onTap: onChanged,
                )
              : null,
        );
}
