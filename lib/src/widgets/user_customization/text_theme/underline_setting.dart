/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzUnderlineSetting extends StatefulWidget {
  final String configKey;

  /// Use this to live update the [TextStyle] on your UI
  final void Function(bool underline) notifierCallback;

  /// Optional iconSize
  final double? size;

  /// Standardized tool for updating the [TextStyle.decoration] for the passed [configKey]
  const EzUnderlineSetting({
    super.key,
    required this.configKey,
    required this.notifierCallback,
    this.size,
  });

  @override
  State<EzUnderlineSetting> createState() => _EzUnderlineSettingState();
}

class _EzUnderlineSettingState extends State<EzUnderlineSetting> {
  // Gather the theme data //

  late bool isUnderlined = EzConfig.get(widget.configKey) ?? false;

  late final ColorScheme colorScheme = Theme.of(context).colorScheme;

  // Define the build //

  void swapState() {
    isUnderlined = !isUnderlined;
    widget.notifierCallback(isUnderlined);
    EzConfig.setBool(widget.configKey, isUnderlined);
    setState(() {});
  }

  late final String tooltip = EFUILang.of(context)!.tsUnderline;

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return isUnderlined
        ? IconButton(
            icon: const Icon(Icons.format_underline),
            color: colorScheme.primary,
            iconSize: widget.size,
            onPressed: swapState,
            tooltip: tooltip,
          )
        : IconButton(
            icon: const Icon(Icons.format_underline_outlined),
            color: colorScheme.outline,
            iconSize: widget.size,
            onPressed: swapState,
            tooltip: tooltip,
          );
  }
}
