/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/foundation.dart';

import '../../../empathetech_flutter_ui.dart';

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_saver/file_saver.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzBackFAB extends FloatingActionButton {
  /// [FloatingActionButton] that goes back; [Navigator.pop]
  EzBackFAB(BuildContext context, {super.key, bool showHome = false})
      : super(
          heroTag: 'back_fab',
          child: EzIcon(showHome
              ? PlatformIcons(context).home
              : PlatformIcons(context).back),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: ezL10n(context).gBack,
        );
}

class EzConfigFAB extends StatelessWidget {
  /// 'App Name'
  final String appName;

  /// 'com.example.app'
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

            late final String savedConfig;
            try {
              savedConfig = await FileSaver.instance.saveFile(
                name: '${ezTitleToSnake(appName)}_settings.json',
                bytes: utf8.encode(jsonEncode(config)),
                mimeType: MimeType.json,
              );
            } catch (e) {
              if (context.mounted) ezLogAlert(context, message: e.toString());
              return;
            }

            if (context.mounted) {
              savedConfig.endsWith('.json')
                  ? ezSnackBar(
                      context: context,
                      message: l10n.ssConfigSaved(archivePath(
                        appName: appName,
                        androidPackage: androidPackage,
                      )),
                    )
                  : ezLogAlert(
                      context,
                      message:
                          '${l10n.ssWrongConfigExt} .json...\n\n$savedConfig',
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

            if (result != null && result.files.single.path != null) {
              final String filePath = result.files.single.path!;
              final String fileContent = await File(filePath).readAsString();

              try {
                await EzConfig.loadConfig(jsonDecode(fileContent));
              } catch (e) {
                if (context.mounted) {
                  ezLogAlert(context, message: e.toString());
                }
              }
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
