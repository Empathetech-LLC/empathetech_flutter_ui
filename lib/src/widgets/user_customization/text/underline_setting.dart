/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzUnderlineSetting extends StatefulWidget {
  /// The [EzConfig] whose value is being updated
  final String configKey;

  /// An alt to updateBoth
  final String? mirrorKey;

  /// Optional callback to live update the [TextStyle] on your UI
  final void Function(bool underline) notifierCallback;

  /// Standardized tool for toggling [TextDecoration.underline] in the [TextStyle.decoration] that matches [configKey]
  const EzUnderlineSetting({
    super.key,
    required this.configKey,
    this.mirrorKey,
    required this.notifierCallback,
  });

  @override
  State<EzUnderlineSetting> createState() => _EzUnderlineSettingState();
}

class _EzUnderlineSettingState extends State<EzUnderlineSetting> {
  late bool isUnderlined = EzConfig.get(widget.configKey) ?? false;

  @override
  Widget build(BuildContext context) => EzIconButton(
        fauxDisabled: !isUnderlined,
        onPressed: () async {
          isUnderlined = !isUnderlined;
          await EzConfig.setBool(widget.configKey, isUnderlined);
          if (widget.mirrorKey != null) {
            await EzConfig.setBool(widget.mirrorKey!, isUnderlined);
          }
          widget.notifierCallback(isUnderlined);
          setState(() {});
        },
        tooltip: EzConfig.l10n.tsUnderline,
        icon: const Icon(Icons.format_underline),
      );
}
