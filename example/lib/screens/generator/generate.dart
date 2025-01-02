/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import './shared.dart';
import '../../structs/export.dart';
import '../../utils/export.dart';
import '../../widgets/export.dart';

import 'dart:io';
import 'package:flutter/material.dart';
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

  // Define the build data //

  late final bool isWindows =
      getBasePlatform(context) == TargetPlatform.windows;

  late final String workDir = widget.config.genPath!;
  late final String projDir = isWindows
      ? '$workDir\\${widget.config.appName}'
      : '$workDir/${widget.config.appName}';

  late Widget centerPiece = loadingPage(context);

  String errorMessage = '\nSomething went wrong.\nPlease try again.';

  // Define custom functions //

  void onFailure(String message) {
    setState(() => centerPiece = failurePage(
        context, '\nSomething went wrong...\n\n$message', textTheme));
    return;
  }

  /// Run Flutter, Run!
  Future<void> genStuff() async {
    await ezCLI(
      exe: 'flutter',
      args: <String>[
        'create',
        '--org',
        widget.config.domainName,
        widget.config.appName,
      ],
      dir: workDir,
      onSuccess: delStuff,
      onFailure: onFailure,
    );
  }

  /// Runs immediately after a successful [genStuff]
  Future<void> delStuff() async {
    await ezCLI(
      exe: 'rm',
      args: <String>[
        '-rf',
        'lib',
        'test',
        'analysis_options.yaml',
        'pubspec.lock',
        'pubspec.yaml',
        'README.md',
      ],
      dir: projDir,
      onSuccess: addStuff,
      onFailure: onFailure,
    );
  }

  /// Runs immediately after a successful [delStuff]
  Future<void> addStuff() async {
    await genREADME(config: widget.config, dir: projDir, onFailure: onFailure);
    await genVersionTracking(
        config: widget.config, dir: projDir, onFailure: onFailure);
    await genLicense(config: widget.config, dir: projDir, onFailure: onFailure);
    await genPubspec(config: widget.config, dir: projDir, onFailure: onFailure);
    await genLib(config: widget.config, dir: projDir, onFailure: onFailure);

    if (widget.config.l10nConfig != null) {
      await genL10n(config: widget.config, dir: projDir, onFailure: onFailure);
    }

    if (widget.config.analysisOptions != null) {
      await genAnalysis(
          config: widget.config, dir: projDir, onFailure: onFailure);
    }

    if (widget.config.vsCodeConfig != null) {
      await genVSCode(
          config: widget.config, dir: projDir, onFailure: onFailure);
    }

    await genIntegrationTests(
        config: widget.config, dir: projDir, onFailure: onFailure);

    await runStuff();
  }

  /// Runs immediately after a successful [addStuff]
  /// Last method before completion
  Future<void> runStuff() async {
    late ProcessResult runResult;
    try {
      debugPrint("\n'flutter clean'...");
      runResult = await Process.run(
        'flutter',
        <String>['clean'],
        runInShell: true,
        workingDirectory: projDir,
      );
      debugPrint('stdout: ${runResult.stdout}');
      debugPrint('stderr: ${runResult.stderr}');

      debugPrint("\n'flutter upgrade'...");
      runResult = await Process.run(
        'flutter',
        <String>[
          'pub',
          'upgrade',
          '--major-versions',
        ],
        runInShell: true,
        workingDirectory: projDir,
      );
      debugPrint('stdout: ${runResult.stdout}');
      debugPrint('stderr: ${runResult.stderr}');

      debugPrint("\n'flutter tighten'...");
      runResult = await Process.run(
        'flutter',
        <String>[
          'pub',
          'upgrade',
          '--tighten',
        ],
        runInShell: true,
        workingDirectory: projDir,
      );
      debugPrint('stdout: ${runResult.stdout}');
      debugPrint('stderr: ${runResult.stderr}');

      if (widget.config.l10nConfig != null) {
        debugPrint("\n'flutter gen-l10n'...");
        runResult = await Process.run(
          'flutter',
          <String>['gen-l10n'],
          runInShell: true,
          workingDirectory: projDir,
        );
        debugPrint('stdout: ${runResult.stdout}');
        debugPrint('stderr: ${runResult.stderr}');
      }
    } catch (e) {
      onFailure(e.toString());
    }

    runResult.exitCode == 0
        ? setState(() => centerPiece = successPage(
              context,
              '\n${widget.config.appName} is ready in\n${widget.config.genPath}',
              textTheme,
            ))
        : onFailure(runResult.stderr.toString());
  }

  // Init //

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => genStuff());
  }

  // Return the build //

  @override
  Widget build(_) =>
      OpenUIScaffold(title: 'Generator', body: EzScreen(child: centerPiece));
}
