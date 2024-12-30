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

  late final TextTheme textTheme = Theme.of(context).textTheme;
  late final TextStyle? notificationStyle =
      textTheme.bodyLarge?.copyWith(fontSize: textTheme.titleLarge?.fontSize);

  // Define the build data //

  late final TargetPlatform platform = getBasePlatform(context);
  late final bool isDesktop = platform == TargetPlatform.linux ||
      platform == TargetPlatform.macOS ||
      platform == TargetPlatform.windows;

  late Widget centerPiece = loadingPage;

  // Define custom Widgets //

  late final Widget loadingPage = SizedBox(
    height: heightOf(context) / 2,
    child: const EmpathetechLoadingAnimation(
      height: double.infinity,
      semantics: 'TODO',
    ),
  );

  late final Widget successPage = Text(
    '''Success!

Your configuration has been saved to ${archivePath()}

Use it on Open UI for desktop to generate the code for ${widget.config.appName}''',
    style: notificationStyle,
    textAlign: TextAlign.center,
  );

  // Define custom functions //

  void archive() async {
    final String savedConfig = await FileSaver.instance.saveFile(
      name: '${widget.config.appName}-eag-config.json',
      bytes: utf8.encode(jsonEncode(widget.config.toJson())),
      mimeType: MimeType.json,
    );

    // Check for a String that ends in .json
    if (savedConfig.endsWith('.json')) {
      setState(() => centerPiece = successPage);
    } else {
      debugPrint('WHOOPSIE!');
    }
  }

  String archivePath() {
    switch (platform) {
      case TargetPlatform.android:
        return 'TODO';
      case TargetPlatform.iOS:
        return 'Files > Browse > Open UI';
      case TargetPlatform.linux:
        return 'TODO';
      case TargetPlatform.macOS:
        return 'TODO';
      case TargetPlatform.windows:
        return 'TODO';
      case TargetPlatform.fuchsia:
        return 'TODO';
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
    return OpenUIScaffold(
      title: 'Generator',
      body: Center(child: centerPiece),
    );
  }
}
