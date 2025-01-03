/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import './shared.dart';
import '../../structs/export.dart';
import '../../widgets/export.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_saver/file_saver.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class SaveScreen extends StatefulWidget {
  final EAGConfig config;

  const SaveScreen({super.key, required this.config});

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  // Gather the theme data //

  late final EFUILang l10n = EFUILang.of(context)!;
  late final TextTheme textTheme = Theme.of(context).textTheme;

  // Define the build data //

  late final TargetPlatform platform = getBasePlatform(context);
  late final bool isDesktop = platform == TargetPlatform.linux ||
      platform == TargetPlatform.macOS ||
      platform == TargetPlatform.windows;

  late Widget centerPiece = loadingPage(context);

  // Define custom functions //

  /// Save the config
  void archive() async {
    late final String savedConfig;
    try {
      savedConfig = await FileSaver.instance.saveFile(
        name: '${widget.config.appName}_eag_config.json',
        bytes: utf8.encode(jsonEncode(widget.config.toJson())),
        mimeType: MimeType.json,
      );
    } catch (e) {
      setState(() => centerPiece = failurePage(
            context,
            '\n${e.toString()}',
            textTheme,
          ));
    }

    savedConfig.endsWith('.json')
        ? setState(() => centerPiece = successPage(
              context,
              '''\nYour configuration has been saved to ${archivePath()}

Use it on Open UI for desktop to generate the code for ${widget.config.appName}''',
              textTheme,
            ))
        : setState(() => centerPiece = failurePage(
              context,
              '\nThe file was not saved as .json...\n\n$savedConfig',
              textTheme,
            ));
  }

  /// Generate a (platform aware) human readable path for the saved config
  String archivePath() {
    switch (platform) {
      case TargetPlatform.android:
        return 'Root > Android > Data > net.empathetech.open_ui > files';
      case TargetPlatform.iOS:
        return 'Files > Browse > Open UI';
      default:
        return 'Downloads';
    }
  }

  // Return the build //

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => archive());
  }

  @override
  Widget build(_) =>
      OpenUIScaffold(title: 'Archiver', body: EzScreen(child: centerPiece));
}
