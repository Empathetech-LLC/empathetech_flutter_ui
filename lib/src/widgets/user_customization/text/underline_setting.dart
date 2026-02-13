/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzUnderlineSetting extends StatefulWidget {
  /// Which [TextStyle] to update
  final EzTextSettingType type;

  /// Callback to live update the [TextStyle] on your UI
  final void Function(bool underline) notifierCallback;

  /// Whether both [ThemeMode]s should be updated
  final bool updateBoth;

  /// Standardized tool for toggling [TextDecoration.underline] in the [TextStyle.decoration] that matches [type]
  const EzUnderlineSetting({
    required super.key,
    required this.type,
    required this.updateBoth,
    required this.notifierCallback,
  });

  @override
  State<EzUnderlineSetting> createState() => _EzUnderlineSettingState();
}

class _EzUnderlineSettingState extends State<EzUnderlineSetting> {
  late bool isUnderlined = EzConfig.get(widget.type.underlineKey) ?? false;

  @override
  Widget build(BuildContext context) => EzIconButton(
        fauxDisabled: !isUnderlined,
        onPressed: () async {
          isUnderlined = !isUnderlined;

          await EzConfig.setBool(widget.type.underlineKey, isUnderlined);
          if (widget.updateBoth) {
            await EzConfig.setBool(widget.type.underlineMirror, isUnderlined);
          }

          widget.notifierCallback(isUnderlined);
          if (context.mounted) {
            EzConfig.pingRebuild(widget.type.rebuildCheck(context));
          }

          setState(() {});
        },
        tooltip: EzConfig.l10n.tsUnderline,
        icon: const Icon(Icons.format_underline),
      );
}
