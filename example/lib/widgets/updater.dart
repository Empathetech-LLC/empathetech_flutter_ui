/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../utils/export.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class EzUpdater extends StatefulWidget {
  const EzUpdater({super.key});

  @override
  State<EzUpdater> createState() => _EzUpdaterState();
}

class _EzUpdaterState extends State<EzUpdater> {
  // Define build data //

  bool isLatest = true;
  String? thisVersion;

  static const String appVersionLink =
      'https://raw.githubusercontent.com/Empathetech-LLC/empathetech_flutter_ui/refs/heads/main/example/APP_VERSION';

  // Define custom functions //

  void checkVersion() async {
    final http.Response response = await http.get(Uri.parse(appVersionLink));

    if (response.statusCode != 200) return;

    thisVersion = response.body;
    if (thisVersion != appVersion) setState(() => isLatest = false);
  }

  @override
  void initState() {
    super.initState();
    checkVersion();
  }

  @override
  Widget build(BuildContext context) {
    late final TargetPlatform platform = getBasePlatform(context);

    return isLatest
        ? const SizedBox.shrink()
        : EzElevatedIconButton(
            onPressed: () {
              String? url;

              switch (platform) {
                case TargetPlatform.android:
                  url =
                      'https://play.google.com/store/apps/details?id=net.empathetech.open_ui';
                case TargetPlatform.iOS:
                  url = 'https://apps.apple.com/us/app/open-ui/id6499560244';
                default:
                  url =
                      'https://github.com/Empathetech-LLC/empathetech_flutter_ui/releases/download';

                  launchUrl(Uri.parse(url));
              }
            },
            icon: const Icon(Icons.update),
            label: EFUILang.of(context)!.gUpdates,
          );
  }
}
