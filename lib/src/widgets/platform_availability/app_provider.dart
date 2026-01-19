/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EzConfigurableApp extends StatelessWidget {
  /// App to wrap
  final Widget app;

  /// Wraps [app] in a [ChangeNotifierProvider] for live configuration
  const EzConfigurableApp({super.key, required this.app});

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<EzConfigProvider>(
        create: (_) => EzConfigProvider(
          isLTR: ltrCheck(context),
          localeFallback: EzConfig.localeFallback,
          l10nFallback: EzConfig.l10nFallback,
          isDark: isDarkTheme(context),
        ),
        child: _ThemeDrawer(app),
      );
}

class _ThemeDrawer extends StatefulWidget {
  final Widget app;

  const _ThemeDrawer(this.app);

  @override
  State<_ThemeDrawer> createState() => _ThemeDrawerState();
}

class _ThemeDrawerState extends State<_ThemeDrawer>
    with WidgetsBindingObserver {
  // Init //

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    config.toggleTheme();
  }

  // Return the build //

  late final EzConfigProvider config = Provider.of<EzConfigProvider>(context);

  @override
  Widget build(BuildContext context) {
    EzConfig.initProvider(config);
    return widget.app;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
