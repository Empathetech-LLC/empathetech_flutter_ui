/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../structs/export.dart';
import '../../widgets/export.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
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

  late final TargetPlatform platform = getBasePlatform(context);

  // Define custom functions //

  void archive() async {}

  void run() async {
    await Process.run('flutter', <String>['create']);
  }

  // Init //

  @override
  void initState() {
    super.initState();
    (kIsWeb ||
            platform == TargetPlatform.iOS ||
            platform == TargetPlatform.android)
        ? archive()
        : run();
  }

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPageTitle('Generating', Theme.of(context).colorScheme.primary);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return OpenUIScaffold(
      title: 'Builder',
      body: EzScreen(child: EzScrollView()),
    );
  }
}
