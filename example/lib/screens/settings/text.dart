/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../utils/export.dart';
import '../../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class TextSettingsScreen extends StatefulWidget {
  final EzTSType? target;

  TextSettingsScreen({this.target}) : super(key: ValueKey<int>(EzConfig.seed));

  @override
  State<TextSettingsScreen> createState() => _TextSettingsScreenState();
}

class _TextSettingsScreenState extends State<TextSettingsScreen> {
  bool updateBoth = false;

  @override
  Widget build(BuildContext context) => Consumer<EzConfigProvider>(
        builder: (_, EzConfigProvider config, __) => OpenUIScaffold(
          EzScreen(EzTextSettings(
            target: widget.target,
            onUpdate: () => setState(() {}),
            updateBoth: updateBoth,
            appName: appName,
            androidPackage: androidPackage,
          )),
          title: config.l10n.tsPageTitle,
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
