/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class LayoutSettingsScreen extends StatefulWidget {
  const LayoutSettingsScreen({super.key});

  @override
  State<LayoutSettingsScreen> createState() => _LayoutSettingsScreenState();
}

class _LayoutSettingsScreenState extends State<LayoutSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return const OpenUIScaffold(
      body: LayoutSettings(
        lightBackgroundImageKey: lightPageImageKey,
        darkBackgroundImageKey: darkPageImageKey,
      ),
    );
  }
}
