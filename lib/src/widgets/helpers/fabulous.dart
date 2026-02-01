/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class EzBackFAB extends StatelessWidget {
  final bool showHome;

  /// [FloatingActionButton] that goes back; [Navigator.pop]
  const EzBackFAB({super.key, this.showHome = false});

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        heroTag: 'back_fab',
        tooltip: EzConfig.l10n.gBack,
        onPressed: () => Navigator.of(context).maybePop(),
        child: EzIcon(showHome ? Icons.home : Icons.arrow_back),
      );
}

class EzConfigFAB extends StatelessWidget {
  /// App Name
  final String appName;

  /// com.example.app
  final String? androidPackage;

  /// Dumps all of [EzConfig] by default
  final Set<String>? skip;

  /// [FloatingActionButton] that saves/loads config to/from JSON file(s)
  const EzConfigFAB(
    BuildContext context, {
    super.key,
    required this.appName,
    this.androidPackage,
    this.skip,
  });

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (_, MenuController controller, __) {
        return FloatingActionButton(
          heroTag: 'config_fab',
          tooltip: EzConfig.l10n.ssConfigTip,
          onPressed: () =>
              (controller.isOpen) ? controller.close() : controller.open(),
          child: EzIcon(Icons.save),
        );
      },
      menuChildren: <Widget>[
        // Save config
        EzMenuButton(
          label: EzConfig.l10n.ssSaveConfig,
          onPressed: () => EzConfig.saveConfig(
            context,
            appName: appName,
            androidPackage: androidPackage,
            skip: skip,
          ),
        ),

        // Load config
        EzMenuButton(
          label: EzConfig.l10n.ssLoadConfig,
          onPressed: () => ezConfigLoader(context),
        ),
      ],
    );
  }
}

class EzSettingsDupeFAB extends StatefulWidget {
  final void Function(bool) onSwitch;

  /// Toggle-able [FloatingActionButton] for updating both light and dark theme settings simultaneously
  const EzSettingsDupeFAB({super.key, required this.onSwitch});

  @override
  State<EzSettingsDupeFAB> createState() => _EzSettingsDupeFABState();
}

class _EzSettingsDupeFABState extends State<EzSettingsDupeFAB> {
  bool isDuplicating = false;

  @override
  Widget build(BuildContext context) => isDuplicating
      ? FloatingActionButton(
          onPressed: () {
            setState(() => isDuplicating = false);
            widget.onSwitch(false);
          },
          foregroundColor: EzConfig.colors.secondary,
          backgroundColor: EzConfig.colors.primary,
        )
      : FloatingActionButton(
          onPressed: () {
            setState(() => isDuplicating = true);
            widget.onSwitch(true);
          },
          foregroundColor: EzConfig.colors.outline,
          backgroundColor: EzConfig.colors.surface,
        );
}

class EzUpdaterFAB extends StatefulWidget {
  /// Local app version
  final String appVersion;

  /// Remote app version (truth)
  final String versionSource;

  /// Whether this is a web app
  /// If true, [gPlay], [appStore], and [github] are ignored
  /// An [EzAlertDialog] will appear telling the user to hard refresh
  final bool isWeb;

  /// Google Play Store URL
  /// Fallback to GitHub if null
  final String? gPlay;

  /// Apple App Store URL
  /// Fallback to GitHub if null
  final String? appStore;

  /// GitHub Releases URL
  /// Cannot be null when [isWeb] is false
  final String? github;

  /// [Visibility] wrapped [FloatingActionButton] that links to the latest version if/when there is a mismatch
  const EzUpdaterFAB({
    super.key,
    required this.appVersion,
    required this.versionSource,
    this.isWeb = false,
    this.gPlay,
    this.appStore,
    this.github,
  }) : assert(
          isWeb || github != null,
          'GitHub URL must be provided when isWeb is false',
        );

  @override
  State<EzUpdaterFAB> createState() => _EzUpdaterState();
}

class _EzUpdaterState extends State<EzUpdaterFAB> {
  // Define the build data //

  String? latestVersion;
  String? url;

  bool isLatest = true; // True to start to prevent flickering

  // Define custom functions //

  /// Check for Open UI updates (Desktop only)
  void checkVersion() async {
    if (isMobile()) return;

    final http.Response response =
        await http.get(Uri.parse(widget.versionSource));

    if (response.statusCode != 200) return;

    latestVersion = response.body;
    if (latestVersion != widget.appVersion && latestVersion != null) {
      final List<int> latestDigits =
          latestVersion!.split('.').map(int.parse).toList();

      if (latestDigits.length != 3) return;

      final List<int> appDigits =
          widget.appVersion.split('.').map(int.parse).toList();

      for (int i = 0; i < latestDigits.length; i++) {
        if (latestDigits[i] > appDigits[i]) {
          setState(() => isLatest = false);
          return;
        } else if (latestDigits[i] < appDigits[i]) {
          return;
        } // if == continue
      }
    }
  }

  /// Platform aware instructions
  String hardRefresh() {
    switch (EzConfig.platform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
        return EzConfig.l10n.gHardRefreshMobile;
      case TargetPlatform.macOS:
        return EzConfig.l10n.gHardRefreshMac;
      default:
        return EzConfig.l10n.gHardRefresh;
    }
  }

  // Init //

  @override
  void initState() {
    super.initState();
    checkVersion();

    switch (EzConfig.platform) {
      case TargetPlatform.android:
        url = widget.gPlay ?? widget.github;
      case TargetPlatform.iOS:
        url = widget.appStore ?? widget.github;
      default:
        url = widget.github;
    }
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !isLatest,
      child: widget.isWeb // Trinary required, if/else breaks iOS web links
          ? FloatingActionButton(
              heroTag: 'updater_fab',
              onPressed: () => showDialog(
                context: context,
                builder: (_) => EzAlertDialog(
                  title: Text(
                    EzConfig.l10n.gUpdates,
                    textAlign: TextAlign.center,
                  ),
                  content: Text(hardRefresh(), textAlign: TextAlign.center),
                ),
              ),
              tooltip: EzConfig.l10n.gUpdates,
              backgroundColor: EzConfig.colors.secondary,
              foregroundColor: EzConfig.colors.onSecondary,
              child: EzIcon(Icons.update),
            )
          : FloatingActionButton(
              heroTag: 'updater_fab',
              onPressed: () => launchUrl(Uri.parse(url ?? widget.github!)),
              tooltip: EzConfig.l10n.gUpdates,
              backgroundColor: EzConfig.colors.secondary,
              foregroundColor: EzConfig.colors.onSecondary,
              child: EzIcon(Icons.update),
            ),
    );
  }
}

class EzRebuildFAB extends StatelessWidget {
  /// [EzConfig.provider] passthrough
  final void Function()? onComplete;

  /// Optional override, defaults to 'Apply changes'
  final String? tooltip;

  /// Optional override, defaults to [PlatformIcons.checkMark]
  final IconData? icon;

  /// [FloatingActionButton] that rebuilds the app when pressed
  const EzRebuildFAB({super.key, this.onComplete, this.tooltip, this.icon});

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        heroTag: 'rebuild_fab',
        onPressed: () => EzConfig.rebuildUI(onComplete: onComplete),
        tooltip: tooltip ?? EzConfig.l10n.gApplyChanges,
        child: EzIcon(icon ?? Icons.check),
      );
}
