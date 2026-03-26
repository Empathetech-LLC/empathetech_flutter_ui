/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../utils/export.dart';
import '../../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class SettingsHubScreen extends StatelessWidget {
  /// [EzSettingsHub.target] passthrough
  final int? target;

  /// [EzColorSettings.advanced] and/or [EzTextSettings.advanced] passthrough
  final bool? advanced;

  SettingsHubScreen({this.target, this.advanced})
      : super(key: ValueKey<int>(EzConfig.seed));

  @override
  Widget build(BuildContext context) {
    return Consumer<EzConfigProvider>(
      builder: (_, EzConfigProvider config, __) => OpenUIScaffold(
        EzScreen(EzSettingsHub(
          pages: <EzSettingsSection>[
            // Global
            EzSettingsSection(
              position: 0,
              title: EzConfig.l10n.gGlobal,
              icon: config.onMobile
                  ? Icon(config.platform == TargetPlatform.iOS
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
              position: 1,
              title: EzConfig.l10n.gColor,
              icon: const Icon(Icons.palette),
              build: EzColorSettings(
                advanced: advanced,
                onUpdate: doNothing,
                appName: appName,
                androidPackage: androidPackage,
              ),
            ),

            // Design
            EzSettingsSection(
              position: 2,
              title: EzConfig.l10n.gDesign,
              icon: const Icon(Icons.design_services),
              build: const EzDesignSettings(
                onUpdate: doNothing,
                appName: appName,
                androidPackage: androidPackage,
              ),
            ),

            // Layout
            EzSettingsSection(
              position: 3,
              title: EzConfig.l10n.gLayout,
              icon: const Icon(Icons.grid_3x3),
              build: const EzLayoutSettings(
                onUpdate: doNothing,
                appName: appName,
                androidPackage: androidPackage,
              ),
            ),

            // Text
            EzSettingsSection(
              position: 4,
              title: EzConfig.l10n.gText,
              icon: const Icon(Icons.text_format),
              build: EzTextSettings(
                advanced: advanced,
                onUpdate: doNothing,
                appName: appName,
                androidPackage: androidPackage,
              ),
            ),
          ],
          target: target,
        )),
        title: config.l10n.gSettings,
        showSettings: false,
        fabs: <Widget>[
          // Rebuild (conditional)
          if (config.needsRebuild) ...<Widget>[
            config.layout.spacer,
            const EzRebuildFAB(doNothing),
          ],

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
