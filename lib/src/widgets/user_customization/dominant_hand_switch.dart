/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzDominantHandSwitch extends StatefulWidget {
  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? labelStyle;

  /// Defaults to [ColorScheme.surface]
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

  final double margin = EzConfig.get(marginKey);

  late final ButtonStyle menuButtonStyle = TextButton.styleFrom(
    padding: EzInsets.menu(EzConfig.get(paddingKey)),
  );

  late final EFUILang l10n = EFUILang.of(context)!;

  // Define the build data //

  bool isLefty = EzConfig.get(isLeftyKey) ?? false;

  late final List<DropdownMenuEntry<bool>> entries = <DropdownMenuEntry<bool>>[
    DropdownMenuEntry<bool>(
      value: false,
      label: l10n.gRight,
      style: menuButtonStyle,
    ),
    DropdownMenuEntry<bool>(
      value: true,
      label: l10n.gLeft,
      style: menuButtonStyle,
    ),
  ];

  late final List<Widget> children = <Widget>[
    // Label
    EzTextBackground(
      Text(
        l10n.ssDominantHand,
        style: widget.labelStyle ?? Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
      useSurface: false,
    ),
    EzSpacer(space: margin),

    // Button
    DropdownMenu<bool>(
      width: dropdownWidth(
        context: context,
        entries: entries
            .map((DropdownMenuEntry<bool> entry) => entry.label)
            .toList(),
      ),
      dropdownMenuEntries: entries,
      enableSearch: false,
      initialSelection: isLefty,
      onSelected: (bool? makeLeft) async {
        if (makeLeft == true) {
          if (!isLefty) {
            await EzConfig.setBool(isLeftyKey, true);
            setState(() => isLefty = true);
          }
        } else {
          if (isLefty) {
            await EzConfig.setBool(isLeftyKey, false);
            setState(() => isLefty = false);
          }
        }
      },
    ),
  ];

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return EzScrollView(
      scrollDirection: Axis.horizontal,
      mainAxisSize: MainAxisSize.min,
      children: isLefty ? children.reversed.toList() : children,
    );
  }
}
