/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class ColorSettingsScreen extends StatefulWidget {
  const ColorSettingsScreen({super.key});

  @override
  State<ColorSettingsScreen> createState() => _ColorSettingsScreenState();
}

class _ColorSettingsScreenState extends State<ColorSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return const OpenUIScaffold(
      body: ColorSettings(
        lightBackgroundImageKey: lightPageImageKey,
        darkBackgroundImageKey: darkPageImageKey,
      ),
    );
  }
}
