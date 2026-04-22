/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'advanced_settings.dart';
import 'quick_settings.dart';
import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EzTextSettings extends StatelessWidget {
  /// Current sub-page
  final EzSubSetting target;

  /// [EzConfig.redrawUI]/[EzConfig.rebuildUI] passthrough
  final void Function() onUpdate;

  /// Spacer above the [EzResetButton] (shared by both tabs)
  final Widget resetSpacer;

  /// [EzResetButton.appName] passthrough
  final String appName;

  /// [EzResetButton.androidPackage] passthrough
  final String? androidPackage;

  /// Optional additional reset keys for the dark theme
  /// [allTextKeys] and [darkOnSurfaceKey] are included by default
  final Set<String>? resetExtraDark;

  /// Optional additional reset keys for the light theme
  /// [allTextKeys] and [lightOnSurfaceKey] are included by default
  final Set<String>? resetExtraLight;

  /// [EzResetButton.resetSkip] passthrough
  /// Shared for both themes
  final Set<String>? resetSkip;

  /// [EzResetButton.saveSkip] passthrough
  /// Shared for both themes
  final Set<String>? saveSkip;

  /// Optional additional quick settings
  /// Will appear just above the text block
  /// BYO leading spacer, trailing will be [textBlockHeader]
  final List<Widget>? moreQuickHeaderSettings;

  /// Spacer above the text block/sample
  final Widget textBlockHeader;

  /// Spacer below the text block/sample
  final Widget textBlockFooter;

  /// Whether the text background opacity (quick) setting should be shown
  final bool showOpacity;

  /// Optional additional quick settings
  /// Will appear just below the default quick settings
  /// BYO leading spacer, trailing will be [resetSpacer]
  final List<Widget>? moreQuickFooterSettings;

  /// Whether the [TextStyle] EzConfig.spacing controls should be shown in the advanced tab
  /// [TextStyle.letterSpacing], [TextStyle.wordSpacing], and [TextStyle.height]
  final bool showSpacing;

  /// Empathetech text settings
  /// Recommended to use as a [Scaffold.body]
  const EzTextSettings({
    // Shared
    super.key,
    required this.target,
    required this.onUpdate,
    this.resetSpacer = const EzSeparator(),
    this.androidPackage,
    required this.appName,
    this.resetExtraDark,
    this.resetExtraLight,
    this.resetSkip,
    this.saveSkip,

    // Quick
    this.moreQuickHeaderSettings,
    this.textBlockHeader = const EzSpacer(),
    this.textBlockFooter = const EzDivider(),
    this.showOpacity = true,
    this.moreQuickFooterSettings,

    // Advanced
    this.showSpacing = true,
  });

  // Set the page title //

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: <ChangeNotifierProvider<dynamic>>[
          ChangeNotifierProvider<EzDisplayStyleProvider>(
            create: (_) => EzDisplayStyleProvider(),
          ),
          ChangeNotifierProvider<EzHeadlineStyleProvider>(
            create: (_) => EzHeadlineStyleProvider(),
          ),
          ChangeNotifierProvider<EzTitleStyleProvider>(
            create: (_) => EzTitleStyleProvider(),
          ),
          ChangeNotifierProvider<EzBodyStyleProvider>(
            create: (_) => EzBodyStyleProvider(),
          ),
          ChangeNotifierProvider<EzLabelStyleProvider>(
            create: (_) => EzLabelStyleProvider(),
          ),
        ],
        child: _TextSettings(
          // Shared
          target: target,
          onUpdate: onUpdate,

          resetSpacer: resetSpacer,
          androidPackage: androidPackage,
          appName: appName,
          extraDark: resetExtraDark,
          extraLight: resetExtraLight,
          resetSkip: resetSkip,
          saveSkip: saveSkip,

          // Quick
          moreQuickHeaderSettings: moreQuickHeaderSettings,
          textBlockHeader: textBlockHeader,
          textBlockFooter: textBlockFooter,
          showOpacity: showOpacity,
          moreQuickFooterSettings: moreQuickFooterSettings,

          // Advanced
          showSpacing: showSpacing,
        ),
      );
}

class _TextSettings extends StatelessWidget {
  final EzSubSetting target;
  final void Function() onUpdate;
  final Widget resetSpacer;
  final String appName;
  final String? androidPackage;
  final Set<String>? extraDark;
  final Set<String>? extraLight;
  final Set<String>? resetSkip;
  final Set<String>? saveSkip;
  final List<Widget>? moreQuickHeaderSettings;
  final Widget textBlockHeader;
  final Widget textBlockFooter;
  final bool showOpacity;
  final List<Widget>? moreQuickFooterSettings;
  final bool showSpacing;

  const _TextSettings({
    required this.target,
    required this.onUpdate,
    required this.resetSpacer,
    required this.androidPackage,
    required this.appName,
    required this.extraDark,
    required this.extraLight,
    required this.resetSkip,
    required this.saveSkip,
    required this.moreQuickHeaderSettings,
    required this.textBlockHeader,
    required this.textBlockFooter,
    required this.showOpacity,
    required this.moreQuickFooterSettings,
    required this.showSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return EzFauxCarousel(
      position: target.isFirst ? 0 : 1,
      delta: target.isFirst ? -1 : 1,
      child: (target == EzSubSetting.qckText)
          ? QuickTextSettings(
              displayProvider: Provider.of<EzDisplayStyleProvider>(context),
              headlineProvider: Provider.of<EzHeadlineStyleProvider>(context),
              titleProvider: Provider.of<EzTitleStyleProvider>(context),
              bodyProvider: Provider.of<EzBodyStyleProvider>(context),
              labelProvider: Provider.of<EzLabelStyleProvider>(context),
              onUpdate: onUpdate,
              moreQuickHeaderSettings: moreQuickHeaderSettings,
              textBlockHeader: textBlockHeader,
              textBlockFooter: textBlockFooter,
              showOpacity: showOpacity,
              moreQuickFooterSettings: moreQuickFooterSettings,
              resetSpacer: resetSpacer,
              extraDark: extraDark,
              extraLight: extraLight,
              appName: appName,
              androidPackage: androidPackage,
              resetSkip: resetSkip,
              saveSkip: saveSkip,
            )
          : AdvancedTextSettings(
              displayProvider: Provider.of<EzDisplayStyleProvider>(context),
              headlineProvider: Provider.of<EzHeadlineStyleProvider>(context),
              titleProvider: Provider.of<EzTitleStyleProvider>(context),
              bodyProvider: Provider.of<EzBodyStyleProvider>(context),
              labelProvider: Provider.of<EzLabelStyleProvider>(context),
              onUpdate: onUpdate,
              showSpacing: showSpacing,
              resetSpacer: resetSpacer,
              extraDark: extraDark,
              extraLight: extraLight,
              appName: appName,
              androidPackage: androidPackage,
              resetSkip: resetSkip,
              saveSkip: saveSkip,
            ),
    );
  }
}
