/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../structs/export.dart';
import '../../widgets/export.dart';
import 'package:efui_bios/efui_bios.dart';

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_saver/file_saver.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class ThruConfigScreen extends StatefulWidget {
  final EAGConfig config;

  const ThruConfigScreen({super.key, required this.config});

  @override
  State<ThruConfigScreen> createState() => _ThruConfigScreenState();
}

class _ThruConfigScreenState extends State<ThruConfigScreen> {
  // Gather the theme data //

  late final EFUILang l10n = EFUILang.of(context)!;

  // Define the build data //

  bool itFailed = false;

  late final TargetPlatform platform = getBasePlatform(context);
  late final bool isDesktop = platform == TargetPlatform.linux ||
      platform == TargetPlatform.macOS ||
      platform == TargetPlatform.windows;

  // Define custom functions //

  void archive() async {
    final String savedConfig = await FileSaver.instance.saveFile(
      name: '${widget.config.appName}-eag-config.json',
      bytes: utf8.encode(jsonEncode(widget.config.toJson())),
      mimeType: MimeType.json,
    );

    // Check for a String that ends in .json
    if (savedConfig.endsWith('.json')) {
      debugPrint('DO SOMETHING!');
    } else {
      setState(() => itFailed = true);
      debugPrint('DO SOMETHING ELSE!');
    }
  }

  void run() async {
    await Process.run('echo', <String>['create']);
  }

  // Init //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isDesktop ? run() : archive();
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return const OpenUIScaffold(
      title: 'Generator',
      body: Center(
        child: EmpathetechLoadingAnimation(
          height: 300,
          semantics: 'TODO',
        ),
      ),
    );
  }
}
