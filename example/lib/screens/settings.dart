/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../utils/export.dart';
import '../../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class SettingsHubScreen extends StatefulWidget {
  /// Auto-navigate to quick/advanced
  final EzCSType? cTarget;

  /// Auto-navigate to quick/advanced
  final EzTSType? tTarget;

  SettingsHubScreen({
    this.cTarget,
    this.tTarget,
  }) : super(key: ValueKey<int>(EzConfig.seed));

  @override
  State<SettingsHubScreen> createState() => _SettingsHubScreenState();
}

class _SettingsHubScreenState extends State<SettingsHubScreen> {
  bool updateBoth = false;

  void redraw() => setState(() {});
  // TODO: figure out how to think less
  // Each time you redraw one "screen" you're actually doing all of them)
  // Probably keys... maybe keys and a param for redraw?
  // maybe not though... maybe pass build as a func and only actually build when active

  @override
  Widget build(BuildContext context) => Consumer<EzConfigProvider>(
        builder: (_, EzConfigProvider config, __) => OpenUIScaffold(
          EzScreen(EzSettingsHub(
            pages: <EzSettingsSection>[
              // Global
              EzSettingsSection(
                title: 'Global', // TODO: l10n && check web icons
                icon: EzConfig.onMobile
                    ? Icon(EzConfig.platform == TargetPlatform.iOS
                        ? Icons.phone_iphone
                        : Icons.phone_android)
                    : const Icon(Icons.computer),
                build: const EzGlobalSettings(
                  appName: appName,
                  androidPackage: androidPackage,
                ),
              ),

              // Color
              EzSettingsSection(
                title: 'Color',
                icon: const Icon(Icons.palette),
                build: EzColorSettings(
                  target: widget.cTarget,
                  onUpdate: redraw,
                  updateBoth: updateBoth,
                  appName: appName,
                  androidPackage: androidPackage,
                ),
              ),

              // Design
              EzSettingsSection(
                title: 'Design',
                icon: const Icon(Icons.design_services),
                build: EzDesignSettings(
                  onUpdate: () => redraw,
                  updateBoth: updateBoth,
                  appName: appName,
                  androidPackage: androidPackage,
                ),
              ),

              // Layout
              EzSettingsSection(
                title: 'Layout',
                icon: const Icon(Icons.grid_3x3),
                build: EzLayoutSettings(
                  onUpdate: redraw,
                  updateBoth: updateBoth,
                  appName: appName,
                  androidPackage: androidPackage,
                ),
              ),

              // Text
              EzSettingsSection(
                title: 'Text',
                icon: const Icon(Icons.text_format),
                build: EzTextSettings(
                  target: widget.tTarget,
                  onUpdate: redraw,
                  updateBoth: updateBoth,
                  appName: appName,
                  androidPackage: androidPackage,
                ),
              ),
            ],
          )),
          title: config.l10n.ssPageTitle,
          showSettings: false,
          fabs: <Widget>[
            if (config.needsRebuild) ...<Widget>[
              config.layout.spacer,
              EzRebuildFAB(redraw),
            ],
            config.layout.spacer,
            EzSettingsDupeFAB(
              updateBoth,
              () => setState(() => updateBoth = !updateBoth),
            ),
          ],
        ),
      );
}
