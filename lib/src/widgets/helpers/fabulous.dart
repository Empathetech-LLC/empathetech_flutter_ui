/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:file_saver/file_saver.dart';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzBackFAB extends StatelessWidget {
  final bool showHome;
  final bool hold4Feedback;
  final String? supportEmail;
  final String? appName;

  /// [FloatingActionButton] that goes back; [Navigator.pop]
  const EzBackFAB({
    super.key,
    this.showHome = false,
    this.hold4Feedback = false,
    this.supportEmail,
    this.appName,
  }) : assert(
          !hold4Feedback || (supportEmail != null && appName != null),
          'supportEmail and appName must be provided when hold4Feedback is true',
        );

  @override
  Widget build(BuildContext context) => hold4Feedback
      ? GestureDetector(
          onLongPress: () => ezFeedback(
            parentContext: context,
            l10n: ezL10n(context),
            supportEmail: supportEmail ?? 'null',
            appName: appName ?? 'null',
          ),
          child: FloatingActionButton(
            heroTag: 'back_fab',
            tooltip: null,
            onPressed: () => Navigator.of(context).maybePop(),
            child: EzIcon(showHome
                ? PlatformIcons(context).home
                : PlatformIcons(context).back),
          ),
        )
      : FloatingActionButton(
          heroTag: 'back_fab',
          tooltip: ezL10n(context).gBack,
          onPressed: () => Navigator.of(context).maybePop(),
          child: EzIcon(showHome
              ? PlatformIcons(context).home
              : PlatformIcons(context).back),
        );
}

class EzConfigFAB extends StatelessWidget {
  /// App Name
  final String appName;

  /// com.example.app
  final String? androidPackage;

  /// [allKeys] included by default
  /// Include any app specific keys you want backed up here
  final List<String>? extraKeys;

  /// [FloatingActionButton] that saves/loads config to/from JSON file(s)
  const EzConfigFAB(
    BuildContext context, {
    super.key,
    required this.appName,
    required this.androidPackage,
    this.extraKeys,
  });

  @override
  Widget build(BuildContext context) {
    final EFUILang l10n = ezL10n(context);

    return MenuAnchor(
      builder: (_, MenuController controller, __) {
        return FloatingActionButton(
          heroTag: 'config_fab',
          tooltip: l10n.ssConfigTip,
          onPressed: () =>
              (controller.isOpen) ? controller.close() : controller.open(),
          child: EzIcon(Icons.save),
        );
      },
      menuChildren: <Widget>[
        // Save config
        EzMenuButton(
          label: l10n.ssSaveConfig,
          onPressed: () async {
            final List<String> keys = <String>[
              ...allKeys.keys,
              if (extraKeys != null) ...extraKeys!,
            ];

            final Map<String, dynamic> config =
                Map<String, dynamic>.fromEntries(keys.map(
              (String key) => MapEntry<String, dynamic>(
                key,
                EzConfig.get(key),
              ),
            ));

            try {
              await FileSaver.instance.saveFile(
                name: '${ezTitleToSnake(appName)}_settings.json',
                bytes: utf8.encode(jsonEncode(config)),
                mimeType: MimeType.json,
              );
            } catch (e) {
              if (context.mounted) ezLogAlert(context, message: e.toString());
              return;
            }

            if (context.mounted) {
              ezSnackBar(
                context: context,
                message: l10n.ssConfigSaved(archivePath(
                  appName: appName,
                  androidPackage: androidPackage,
                )),
              );
            }
          },
        ),

        // Load config
        EzMenuButton(
          label: l10n.ssLoadConfig,
          onPressed: () async {
            final FilePickerResult? result =
                await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: <String>['json'],
            );

            try {
              if (result != null && result.files.single.path != null) {
                if (kIsWeb) {
                  final Uint8List? fileBytes = result.files.first.bytes;
                  if (fileBytes == null) throw 'null file';

                  final String fileContent = utf8.decode(fileBytes);
                  await EzConfig.loadConfig(jsonDecode(fileContent));
                } else {
                  final String filePath = result.files.single.path!;
                  final String fileContent =
                      await File(filePath).readAsString();

                  await EzConfig.loadConfig(jsonDecode(fileContent));
                }
              }
            } catch (e) {
              if (context.mounted) ezLogAlert(context, message: e.toString());
              return;
            }

            if (context.mounted) {
              ezSnackBar(
                context: context,
                message:
                    kIsWeb ? l10n.ssRestartReminderWeb : l10n.ssRestartReminder,
              );
            }
          },
        ),
      ],
    );
  }
}

class EzUpdaterFAB extends StatefulWidget {
  /// Local app version
  final String appVersion;

  /// Remote app version (truth)
  final String versionSource;

  /// Google Play Store URL
  final String gPlay;

  /// Apple App Store URL
  final String appStore;

  /// GitHub Releases URL
  final String github;

  /// [Visibility] wrapped [FloatingActionButton] that links to the latest version if/when there is a mismatch
  const EzUpdaterFAB({
    super.key,
    required this.appVersion,
    required this.versionSource,
    required this.gPlay,
    required this.appStore,
    required this.github,
  });

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

  // Init //

  @override
  void initState() {
    super.initState();
    checkVersion();

    final TargetPlatform platform = getBasePlatform();
    switch (platform) {
      case TargetPlatform.android:
        url = widget.gPlay;
      case TargetPlatform.iOS:
        url = widget.appStore;
      default:
        url = widget.github;
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
        onPressed: () => launchUrl(Uri.parse(url ?? widget.github)),
        tooltip: ezL10n(context).gUpdates,
        backgroundColor: colorScheme.secondary,
        foregroundColor: colorScheme.onSecondary,
        child: EzIcon(Icons.update),
      ),
    );
  }
}
