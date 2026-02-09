/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../utils/export.dart';
import '../../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class DesignSettingsScreen extends StatefulWidget {
  DesignSettingsScreen() : super(key: ValueKey<int>(EzConfig.seed));

  @override
  State<DesignSettingsScreen> createState() => _DesignSettingsScreenState();
}

class _DesignSettingsScreenState extends State<DesignSettingsScreen> {
  bool updateBoth = false;

  @override
  Widget build(BuildContext context) => OpenUIScaffold(
        const EzScreen(EzDesignSettings(
          onRedraw: doNothing,
          appName: appName,
          androidPackage: androidPackage,
        )),
        title: EzConfig.l10n.dsPageTitle,
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
