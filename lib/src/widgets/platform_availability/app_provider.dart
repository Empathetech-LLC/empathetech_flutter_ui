/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EzAppProvider extends StatelessWidget {
  /// The core [app] with a [ScaffoldMessenger] layer
  final Widget app;

  /// Optionally provide a [ScaffoldMessengerState] typed [GlobalKey]
  /// To track [SnackBar]s, [MaterialBanner]s, etc.
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  /// Wraps [app] in a [ChangeNotifierProvider] for live configuration
  const EzAppProvider({
    super.key,
    required this.app,
    this.scaffoldMessengerKey,
  });

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<EzConfigProvider>(
        create: (_) => EzConfigProvider(
          isLTR: ltrCheck(context),
          useCupertino: isApple(),
          localeFallback: EzConfig.localeFallback,
          l10nFallback: EzConfig.l10nFallback,
          isDark: isDarkTheme(context),
        ),
        child: _ProviderSquared(
          app: app,
          scaffoldMessengerKey: scaffoldMessengerKey,
        ),
      );
}

class _ProviderSquared extends StatefulWidget {
  final Widget app;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  const _ProviderSquared({
    required this.app,
    required this.scaffoldMessengerKey,
  });

  @override
  State<_ProviderSquared> createState() => _ProviderSquaredState();
}

class _ProviderSquaredState extends State<_ProviderSquared>
    with WidgetsBindingObserver {
  late final EzConfigProvider config = Provider.of<EzConfigProvider>(context);

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    config.toggleTheme();
  }

  @override
  Widget build(BuildContext context) {
    EzConfig.initProvider(config);

    return ScaffoldMessenger(
      key: widget.scaffoldMessengerKey,
      child: widget.app,
    );
  }
}
