import '../screens/screens.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TitleBar extends StatelessWidget {
  final GlobalKey? key;

  /// [TextStyle] to use on the links' text
  final TextStyle? style;

  /// Pass in the value from MediaQuery.of(context).textScaleFactor
  final double scalar;

  /// How much distance should be between the links
  final double spacer;

  /// Internal page links to put in the [AppBar]
  const TitleBar({
    this.key,
    required this.style,
    required this.scalar,
    required this.spacer,
  }) : super(key: key);

  /// The current horizontal space that the [TitleBar] needs
  /// Helpful for layout calculations
  double get width {
    double total = spacer;

    total += measureText(
      text: 'Have fun!',
      scalar: scalar, // Tracks user changes to zoom, text scaling, etc
      style: style,
    ).width;

    return total + spacer;
  }

  @override
  Widget build(BuildContext context) {
    final Widget title = EzSelectableText.rich(
      EzLink(
        text: 'EFUI',
        style: style,
        action: () => context.goNamed(homeRoute),
        semanticsLabel: 'Return to the home screen',
      ),
    );

    // Return build //

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        EzSpacer.row(spacer),
        title,
        EzSpacer.row(spacer),
      ],
    );
  }
}
