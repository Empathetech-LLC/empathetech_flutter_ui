/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';

class EzLayoutSwitch extends InheritedWidget {
  /// true == small/mobile screen
  /// false == large/tablet/desktop screen
  final bool isLimited;

  /// [Scaffold] to be displayed
  final Widget child;

  /// [InheritedWidget] to wrap around your [Scaffold]s
  /// Enables real-time responses to screen space changes
  /// Currently uses the bool [isLimited] for switching between a small and large build
  /// Could be expanded limitlessly by replacing [isLimited] with a custom enum
  const EzLayoutSwitch({
    Key? key,
    required this.isLimited,
    required this.child,
  }) : super(key: key, child: child);

  static EzLayoutSwitch? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<EzLayoutSwitch>();
  }

  @override
  bool updateShouldNotify(EzLayoutSwitch old) => isLimited != old.isLimited;
}
