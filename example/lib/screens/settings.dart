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
  void redraw() => setState(() {});

  bool updateBoth = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<EzConfigProvider>(
      builder: (_, EzConfigProvider config, __) => OpenUIScaffold(
        EzScreen(EzSettingsHub(pages: <EzSettingsSection>[
          // Global
          EzSettingsSection(
            title: EzConfig.l10n.gGlobal,
            icon: config.onMobile
                ? Icon(config.platform == TargetPlatform.iOS
                    ? Icons.phone_iphone
                    : Icons.phone_android)
                : const Icon(Icons.computer),
            build: EzGlobalSettings(
              key: ValueKey<int>(config.seed),
              appName: appName,
              androidPackage: androidPackage,
            ),
          ),

          // Color
          EzSettingsSection(
            title: EzConfig.l10n.gColor,
            icon: const Icon(Icons.palette),
            build: EzColorSettings(
              key: ValueKey<int>(config.seed),
              target: widget.cTarget,
              onUpdate: redraw,
              updateBoth: updateBoth,
              appName: appName,
              androidPackage: androidPackage,
            ),
          ),

          // Design
          EzSettingsSection(
            title: EzConfig.l10n.gDesign,
            icon: const Icon(Icons.design_services),
            build: EzDesignSettings(
              key: ValueKey<int>(config.seed),
              onUpdate: () => redraw,
              updateBoth: updateBoth,
              appName: appName,
              androidPackage: androidPackage,
            ),
          ),

          // Layout
          EzSettingsSection(
            title: EzConfig.l10n.gLayout,
            icon: const Icon(Icons.grid_3x3),
            build: EzLayoutSettings(
              key: ValueKey<int>(config.seed),
              onUpdate: redraw,
              updateBoth: updateBoth,
              appName: appName,
              androidPackage: androidPackage,
            ),
          ),

          // Text
          EzSettingsSection(
            title: EzConfig.l10n.gText,
            icon: const Icon(Icons.text_format),
            build: EzTextSettings(
              key: ValueKey<int>(config.seed),
              target: widget.tTarget,
              onUpdate: redraw,
              updateBoth: updateBoth,
              appName: appName,
              androidPackage: androidPackage,
            ),
          ),
        ])),
        title: config.l10n.gSettings,
        showSettings: false,
        fabs: <Widget>[
          // Rebuild (conditional)
          if (config.needsRebuild) ...<Widget>[
            config.layout.spacer,
            EzRebuildFAB(redraw),
          ],

          // Settings dupe/update both
          config.layout.spacer,
          EzSettingsDupeFAB(
            updateBoth,
            () => setState(() => updateBoth = !updateBoth),
          ),

          // Save/upload config
          config.layout.spacer,
          EzConfigFAB(
            context,
            appName: appName,
            androidPackage: androidPackage,
          ),
        ],
      ),
    );
  }
}
