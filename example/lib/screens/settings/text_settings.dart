/* open_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class TextSettingsScreen extends StatelessWidget {
  const TextSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => OpenUIScaffold(
        title: EFUILang.of(context)!.tsPageTitle,
        showSettings: false,
        body: const EzTextSettings(),
      );
}
