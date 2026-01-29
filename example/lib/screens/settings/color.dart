/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../utils/export.dart';
import '../../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class ColorSettingsScreen extends StatelessWidget {
  final EzCSType? target;

  const ColorSettingsScreen({super.key, this.target});

  @override
  Widget build(BuildContext context) => OpenUIScaffold(
        EzScreen(EzColorSettings(
          target: target,
          appName: appName,
          androidPackage: androidPackage,
        )),
        title: EzConfig.l10n.csPageTitle,
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
