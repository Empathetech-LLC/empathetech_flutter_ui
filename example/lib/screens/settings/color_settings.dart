/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class ColorSettingsScreen extends StatelessWidget {
  const ColorSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => OpenUIScaffold(
        title: EFUILang.of(context)!.csPageTitle,
        settingsMenu: false,
        body: const ColorSettings(),
      );
}
