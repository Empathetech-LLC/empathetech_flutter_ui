/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../utils/export.dart';
import '../../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class LayoutSettingsScreen extends StatefulWidget {
  LayoutSettingsScreen() : super(key: ValueKey<int>(EzConfig.seed));

  @override
  State<LayoutSettingsScreen> createState() => _LayoutSettingsScreenState();
}

class _LayoutSettingsScreenState extends State<LayoutSettingsScreen> {
  bool updateBoth = false;

  @override
  Widget build(BuildContext context) => OpenUIScaffold(
        EzScreen(EzLayoutSettings(
          onUpdate: () => setState(() {}),
          updateBoth: updateBoth,
          appName: appName,
          androidPackage: androidPackage,
        )),
        title: EzConfig.l10n.lsPageTitle,
        showSettings: false,
        fabs: <Widget>[
          EzConfig.spacer,
          EzSettingsDupeFAB(
            updateBoth,
            () => setState(() => updateBoth = !updateBoth),
          ),
        ],
      );
}
