/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../structs/export.dart';
import '../widgets/export.dart';
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

  late String successMessage =
      '''\nYour configuration has been saved to ${archivePath()}

Use it on Open UI for desktop to generate the code for ${widget.config.appName}''';

  String errorMessage = 'Something went wrong.\nPlease try again.';

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
      setState(() {
        errorMessage = 'Something went wrong...\n\n${e.toString()}';
        centerPiece = failurePage;
      });
    }

    savedConfig.endsWith('.json')
        ? setState(() => centerPiece = successPage)
        : setState(() => centerPiece = failurePage);
  }

  /// Human readable path for saved config
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

  /// Run Flutter, Run!
  void generateStuff() async {
    late final ProcessResult? runResult;
    try {
      runResult = await Process.run(
        'flutter',
        <String>[
          'create',
          '--org',
          widget.config.domainName,
          widget.config.appName,
        ],
        runInShell: true,
        workingDirectory: widget.config.genPath,
      );
    } catch (e) {
      setState(() {
        errorMessage = 'Something went wrong...\n\n${e.toString()}';
        centerPiece = failurePage;
      });
    }

    runResult != null
        ? deleteStuff()
        : setState(() => centerPiece = failurePage);
  }

  /// Runs immediately after a successful [generateStuff]
  Future<void> deleteStuff() async {
    replaceStuff();
  }

  /// Runs immediately after a successful [deleteStuff]
  Future<void> replaceStuff() async {
    addStuff();
  }

  /// Runs immediately after a successful [replaceStuff]
  /// Last method before completion
  Future<void> addStuff() async {
    setState(() {
      successMessage =
          '${widget.config.appName} is ready in\n${widget.config.genPath}';
      centerPiece = successPage;
    });
  }

  // Define custom Widgets //

  /// Loading animation
  late final Widget loadingPage = Center(
    child: SizedBox(
      height: heightOf(context) / 2,
      child: const EmpathetechLoadingAnimation(
        height: double.infinity,
        semantics: 'TODO',
      ),
    ),
  );

  /// Tells user what to do next
  late final Widget successPage = EzScrollView(
    children: <Widget>[
      Text(
        'Success!',
        style: textTheme.headlineLarge,
        textAlign: TextAlign.center,
      ),
      Text(
        successMessage,
        style: notificationStyle,
        textAlign: TextAlign.center,
      ),
    ],
  );

  /// Displays the error
  late final Widget failurePage = EzScrollView(
    children: <Widget>[
      Text(
        'Failure',
        style: textTheme.headlineLarge,
        textAlign: TextAlign.center,
      ),
      Text(
        errorMessage,
        style: notificationStyle,
        textAlign: TextAlign.center,
      ),
    ],
  );

  // Init //

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => isDesktop ? generateStuff() : archive());
  }

  // Return the build //

  @override
  Widget build(_) => OpenUIScaffold(
        title: 'Generator',
        body: EzScreen(child: centerPiece),
      );
}
