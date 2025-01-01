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

class GenerateScreen extends StatefulWidget {
  final EAGConfig config;

  const GenerateScreen({super.key, required this.config});

  @override
  State<GenerateScreen> createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
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

  void onFailure(String message) => setState(() {
        errorMessage = 'Something went wrong...\n$message';
        centerPiece = failurePage;
      });

  /// Run Flutter, Run!
  void genStuff() async {
    cli(
      exe: 'flutter',
      args: <String>[
        'create',
        '--org',
        widget.config.domainName,
        widget.config.appName,
      ],
      dir: widget.config.genPath!,
      onSuccess: delStuff,
      onFailure: onFailure,
    );
  }

  /// Runs immediately after a successful [genStuff]
  Future<void> delStuff() async {
    cli(
      exe: 'rm -rf',
      args: <String>[
        'lib',
        'analysis_options.yaml',
        'pubspec.lock',
        'pubspec.yaml',
        'README.md',
      ],
      dir: widget.config.genPath!,
      onSuccess: addStuff,
      onFailure: onFailure,
    );
  }

  /// Runs immediately after a successful [delStuff]
  Future<void> addStuff() async {
    await genREADME(widget.config);
    await genAppVersion(widget.config);
    await genLicense(widget.config);
    await genPubspec(widget.config);
    await genLib(widget.config);
    if (widget.config.l10nConfig != null) await genL10n(widget.config);
    if (widget.config.analysisOptions != null) await genAnalysis(widget.config);
    if (widget.config.vsCodeConfig != null) await genVSCode(widget.config);
    await genIntegrationTests(widget.config);
    runStuff();
  }

  /// Runs immediately after a successful [addStuff]
  /// Last method before completion
  Future<void> runStuff() async {
    late ProcessResult runResult;
    try {
      runResult = await Process.run(
        'flutter',
        <String>[
          'clean',
        ],
        runInShell: true,
        workingDirectory: widget.config.genPath,
      );
      runResult = await Process.run(
        'flutter',
        <String>[
          'pub upgrade --major-versions',
        ],
        runInShell: true,
        workingDirectory: widget.config.genPath,
      );
      runResult = await Process.run(
        'flutter',
        <String>[
          'pub upgrade --tighten',
        ],
        runInShell: true,
        workingDirectory: widget.config.genPath,
      );
    } catch (e) {
      onFailure(e.toString());
    }

    runResult.exitCode == 0
        ? setState(() {
            successMessage =
                '${widget.config.appName} is ready in\n${widget.config.genPath}';
            centerPiece = successPage;
          })
        : onFailure(runResult.stderr.toString());
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
        .addPostFrameCallback((_) => isDesktop ? genStuff() : archive());
  }

  // Return the build //

  @override
  Widget build(_) =>
      OpenUIScaffold(title: 'Generator', body: EzScreen(child: centerPiece));
}
