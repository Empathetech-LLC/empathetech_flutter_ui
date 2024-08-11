/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

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

  bool isLefty = EzConfig.get(isLeftyKey) ?? false;

  // Define the build data //

  late final List<DropdownMenuEntry<bool>> entries = <DropdownMenuEntry<bool>>[
    DropdownMenuEntry<bool>(
      value: false,
      label: l10n.gRight,
    ),
    DropdownMenuEntry<bool>(
      value: true,
      label: l10n.gLeft,
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
    DropdownMenu<bool>(
      enableSearch: false,
      initialSelection: isLefty,
      dropdownMenuEntries: entries,
      onSelected: (bool? makeLeft) async {
        if (makeLeft == true) {
          if (!isLefty) {
            isLefty = true;
            await EzConfig.setBool(isLeftyKey, true);
            setState(() {});
          }
        } else {
          if (isLefty) {
            isLefty = false;
            await EzConfig.remove(isLeftyKey);
            setState(() {});
          }
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
        children: isLefty ? children.reversed.toList() : children,
      ),
    );
  }
}
