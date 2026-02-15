/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzItalicSetting extends StatefulWidget {
  /// Which [TextStyle] to update
  final EzTextSettingType type;

  /// Callback to live update the [TextStyle] on your UI
  final void Function(bool italic) notifierCallback;

  /// Whether both [ThemeMode]s should be updated
  final bool updateBoth;

  /// Standardized tool for toggling [FontStyle.italic] in the [TextStyle.fontStyle] that matches [type]
  const EzItalicSetting({
    required super.key,
    required this.type,
    required this.updateBoth,
    required this.notifierCallback,
  });

  @override
  State<EzItalicSetting> createState() => _EzItalicSettingState();
}

class _EzItalicSettingState extends State<EzItalicSetting> {
  late bool isItalic = EzConfig.get(widget.type.italicKey) ?? false;

  @override
  Widget build(BuildContext context) => EzIconButton(
        fauxDisabled: !isItalic,
        onPressed: () async {
          isItalic = !isItalic;

          await EzConfig.setBool(widget.type.italicKey, isItalic);
          if (widget.updateBoth) {
            await EzConfig.setBool(widget.type.italicMirror, isItalic);
          }

          widget.notifierCallback(isItalic);
          if (context.mounted) {
            EzConfig.pingRebuild(ezTextRebuildCheck(context));
          }

          setState(() {});
        },
        tooltip: EzConfig.l10n.tsItalic,
        icon: const Icon(Icons.format_italic),
      );
}
