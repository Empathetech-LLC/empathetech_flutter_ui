/* open_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class TextSettingsScreen extends StatelessWidget {
  final EzTSType? target;

  const TextSettingsScreen({super.key, this.target});

  @override
  Widget build(BuildContext context) => OpenUIScaffold(
        title: ezL10n(context).tsPageTitle,
        showSettings: false,
        body: EzTextSettings(target: target),
      );
}
