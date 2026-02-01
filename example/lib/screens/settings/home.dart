/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../screens/export.dart';
import '../../utils/export.dart';
import '../../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class SettingsHomeScreen extends StatelessWidget {
  SettingsHomeScreen() : super(key: ValueKey<int>(EzConfig.seed));

  @override
  Widget build(BuildContext context) => OpenUIScaffold(
        const EzScreen(EzSettingsHome(
          colorSettingsPath: colorSettingsPath,
          designSettingsPath: designSettingsPath,
          layoutSettingsPath: layoutSettingsPath,
          textSettingsPath: textSettingsPath,
          appName: appName,
          androidPackage: androidPackage,
        )),
        title: EzConfig.l10n.ssPageTitle,
        showSettings: false,
        fabs: <Widget>[
          EzConfig.spacer,
          EzConfigFAB(
            context,
            appName: appName,
            androidPackage: androidPackage,
          ),
        ],
      );
}
