/* open_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../screens/export.dart';
import '../../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class SettingsHomeScreen extends StatelessWidget {
  const SettingsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) => OpenUIScaffold(
        title: EFUILang.of(context)!.ssPageTitle,
        showSettings: false,
        body: const EzSettingsHome(
          textSettingsPath: textSettingsPath,
          layoutSettingsPath: layoutSettingsPath,
          colorSettingsPath: colorSettingsPath,
          imageSettingsPath: imageSettingsPath,
        ),
      );
}
