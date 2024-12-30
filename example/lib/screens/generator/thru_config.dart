/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../structs/export.dart';
import '../../widgets/export.dart';
import 'package:efui_bios/efui_bios.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_saver/file_saver.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ThruConfigScreen extends StatefulWidget {
  final EAGConfig config;

  const ThruConfigScreen({super.key, required this.config});

  @override
  State<ThruConfigScreen> createState() => _ThruConfigScreenState();
}

class _ThruConfigScreenState extends State<ThruConfigScreen> {
  // Gather the theme data //

  static const EzSpacer spacer = EzSpacer();

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

  String errorMessage = 'The config could not be saved.\nPlease try again.';

  // Define custom Widgets //

  late final Widget loadingPage = Center(
    child: SizedBox(
      height: heightOf(context) / 2,
      child: const EmpathetechLoadingAnimation(
        height: double.infinity,
        semantics: 'TODO',
      ),
    ),
  );

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

  // Define custom functions //

  void archive() async {
    late final String savedConfig;
    try {
      savedConfig = await FileSaver.instance.saveFile(
        name: '${widget.config.appName}-eag-config.json',
        bytes: utf8.encode(jsonEncode(widget.config.toJson())),
        mimeType: MimeType.json,
      );
    } catch (e) {
      errorMessage = 'Something went wrong...\n\n${e.toString()}';
      centerPiece = failurePage;
      setState(() {});
    }

    // Check for a String that ends in .json
    savedConfig.endsWith('.json')
        ? setState(() => centerPiece = successPage)
        : setState(() => centerPiece = failurePage);
  }

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

  void genCode() async {
    debugPrint('one of us... One Of Us... ONE OF US!');
  }

  Future<dynamic> confirm() async {
    return await showPlatformDialog(
      context: context,
      builder: (BuildContext confirmContext) {
        return EzAlertDialog(
          title: const Text('Would you like to...'),
          contents: <Widget>[
            // Generate code
            EzElevatedIconButton(
              label: 'Generate ${widget.config.appName}',
              icon: Icon(PlatformIcons(context).folderOpen),
              onPressed: () {
                Navigator.of(confirmContext).pop(true);
                genCode();
              },
            ),
            spacer,

            // Save config
            EzElevatedIconButton(
              label: 'Save config',
              icon: const Icon(Icons.save),
              onPressed: () {
                Navigator.of(confirmContext).pop(false);
                archive();
              },
            ),
          ],
          needsClose: false,
        );
      },
    );
  }

  // Init //

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => isDesktop ? confirm() : archive());
  }

  // Return the build //

  @override
  Widget build(_) => OpenUIScaffold(
        title: 'Generator',
        body: EzScreen(child: centerPiece),
      );
}
