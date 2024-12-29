/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../screens/export.dart';
import '../../structs/export.dart';
import '../../widgets/export.dart';
import 'package:efui_bios/efui_bios.dart';

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:file_saver/file_saver.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class ProgressScreen extends StatefulWidget {
  final EAGConfig config;

  const ProgressScreen({super.key, required this.config});

  @override
  State<ProgressScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ProgressScreen> {
  // Gather the theme data //

  late final EFUILang l10n = EFUILang.of(context)!;

  // Define the build data //

  bool itFailed = false;

  late final TargetPlatform platform = getBasePlatform(context);
  late final bool isDesktop = !(kIsWeb ||
      platform == TargetPlatform.iOS ||
      platform == TargetPlatform.android);

  // Define custom functions //

  void archive() async {
    final String savedConfig = await FileSaver.instance.saveFile(
      name: '${widget.config.appName}-eag-config.json',
      bytes: utf8.encode(jsonEncode(widget.config.toJson())),
      mimeType: MimeType.json,
    );

    // Check for a String that ends in .json
    if (savedConfig.endsWith('.json')) {
      if (context.mounted) context.goNamed(failurePath);
    } else {
      if (context.mounted) context.goNamed(successPath);
    }
  }

  void run() async {
    await Process.run('flutter', <String>['create']);
  }

  // Init //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    setPageTitle('Generating', Theme.of(context).colorScheme.primary);

    isDesktop ? run() : archive();
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return const OpenUIScaffold(
      title: 'Builder',
      body: Center(
        child: EmpathetechLoadingAnimation(
          height: double.infinity,
          semantics: 'TODO',
        ),
      ),
    );
  }
}
