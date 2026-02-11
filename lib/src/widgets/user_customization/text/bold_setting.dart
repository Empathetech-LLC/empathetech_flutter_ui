/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzBoldSetting extends StatefulWidget {
  /// The [EzConfig] whose value is being updated
  final String configKey;

  /// An alt to updateBoth
  final String? mirrorKey;

  /// Optional callback to live update the [TextStyle] on your UI
  final void Function(bool bold) notifierCallback;

  /// Standardized tool for toggling [FontWeight.bold] in the [TextStyle.fontWeight] that matches [configKey]
  const EzBoldSetting({
    super.key,
    required this.configKey,
    this.mirrorKey,
    required this.notifierCallback,
  });

  @override
  State<EzBoldSetting> createState() => _EzBoldSettingState();
}

class _EzBoldSettingState extends State<EzBoldSetting> {
  late bool isBold = EzConfig.get(widget.configKey) ?? false;

  @override
  Widget build(BuildContext context) => EzIconButton(
        fauxDisabled: !isBold,
        onPressed: () async {
          isBold = !isBold;
          await EzConfig.setBool(widget.configKey, isBold);
          if (widget.mirrorKey != null) {
            await EzConfig.setBool(widget.mirrorKey!, isBold);
          }
          widget.notifierCallback(isBold);
          setState(() {});
        },
        tooltip: EzConfig.l10n.tsBold,
        icon: const Icon(Icons.format_bold_outlined),
      );
}
