/* open_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../utils/export.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

const String _gPlay =
    'https://play.google.com/store/apps/details?id=net.empathetech.open_ui';

const String _appStore = 'https://apps.apple.com/us/app/open-ui/id6499560244';

const String _github =
    'https://_github.com/Empathetech-LLC/empathetech_flutter_ui/releases';

const String _versionSource =
    'https://raw._githubusercontent.com/Empathetech-LLC/empathetech_flutter_ui/refs/heads/main/example/APP_VERSION';

class EzUpdater extends StatefulWidget {
  /// Checks for Open UI updates
  /// [FloatingActionButton] (wrapped in a [Visibility]) that links to the latest version
  const EzUpdater({super.key});

  @override
  State<EzUpdater> createState() => _EzUpdaterState();
}

class _EzUpdaterState extends State<EzUpdater> {
  // Define build data //

  String? latestVersion;
  String? url;

  bool isLatest = true; // True to start to prevent flickering

  // Define custom functions //

  /// Check for Open UI updates
  void checkVersion() async {
    final http.Response response = await http.get(Uri.parse(_versionSource));

    if (response.statusCode != 200) return;

    latestVersion = response.body;
    if (latestVersion != appVersion && latestVersion != null) {
      final List<int> latestDigits =
          latestVersion!.split('.').map(int.parse).toList();

      if (latestDigits.length != 3) return;

      final List<int> appDigits = appVersion.split('.').map(int.parse).toList();

      for (int i = 0; i < latestDigits.length; i++) {
        if (latestDigits[i] > appDigits[i]) {
          setState(() => isLatest = false);
          return;
        } else if (latestDigits[i] < appDigits[i]) {
          return;
        }
      }
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Visibility(
      visible: !isLatest,
      child: FloatingActionButton(
        heroTag: null,
        onPressed: () => launchUrl(Uri.parse(url ?? _github)),
        tooltip: EFUILang.of(context)!.gUpdates,
        backgroundColor: colorScheme.secondary,
        foregroundColor: colorScheme.onSecondary,
        child: EzIcon(Icons.update),
      ),
    );
  }
}
