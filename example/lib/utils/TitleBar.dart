import '../screens/screens.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TitleBar extends StatelessWidget {
  final GlobalKey? key;
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

  static const String _title = 'EFUI';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        EzSelectableText.rich(
          EzLink(
            text: _title,
            style: style,
            action: () => context.goNamed(homeRoute),
            semanticsLabel: 'Return to the home screen',
          ),
        ),
      ],
    );
  }
}
