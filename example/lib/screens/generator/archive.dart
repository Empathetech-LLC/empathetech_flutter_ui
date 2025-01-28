/* open_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../structs/export.dart';
import '../../utils/export.dart';
import '../../widgets/export.dart';
import 'package:efui_bios/efui_bios.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_saver/file_saver.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class ArchiveScreen extends StatefulWidget {
  final EAGConfig config;

  const ArchiveScreen({super.key, required this.config});

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  // Gather the theme data //

  late final EFUILang el10n = EFUILang.of(context)!;
  late final Lang l10n = Lang.of(context)!;

  late final TextTheme textTheme = Theme.of(context).textTheme;

  // Define the build data //

  GeneratorState genState = GeneratorState.running;
  String failureMessage = '';

  late final TargetPlatform platform = getBasePlatform(context);

  late final bool isDesktop = platform == TargetPlatform.linux ||
      platform == TargetPlatform.macOS ||
      platform == TargetPlatform.windows;

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
        failureMessage = e.toString();
        genState = GeneratorState.failed;
      });
    }

    savedConfig.endsWith('.json')
        ? setState(() => genState = GeneratorState.successful)
        : setState(() {
            failureMessage = '${l10n.asBadFile} .json...\n\n$savedConfig';
            genState = GeneratorState.failed;
          });
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

  Widget header() {
    switch (genState) {
      case GeneratorState.running:
        return SizedBox(
          height: heightOf(context) / 3,
          width: double.infinity,
          child: EmpathetechLoadingAnimation(
            height: double.infinity,
            semantics: el10n.gLoadingAnim,
          ),
        );
      case GeneratorState.successful:
        return Center(
          child: SuccessHeader(
            textTheme: textTheme,
            richMessage: EzRichText(
              <InlineSpan>[
                EzPlainText(text: l10n.asSavedTo(archivePath())),
                if (!isDesktop) ...<InlineSpan>[
                  EzPlainText(text: l10n.asUseIt),
                  EzInlineLink(
                    appTitle,
                    style: ezSubTitleStyle(textTheme),
                    textAlign: TextAlign.center,
                    url: Uri.parse(openUIReleases),
                    hint: el10n.gOpenUIReleases,
                  ),
                  EzPlainText(text: l10n.asToGen(widget.config.appName)),
                ]
              ],
              style: ezSubTitleStyle(textTheme),
              textAlign: TextAlign.center,
            ),
          ),
        );
      case GeneratorState.failed:
        return Center(
          child: FailureHeader(
            textTheme: textTheme,
            message: failureMessage,
          ),
        );
    }
  }

  // Init //

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => archive());
  }

  // Return the build //

  @override
  Widget build(_) => OpenUIScaffold(
        title: l10n.asPageTitle,
        running: genState == GeneratorState.running,
        body: EzScreen(alignment: Alignment.center, child: header()),
      );
}
