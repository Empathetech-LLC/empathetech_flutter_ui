/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzBoldSetting extends StatefulWidget {
  /// Which [TextStyle] to update
  final EzTextSettingType type;

  /// Callback to live update the [TextStyle] on your UI
  final void Function(bool bold) notifierCallback;

  /// Whether both [ThemeMode]s should be updated
  final bool updateBoth;

  /// Standardized tool for toggling [FontWeight.bold] in the [TextStyle.fontWeight] that matches [type]
  const EzBoldSetting({
    required super.key,
    required this.type,
    required this.updateBoth,
    required this.notifierCallback,
  });

  @override
  State<EzBoldSetting> createState() => _EzBoldSettingState();
}

class _EzBoldSettingState extends State<EzBoldSetting> {
  late bool isBold = EzConfig.get(widget.type.boldKey) ?? false;

  @override
  Widget build(BuildContext context) => EzIconButton(
        fauxDisabled: !isBold,
        onPressed: () async {
          isBold = !isBold;

          await EzConfig.setBool(widget.type.boldKey, isBold);
          if (widget.updateBoth) {
            await EzConfig.setBool(widget.type.boldMirror, isBold);
          }

          widget.notifierCallback(isBold);
          if (context.mounted) {
            EzConfig.pingRebuild(widget.type.rebuildCheck(context));
          }

          setState(() {});
        },
        tooltip: EzConfig.l10n.tsBold,
        icon: const Icon(Icons.format_bold_outlined),
      );
}
