/* open_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../models/export.dart';
import '../../utils/export.dart';
import '../../widgets/export.dart';
import 'package:efui_bios/efui_bios.dart';

import 'dart:io';
import 'package:xml/xml.dart';
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

  static const EzSpacer spacer = EzSpacer();
  static const Widget divider = EzDivider();

  late final EFUILang el10n = EFUILang.of(context)!;
  late final Lang l10n = Lang.of(context)!;
  late final TextTheme textTheme = Theme.of(context).textTheme;

  late final TextStyle? subTitle = ezSubTitleStyle(textTheme);

  // Define the build data //

  GeneratorState genState = GeneratorState.running;
  String? failureMessage;
  EzRichText? richFailureMessage;

  /// Quantum supremacy achieved
  bool? showDelete = true;

  late final TargetPlatform platform = getBasePlatform(context);
  late final bool isWindows = platform == TargetPlatform.windows;

  String device() {
    if (platform == TargetPlatform.linux) {
      return 'linux';
    } else if (platform == TargetPlatform.macOS) {
      return 'macos';
    } else if (isWindows) {
      return 'windows';
    } else {
      return 'chrome';
    }
  }

  late final String workDir = widget.config.workPath!;

  late final String projDir = isWindows
      ? '$workDir\\${widget.config.appName}'
      : '$workDir/${widget.config.appName}';

  late final String flutterPath = widget.config.flutterPath == null
      ? ''
      : isWindows
          ? '${widget.config.flutterPath}\\'
          : '${widget.config.flutterPath}/';

  ValueNotifier<String> readout = ValueNotifier<String>('');
  bool showReadout = false;

  // Define custom functions //

  void onFailure(String message) {
    setState(() {
      failureMessage = message;
      genState = GeneratorState.failed;
    });

    // Exit any further processing
    return;
  }

  /// The only way to begin
  /// Is by beginning
  Future<void> genStuff() async {
    await ezCmd(
      '${flutterPath}flutter create --org ${widget.config.domainName} ${widget.config.appName}',
      dir: workDir,
      onSuccess: delStuff,
      onFailure: (String message) {
        if (message.contains('not permitted') &&
            platform == TargetPlatform.macOS) {
          setState(() {
            showDelete = false;
            richFailureMessage = EzRichText(
              <InlineSpan>[
                EzPlainText(text: l10n.gsNeedPermission),
                EzPlainText(text: '\n\n${l10n.gsSeeNBelieve}'),
                EzInlineLink(
                  l10n.csHere,
                  style: subTitle,
                  textAlign: TextAlign.center,
                  url: Uri.parse(
                      'https://github.com/Empathetech-LLC/empathetech_flutter_ui/tree/main/example/lib/screens/generator/generate.dart'),
                  hint: l10n.gsSeeNBelieveHint,
                ),
              ],
              style: subTitle,
              textAlign: TextAlign.center,
            );
            genState = GeneratorState.failed;
          });
        } else if (message.contains('command not found')) {
          setState(() {
            showDelete = null;
            failureMessage = l10n.gsNotInstalled;
            genState = GeneratorState.failed;
          });
        } else {
          onFailure(message);
        }
      },
      readout: readout,
    );
  }

  /// Runs immediately after a successful [genStuff]
  Future<void> delStuff() async {
    const String files =
        'analysis_options.yaml pubspec.lock pubspec.yaml README.md';
    const String dirs = 'lib test';

    // Files
    await ezCmd(
      isWindows ? 'del /f /q $files' : 'rm -f $files',
      dir: projDir,
      onSuccess: doNothing,
      onFailure: onFailure,
      readout: readout,
    );

    // Folders
    await ezCmd(
      isWindows ? 'rmdir /s /q $dirs' : 'rm -rf $dirs',
      dir: projDir,
      onSuccess: addStuff,
      onFailure: onFailure,
      readout: readout,
    );
  }

  /// Runs immediately after a successful [delStuff]
  Future<void> addStuff() async {
    await genREADME(
      config: widget.config,
      dir: projDir,
      onFailure: onFailure,
      readout: readout,
    );

    await genVersionTracking(
      config: widget.config,
      dir: projDir,
      onFailure: onFailure,
      readout: readout,
    );

    await genLicense(
      config: widget.config,
      dir: projDir,
      onFailure: onFailure,
      readout: readout,
    );

    await genPubspec(
      config: widget.config,
      dir: projDir,
      onFailure: onFailure,
      readout: readout,
    );

    await genLib(
      config: widget.config,
      platform: platform,
      dir: projDir,
      onFailure: onFailure,
      readout: readout,
    );

    if (widget.config.l10nConfig != null) {
      await genL10n(
        config: widget.config,
        platform: platform,
        dir: projDir,
        onFailure: onFailure,
        readout: readout,
      );
    }

    if (widget.config.analysisOptions != null) {
      await genAnalysis(
        config: widget.config,
        dir: projDir,
        onFailure: onFailure,
        readout: readout,
      );
    }

    if (widget.config.vsCodeConfig != null) {
      await genVSCode(
        config: widget.config,
        dir: projDir,
        onFailure: onFailure,
        readout: readout,
      );
    }

    await genIntegrationTests(
      config: widget.config,
      platform: platform,
      dir: projDir,
      onFailure: onFailure,
      readout: readout,
    );

    await runStuff();
  }

  /// Runs immediately after a successful [addStuff]
  /// Last method before completion
  Future<void> runStuff() async {
    late ProcessResult? runResult;
    try {
      // Update entitlements //

      final File macOSDebugEntitlements =
          File('$projDir/macos/Runner/DebugProfile.entitlements');
      final File macOSReleaseEntitlements =
          File('$projDir/macos/Runner/Release.entitlements');

      final XmlDocument debugDoc =
          XmlDocument.parse(await macOSDebugEntitlements.readAsString());
      final XmlDocument releaseDoc =
          XmlDocument.parse(await macOSReleaseEntitlements.readAsString());

      const String networkClientKey = 'com.apple.security.network.client';

      // Check if the entitlements already exist

      if (debugDoc.findAllElements(networkClientKey).isEmpty) {
        // Add the entitlement
        final XmlElement dictionary =
            debugDoc.rootElement.findElements('dict').first;

        dictionary.children.add(XmlElement(XmlName(networkClientKey)));
        dictionary.children.add(XmlElement(XmlName('true')));

        // Save the modified file
        await macOSDebugEntitlements
            .writeAsString(debugDoc.toXmlString(pretty: true));
      }

      if (releaseDoc.findAllElements(networkClientKey).isEmpty) {
        // Add the entitlement
        final XmlElement dictionary =
            releaseDoc.rootElement.findElements('dict').first;

        dictionary.children.add(XmlElement(XmlName(networkClientKey)));
        dictionary.children.add(XmlElement(XmlName('true')));

        // Save the modified file
        await macOSReleaseEntitlements
            .writeAsString(releaseDoc.toXmlString(pretty: true));
      }

      // Make sure packages are in order //

      ezLog('flutter clean...', buffer: readout);
      runResult = await Process.run(
        '${flutterPath}flutter',
        <String>['clean'],
        runInShell: true,
        workingDirectory: projDir,
      );
      ezLog(runResult.stdout, buffer: readout);
      ezLog(runResult.stderr, buffer: readout);

      ezLog('flutter upgrade...', buffer: readout);
      runResult = await Process.run(
        '${flutterPath}flutter',
        <String>[
          'pub',
          'upgrade',
          '--major-versions',
        ],
        runInShell: true,
        workingDirectory: projDir,
      );
      ezLog(runResult.stdout, buffer: readout);
      ezLog(runResult.stderr, buffer: readout);

      ezLog('flutter tighten...', buffer: readout);
      runResult = await Process.run(
        '${flutterPath}flutter',
        <String>[
          'pub',
          'upgrade',
          '--tighten',
        ],
        runInShell: true,
        workingDirectory: projDir,
      );
      ezLog(runResult.stdout, buffer: readout);
      ezLog(runResult.stderr, buffer: readout);

      // (optionally) Generate l10n files //

      if (widget.config.l10nConfig != null) {
        ezLog('flutter gen-l10n...', buffer: readout);
        runResult = await Process.run(
          '${flutterPath}flutter',
          <String>['gen-l10n'],
          runInShell: true,
          workingDirectory: projDir,
        );
        ezLog(runResult.stdout, buffer: readout);
        ezLog(runResult.stderr, buffer: readout);
      }
    } catch (e) {
      onFailure(e.toString());
    }

    (runResult != null && runResult.exitCode == 0)
        ? setState(() {
            showDelete = false;
            genState = GeneratorState.successful;
          })
        : onFailure(l10n.gsPartialSuccess);
  }

  Widget header() {
    switch (genState) {
      case GeneratorState.running:
        return SizedBox(
          height: (heightOf(context) / 3),
          width: double.infinity,
          child: EmpathetechLoadingAnimation(semantics: el10n.gLoadingAnim),
        );
      case GeneratorState.successful:
        return SizedBox(
          height: heightOf(context) / 3,
          width: double.infinity,
          child: Center(
            child: EzScrollView(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SuccessHeader(
                  textTheme: textTheme,
                  message:
                      '${widget.config.appName} ${l10n.gsIsReadyIn}\n${widget.config.workPath}',
                ),
                const EzSeparator(),
                RunOption(
                  projDir: projDir,
                  style: subTitle,
                  emulate: () async {
                    if (genState == GeneratorState.running) return;

                    setState(() => genState = GeneratorState.running);
                    ezSnackBar(
                      context: context,
                      message: l10n.gsFirstRun,
                    );

                    await ezCmd(
                      '${flutterPath}flutter run -d ${device()}',
                      dir: projDir,
                      onSuccess: () =>
                          setState(() => genState = GeneratorState.successful),
                      onFailure: onFailure,
                      readout: readout,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      case GeneratorState.failed:
        return SizedBox(
          height: heightOf(context) / 3,
          width: double.infinity,
          child: Center(
            child: EzScrollView(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FailureHeader(
                  textTheme: textTheme,
                  message: failureMessage,
                  richMessage: richFailureMessage,
                ),
                if (showDelete == true) ...<Widget>[
                  spacer,
                  DeleteOption(
                    appName: widget.config.appName,
                    platform: platform,
                    dir: workDir,
                    style: subTitle,
                  ),
                ],
                if (showDelete == null) ...<Widget>[
                  spacer,
                  LinkOption(subTitle),
                ],
              ],
            ),
          ),
        );
    }
  }

  // Init //

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => genStuff());
  }

  // Return the build //

  @override
  Widget build(_) {
    return OpenUIScaffold(
      title: l10n.gsPageTitle,
      running: genState == GeneratorState.running,
      body: EzScreen(
        child: EzScrollView(children: <Widget>[
          header(),
          divider,

          // Console output //

          // Toggle
          EzRow(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              EzText(
                l10n.gsConsole,
                style: textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              EzMargin(vertical: false),
              EzIconButton(
                onPressed: () => setState(() => showReadout = !showReadout),
                icon: EzIcon(
                  showReadout ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                ),
              ),
            ],
          ),
          EzMargin(),

          // Readout
          Visibility(
            visible: showReadout,
            child: Container(
              constraints: BoxConstraints(
                minWidth: widthOf(context) * 0.667,
                maxWidth: widthOf(context) * 0.667,
                maxHeight: heightOf(context) / 2,
              ),
              padding: EdgeInsets.all(EzConfig.get(marginKey)),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: ezRoundEdge,
              ),
              child: ValueListenableBuilder<String>(
                valueListenable: readout,
                builder: (_, String value, __) => EzScrollView(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  child: Text(
                    value,
                    style: textTheme.bodyLarge,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ),
          ),
          const EzSeparator(),
        ]),
      ),
    );
  }
}
