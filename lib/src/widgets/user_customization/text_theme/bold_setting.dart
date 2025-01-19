/* empathetech_flutter_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzBoldSetting extends StatefulWidget {
  /// The [EzConfig] whose value is being updated
  final String configKey;

  /// Optional callback to live update the [TextStyle] on your UI
  final void Function(bool bold) notifierCallback;

  /// Optional override
  /// Defaults to [ThemeData.iconButtonTheme]s value
  final double? size;

  /// Standardized tool for toggling [FontWeight.bold] in the [TextStyle.fontWeight] that matches [configKey]
  const EzBoldSetting({
    super.key,
    required this.configKey,
    required this.notifierCallback,
    this.size,
  });

  @override
  State<EzBoldSetting> createState() => _EzBoldSettingState();
}

class _EzBoldSettingState extends State<EzBoldSetting> {
  // Gather the theme data //

  late final ColorScheme colorScheme = Theme.of(context).colorScheme;

  late bool isBold = EzConfig.get(widget.configKey) ?? false;

  // Define the build //

  late final String tooltip = EFUILang.of(context)!.tsBold;

  void swapState() async {
    isBold = !isBold;
    await EzConfig.setBool(widget.configKey, isBold);
    widget.notifierCallback(isBold);
    setState(() {});
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return isBold
        ? IconButton(
            style: IconButton.styleFrom(
              foregroundColor: colorScheme.primary,
              iconSize: widget.size,
            ),
            onPressed: swapState,
            tooltip: tooltip,
            icon: EzIcon(Icons.format_bold),
          )
        : IconButton(
            style: IconButton.styleFrom(
              foregroundColor: colorScheme.outline,
              iconSize: widget.size,
            ),
            onPressed: swapState,
            tooltip: tooltip,
            icon: EzIcon(Icons.format_bold_outlined),
          );
  }
}
