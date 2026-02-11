/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzItalicSetting extends StatefulWidget {
  /// The [EzConfig] whose value is being updated
  final String configKey;

  /// An alt to updateBoth
  final String? mirrorKey;

  /// Optional callback to live update the [TextStyle] on your UI
  final void Function(bool italic) notifierCallback;

  /// Standardized tool for toggling [FontStyle.italic] in the [TextStyle.fontStyle] that matches [configKey]
  const EzItalicSetting({
    super.key,
    required this.configKey,
    this.mirrorKey,
    required this.notifierCallback,
  });

  @override
  State<EzItalicSetting> createState() => _EzItalicSettingState();
}

class _EzItalicSettingState extends State<EzItalicSetting> {
  late bool isItalic = EzConfig.get(widget.configKey) ?? false;

  @override
  Widget build(BuildContext context) => EzIconButton(
        fauxDisabled: !isItalic,
        onPressed: () async {
          isItalic = !isItalic;
          await EzConfig.setBool(widget.configKey, isItalic);
          if (widget.mirrorKey != null) {
            await EzConfig.setBool(widget.mirrorKey!, isItalic);
          }
          widget.notifierCallback(isItalic);
          setState(() {});
        },
        tooltip: EzConfig.l10n.tsItalic,
        icon: const Icon(Icons.format_italic),
      );
}
