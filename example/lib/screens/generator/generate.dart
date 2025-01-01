/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../structs/export.dart';
import '../../widgets/export.dart';
import 'package:efui_bios/efui_bios.dart';

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
  late final TextStyle? notificationStyle =
      textTheme.bodyLarge?.copyWith(fontSize: textTheme.titleLarge?.fontSize);

  // Define the build data //

  late final bool isWindows =
      getBasePlatform(context) == TargetPlatform.windows;

  late final String workDir = widget.config.genPath!;
  late final String projDir = isWindows
      ? '$workDir\\${widget.config.appName}'
      : '$workDir/${widget.config.appName}';

  late Widget centerPiece = loadingPage;

  late String successMessage =
      '\n${widget.config.appName} is ready in\n${widget.config.genPath}';

  String errorMessage = '\nSomething went wrong.\nPlease try again.';

  // Define custom functions //

  void onFailure(String message) => setState(() {
        errorMessage = '\nSomething went wrong...\n\n$message';
        centerPiece = failurePage;
      });

  /// Run Flutter, Run!
  Future<void> genStuff() async {
    ezCLI(
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
    ezCLI(
      exe: 'rm',
      args: <String>[
        '-rf',
        'lib',
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
    await genREADME(widget.config, projDir);
    await genAppVersion(widget.config, projDir);
    await genLicense(widget.config, projDir);
    await genPubspec(widget.config, projDir);
    await genLib(widget.config, projDir);

    if (widget.config.l10nConfig != null) await genL10n(widget.config, projDir);

    if (widget.config.analysisOptions != null) {
      await genAnalysis(widget.config, projDir);
    }

    if (widget.config.vsCodeConfig != null) {
      await genVSCode(widget.config, projDir);
    }

    await genIntegrationTests(widget.config, projDir);
    runStuff();
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
    } catch (e) {
      onFailure(e.toString());
    }

    runResult.exitCode == 0
        ? setState(() => centerPiece = successPage)
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
    WidgetsBinding.instance.addPostFrameCallback((_) => genStuff());
  }

  // Return the build //

  @override
  Widget build(_) =>
      OpenUIScaffold(title: 'Generator', body: EzScreen(child: centerPiece));
}
