/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../utils/export.dart';
import '../../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class ColorSettingsScreen extends StatefulWidget {
  final EzCSType? target;

  ColorSettingsScreen({this.target}) : super(key: ValueKey<int>(EzConfig.seed));

  @override
  State<ColorSettingsScreen> createState() => _ColorSettingsScreenState();
}

class _ColorSettingsScreenState extends State<ColorSettingsScreen> {
  bool updateBoth = false;

  @override
  Widget build(BuildContext context) => OpenUIScaffold(
        EzScreen(EzColorSettings(
          target: widget.target,
          updateBoth: updateBoth,
          appName: appName,
          androidPackage: androidPackage,
        )),
        title: EzConfig.l10n.csPageTitle,
        showSettings: false,
        fabs: <Widget>[
          EzConfig.spacer,
          EzSettingsDupeFAB(
            updateBoth,
            () => setState(() => updateBoth = !updateBoth),
          ),
        ],
      );
}
