/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class ImageSettingsScreen extends StatefulWidget {
  const ImageSettingsScreen({super.key});

  @override
  State<ImageSettingsScreen> createState() => _ImageSettingsScreenState();
}

class _ImageSettingsScreenState extends State<ImageSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return const OpenUIScaffold(
      body: ImageSettings(
        lightBackgroundImageKey: lightBackgroundImageKey,
        darkBackgroundImageKey: darkBackgroundImageKey,
      ),
    );
  }
}
