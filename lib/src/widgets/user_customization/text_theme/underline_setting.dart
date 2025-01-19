/* empathetech_flutter_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzUnderlineSetting extends StatefulWidget {
  /// The [EzConfig] whose value is being updated
  final String configKey;

  /// Optional callback to live update the [TextStyle] on your UI
  final void Function(bool underline) notifierCallback;

  /// Optional override
  /// Defaults to [ThemeData.iconButtonTheme]s value
  final double? size;

  /// Standardized tool for toggling [TextDecoration.underline] in the [TextStyle.decoration] that matches [configKey]
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

  late final ColorScheme colorScheme = Theme.of(context).colorScheme;

  late bool isUnderlined = EzConfig.get(widget.configKey) ?? false;

  // Define the build //

  late final String tooltip = EFUILang.of(context)!.tsUnderline;

  void swapState() async {
    isUnderlined = !isUnderlined;
    await EzConfig.setBool(widget.configKey, isUnderlined);
    widget.notifierCallback(isUnderlined);
    setState(() {});
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return isUnderlined
        ? IconButton(
            style: IconButton.styleFrom(
              foregroundColor: colorScheme.primary,
              iconSize: widget.size,
            ),
            onPressed: swapState,
            tooltip: tooltip,
            icon: EzIcon(Icons.format_underline),
          )
        : IconButton(
            style: IconButton.styleFrom(
              foregroundColor: colorScheme.outline,
              iconSize: widget.size,
            ),
            onPressed: swapState,
            tooltip: tooltip,
            icon: EzIcon(Icons.format_underline_outlined),
          );
  }
}
