/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../utils/export.dart';
import '../../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class DesignSettingsScreen extends StatefulWidget {
  DesignSettingsScreen() : super(key: ValueKey<int>(EzConfig.seed));

  @override
  State<DesignSettingsScreen> createState() => _DesignSettingsScreenState();
}

class _DesignSettingsScreenState extends State<DesignSettingsScreen> {
  bool updateBoth = false;

  @override
  Widget build(BuildContext context) => Consumer<EzConfigProvider>(
        builder: (_, EzConfigProvider config, __) => OpenUIScaffold(
          EzScreen(EzDesignSettings(
            onUpdate: () => setState(() {}),
            updateBoth: updateBoth,
            appName: appName,
            androidPackage: androidPackage,
          )),
          title: config.l10n.dsPageTitle,
          showSettings: false,
          fabs: <Widget>[
            if (config.needsRebuild) ...<Widget>[
              config.layout.spacer,
              EzRebuildFAB(() => setState(() {})),
            ],
            config.layout.spacer,
            EzSettingsDupeFAB(
              updateBoth,
              () => setState(() => updateBoth = !updateBoth),
            ),
          ],
        ),
      );
}
