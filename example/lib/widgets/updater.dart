/* open_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

/// 'https://play.google.com/store/apps/details?id=net.empathetech.open_ui'
const String _gPlay =
    'https://play.google.com/store/apps/details?id=net.empathetech.open_ui';

/// 'https://apps.apple.com/us/app/open-ui/id6499560244'
const String _appStore = 'https://apps.apple.com/us/app/open-ui/id6499560244';

/// 'https://github.com/Empathetech-LLC/empathetech_flutter_ui/releases'
const String _github =
    'https://github.com/Empathetech-LLC/empathetech_flutter_ui/releases';

/// 'https://raw.githubusercontent.com/Empathetech-LLC/empathetech_flutter_ui/refs/heads/main/example/APP_VERSION'
const String _versionSource =
    'https://raw.githubusercontent.com/Empathetech-LLC/empathetech_flutter_ui/refs/heads/main/example/APP_VERSION';

/// '2.3.0'
const String _appVersion = '2.3.0';

class EzUpdater extends StatefulWidget {
  /// Checks for Open UI updates
  /// [FloatingActionButton] (wrapped in a [Visibility]) that links to the latest version
  const EzUpdater({super.key});

  @override
  State<EzUpdater> createState() => _EzUpdaterState();
}

class _EzUpdaterState extends State<EzUpdater> {
  // Define the build data //

  String? latestVersion;
  String? url;

  bool isLatest = true; // True to start to prevent flickering

  // Define custom functions //

  /// Check for Open UI updates (Desktop only)
  void checkVersion() async {
    if (isMobile()) return;

    final http.Response response = await http.get(Uri.parse(_versionSource));

    if (response.statusCode != 200) return;

    latestVersion = response.body;
    if (latestVersion != _appVersion && latestVersion != null) {
      final List<int> latestDigits =
          latestVersion!.split('.').map(int.parse).toList();

      if (latestDigits.length != 3) return;

      final List<int> appDigits =
          _appVersion.split('.').map(int.parse).toList();

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

  // Init //

  @override
  void initState() {
    super.initState();
    checkVersion();

    final TargetPlatform platform = getBasePlatform();
    switch (platform) {
      case TargetPlatform.android:
        url = _gPlay;
      case TargetPlatform.iOS:
        url = _appStore;
      default:
        url = _github;
    }
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Visibility(
      visible: !isLatest,
      child: FloatingActionButton(
        heroTag: 'updater_fab',
        onPressed: () => launchUrl(Uri.parse(url ?? _github)),
        tooltip: ezL10n(context).gUpdates,
        backgroundColor: colorScheme.secondary,
        foregroundColor: colorScheme.onSecondary,
        child: EzIcon(Icons.update),
      ),
    );
  }
}
