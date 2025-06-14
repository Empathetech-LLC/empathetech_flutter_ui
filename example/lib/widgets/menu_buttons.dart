/* open_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../models/export.dart';
import '../screens/export.dart';
import '../utils/export.dart';

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class SettingsButton extends StatelessWidget {
  final BuildContext parentContext;

  /// [EzMenuButton] for opening the settings
  const SettingsButton(this.parentContext, {super.key});

  @override
  Widget build(BuildContext context) => EzMenuButton(
        onPressed: () => parentContext.goNamed(settingsHomePath),
        icon: EzIcon(PlatformIcons(context).settings),
        label: ezL10n(context).ssPageTitle,
      );
}

class UploadButton extends StatelessWidget {
  final BuildContext parentContext;
  final Future<void> Function(EAGConfig) onUpload;

  /// [EzMenuButton] for uploading a config
  const UploadButton(
    this.parentContext, {
    super.key,
    required this.onUpload,
  });

  @override
  Widget build(BuildContext context) => EzMenuButton(
        onPressed: () async {
          final FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: <String>['json'],
          );

          if (result != null && result.files.single.path != null) {
            final String filePath = result.files.single.path!;
            final String fileContent = await File(filePath).readAsString();

            try {
              final Map<String, dynamic> jsonData = jsonDecode(fileContent);
              final EAGConfig config = EAGConfig.fromJson(jsonData);

              await onUpload(config);
            } catch (e) {
              if (context.mounted) {
                ezSnackBar(
                  context: context,
                  message: e.toString(),
                );
              }
            }
          }
        },
        icon: EzIcon(Icons.upload),
        label: Lang.of(context)!.csLoad,
      );
}

class OpenSourceButton extends StatelessWidget {
  /// [EzMenuButton] for opening the EFUI GitHub repo
  const OpenSourceButton({super.key});

  @override
  Widget build(BuildContext context) {
    final EFUILang l10n = ezL10n(context);
    final String text = l10n.gOpenSource;

    return Link(
      uri: Uri.parse(
        'https://github.com/Empathetech-LLC/empathetech_flutter_ui',
      ),
      builder: (_, FollowLink? followLink) => EzMenuButton(
        onPressed: followLink,
        semanticsLabel: '$text: ${l10n.gEFUISourceHint}',
        icon: EzIcon(LineIcons.github),
        label: text,
      ),
    );
  }
}
