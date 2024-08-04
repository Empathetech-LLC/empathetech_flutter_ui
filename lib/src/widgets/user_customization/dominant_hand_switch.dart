/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// Enumerator for tracking which (horizontal) side of the screen touch points should be on
enum Hand {
  right,
  left,
}

/// Get the proper [String] name for [Hand]
String handName(BuildContext context, Hand hand) {
  switch (hand) {
    case Hand.left:
      return EFUILang.of(context)!.gLeft;
    case Hand.right:
      return EFUILang.of(context)!.gRight;
  }
}

class EzDominantHandSwitch extends StatefulWidget {
  /// Defaults to [DropdownMenuThemeData.textStyle] value from your [ThemeData]
  final TextStyle? labelStyle;

  /// Defaults to [ColorScheme.surfaceContainer]
  final Color? backgroundColor;

  /// Standardized tool for updating [EzConfig] dominantHand
  const EzDominantHandSwitch({
    super.key,
    this.labelStyle,
    this.backgroundColor,
  });

  @override
  State<EzDominantHandSwitch> createState() => _HandSwitchState();
}

class _HandSwitchState extends State<EzDominantHandSwitch> {
  // Gather the theme data //

  late final ThemeData theme = Theme.of(context);
  late final EFUILang l10n = EFUILang.of(context)!;

  final double padding = EzConfig.get(paddingKey);

  final bool isLefty = EzConfig.get(isLeftyKey) ?? false;
  late Hand currSide = isLefty ? Hand.left : Hand.right;

  // Define the build data //

  late final List<DropdownMenuEntry<Hand>> entries = <DropdownMenuEntry<Hand>>[
    DropdownMenuEntry<Hand>(
      value: Hand.right,
      label: handName(context, Hand.right),
    ),
    DropdownMenuEntry<Hand>(
      value: Hand.left,
      label: handName(context, Hand.left),
    ),
  ];

  /// Define children separately to allow for live reversing
  late final List<Widget> children = <Widget>[
    // Label
    Flexible(
      child: Text(
        l10n.ssDominantHand,
        style: widget.labelStyle ?? theme.dropdownMenuTheme.textStyle,
        textAlign: TextAlign.center,
      ),
    ),
    EzSpacer(space: padding, vertical: false),

    // Button
    DropdownMenu<Hand>(
      initialSelection: currSide,
      dropdownMenuEntries: entries,
      onSelected: (Hand? newDominantHand) async {
        switch (newDominantHand) {
          case Hand.right:
            currSide = Hand.right;
            await EzConfig.remove(isLeftyKey);
            setState(() {});
            break;

          case Hand.left:
            currSide = Hand.left;
            await EzConfig.setBool(isLeftyKey, true);
            setState(() {});
            break;

          default:
            break;
        }
      },
    ),
  ];

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          color: widget.backgroundColor ?? theme.colorScheme.surfaceContainer),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            (currSide == Hand.right) ? children : children.reversed.toList(),
      ),
    );
  }
}
