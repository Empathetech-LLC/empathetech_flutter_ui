/* open_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
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
        title: ezL10n(context).csPageTitle,
        showSettings: false,
        body: EzScreen(EzColorSettings(target: target)),
        fabs: <Widget>[
          ezSpacer,
          EzConfigFAB(
            context,
            appName: appName,
            androidPackage: androidPackage,
          ),
        ],
      );
}
