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
  /// Optional starting target
  final bool? advanced;

  /// [EzConfig.redrawUI]/[EzConfig.rebuildUI] passthrough
  final void Function() onUpdate;

  /// Spacer above the [EzResetButton] (shared by both tabs)
  final Widget resetSpacer;

  /// [EzResetButton.androidPackage] passthrough
  final String? androidPackage;

  /// [EzResetButton.appName] passthrough
  final String appName;

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
    this.advanced,
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
          advanced: advanced,
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

class _TextSettings extends StatefulWidget {
  // Shared
  final bool? advanced;
  final void Function() onUpdate;

  final Widget resetSpacer;
  final String? androidPackage;
  final String appName;
  final Set<String>? extraDark;
  final Set<String>? extraLight;
  final Set<String>? resetSkip;
  final Set<String>? saveSkip;

  // Quick
  final List<Widget>? moreQuickHeaderSettings;
  final Widget textBlockHeader;
  final Widget textBlockFooter;
  final bool showOpacity;
  final List<Widget>? moreQuickFooterSettings;

  // Advanced
  final bool showSpacing;

  const _TextSettings({
    required this.advanced,
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
  State<_TextSettings> createState() => _TextSettingsState();
}

class _TextSettingsState extends State<_TextSettings> {
  // Define the build data //

  late final EzDisplayStyleProvider displayProvider =
      Provider.of<EzDisplayStyleProvider>(context);
  late final EzHeadlineStyleProvider headlineProvider =
      Provider.of<EzHeadlineStyleProvider>(context);
  late final EzTitleStyleProvider titleProvider =
      Provider.of<EzTitleStyleProvider>(context);
  late final EzBodyStyleProvider bodyProvider =
      Provider.of<EzBodyStyleProvider>(context);
  late final EzLabelStyleProvider labelProvider =
      Provider.of<EzLabelStyleProvider>(context);

  late EzSubSetting currentTab = (widget.advanced == null)
      ? (EzConfig.get(advancedTextKey) == true
          ? EzSubSetting.advText
          : EzSubSetting.qckText)
      : (widget.advanced! ? EzSubSetting.advText : EzSubSetting.qckText);

  void redraw() {
    widget.onUpdate();
    setState(() {});
  }

  // Init //

  @override
  void initState() {
    super.initState();
    ezWindowNamer(EzConfig.l10n.tsPageTitle);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) => (currentTab == EzSubSetting.qckText)
      ? QuickTextSettings(
          displayProvider: displayProvider,
          headlineProvider: headlineProvider,
          titleProvider: titleProvider,
          bodyProvider: bodyProvider,
          labelProvider: labelProvider,
          onUpdate: redraw,
          moreQuickHeaderSettings: widget.moreQuickHeaderSettings,
          textBlockHeader: widget.textBlockHeader,
          textBlockFooter: widget.textBlockFooter,
          showOpacity: widget.showOpacity,
          moreQuickFooterSettings: widget.moreQuickFooterSettings,
          resetSpacer: widget.resetSpacer,
          extraDark: widget.extraDark,
          extraLight: widget.extraLight,
          appName: widget.appName,
          androidPackage: widget.androidPackage,
          resetSkip: widget.resetSkip,
          saveSkip: widget.saveSkip,
        )
      : AdvancedTextSettings(
          displayProvider: displayProvider,
          headlineProvider: headlineProvider,
          titleProvider: titleProvider,
          bodyProvider: bodyProvider,
          labelProvider: labelProvider,
          onUpdate: redraw,
          showSpacing: widget.showSpacing,
          resetSpacer: widget.resetSpacer,
          extraDark: widget.extraDark,
          extraLight: widget.extraLight,
          appName: widget.appName,
          androidPackage: widget.androidPackage,
          resetSkip: widget.resetSkip,
          saveSkip: widget.saveSkip,
        );
}
