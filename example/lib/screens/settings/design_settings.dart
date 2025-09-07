/* open_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../utils/export.dart';
import '../../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class DesignSettingsScreen extends StatelessWidget {
  const DesignSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => OpenUIScaffold(
        title: ezL10n(context).dsPageTitle,
        showSettings: false,
        body: const EzScreen(EzDesignSettings()),
        fab: EzConfigFAB(context, packageName: packageName, appName: appTitle),
      );
}
