/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzThemeCoin extends StatefulWidget {
  /// [EzIconButton] for toggling [EzConfig.updateBoth]
  const EzThemeCoin({super.key});

  @override
  State<EzThemeCoin> createState() => _EzThemeCoinState();
}

class _EzThemeCoinState extends State<EzThemeCoin> {
  bool both = EzConfig.updateBoth;
  // TODO: tooltip && semantics

  @override
  Widget build(BuildContext context) => EzIconButton(
        icon: Icon(both
            ? Icons.contrast
            : (EzConfig.isDark ? Icons.dark_mode : Icons.light_mode)),
        onPressed: () async {
          await EzConfig.setBool(updateBothKey, !both);
          setState(() => both = !both);
        },
      );
}
