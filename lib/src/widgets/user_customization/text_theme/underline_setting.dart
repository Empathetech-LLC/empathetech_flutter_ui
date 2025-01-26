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

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return EzIconButton(
      style: IconButton.styleFrom(
        foregroundColor:
            isUnderlined ? colorScheme.primary : colorScheme.outline,
      ),
      onPressed: () async {
        isUnderlined = !isUnderlined;
        await EzConfig.setBool(widget.configKey, isUnderlined);
        widget.notifierCallback(isUnderlined);
        setState(() {});
      },
      tooltip: EFUILang.of(context)!.tsUnderline,
      iconSize: widget.size,
      icon: const Icon(Icons.format_underline),
    );
  }
}
