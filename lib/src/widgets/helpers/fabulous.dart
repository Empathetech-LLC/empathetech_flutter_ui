/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_saver/file_saver.dart';
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

class EzConfigFAB extends FloatingActionButton {
  /// [FloatingActionButton] that opens the configuration screen
  EzConfigFAB(
    BuildContext context, {
    super.key,
    required String packageName,
    required String appName,
    List<String>? extraKeys,
  }) : super(
          heroTag: 'config_fab',
          child: const Icon(Icons.save),
          onPressed: () async {
            final List<String> keys = <String>[
              ...allKeys.keys,
              if (extraKeys != null) ...extraKeys,
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
                name: '${appName}_settings.json',
                bytes: utf8.encode(jsonEncode(config)),
                mimeType: MimeType.json,
              );
            } catch (e) {
              if (context.mounted) ezLogAlert(context, message: e.toString());
            }

            if (context.mounted) {
              savedConfig.endsWith('.json')
                  ? ezSnackBar(
                      context: context,
                      message: ezL10n(context).ssConfigSaved(archivePath(
                        packageName: packageName,
                        appName: appName,
                      )),
                    )
                  : ezLogAlert(
                      context,
                      message:
                          '${ezL10n(context).ssWrongConfigExt} .json...\n\n$savedConfig',
                    );
            }
          },
          tooltip: ezL10n(context).gConfig,
        );
}
