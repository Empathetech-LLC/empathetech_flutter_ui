/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
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
  // Gather the fixed theme data //

  late final double padding = EzConfig.get(paddingKey);

  late final ColorScheme colorScheme = Theme.of(context).colorScheme;

  late bool isBold = EzConfig.get(widget.configKey) ?? false;

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return EzIconButton(
      style: isBold
          ? IconButton.styleFrom(
              foregroundColor: colorScheme.primary,
              side: BorderSide(color: colorScheme.primaryContainer),
              padding: EzInsets.wrap(padding),
            )
          : IconButton.styleFrom(
              foregroundColor: colorScheme.outline,
              side: BorderSide(color: colorScheme.outlineVariant),
              padding: EzInsets.wrap(padding),
            ),
      onPressed: () async {
        isBold = !isBold;
        await EzConfig.setBool(widget.configKey, isBold);
        widget.notifierCallback(isBold);
        setState(() {});
      },
      tooltip: ezL10n(context).tsBold,
      iconSize: widget.size,
      icon: const Icon(Icons.format_bold_outlined),
    );
  }
}
