/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import './advanced_settings.dart';
import './quick_settings.dart';
import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzColorSettings extends StatelessWidget {
  /// Current sub-page
  final EzSubSetting target;

  /// [EzConfig.rebuildUI]/[EzConfig.redrawUI] passthrough
  final void Function() onUpdate;

  /// Spacer above the [EzResetButton], on both sub-screens
  final Widget resetSpacer;

  /// [EzResetButton.appName] passthrough
  final String appName;

  /// [EzResetButton.androidPackage] passthrough
  final String? androidPackage;

  /// Additional [EzConfig] keys for the local [EzResetButton]
  /// [darkColorKeys] are included by default
  final Set<String>? resetExtraDark;

  /// Additional [EzConfig] keys for the local [EzResetButton]
  /// [lightColorKeys] are included by default
  final Set<String>? resetExtraLight;

  /// [EzResetButton.resetSkip] passthrough
  /// Shared for both themes
  final Set<String>? resetSkip;

  /// [EzResetButton.saveSkip] passthrough
  /// Shared for both themes
  final Set<String>? saveSkip;

  /// Optional additional quick settings
  /// Will appear first, above the monochrome
  /// BYO spacers
  final List<Widget>? quickHeader;

  /// Optional additional quick settings
  /// Will appear last, just above above the [EzResetButton]
  /// BYO leading spacer, trailing is [resetSpacer]
  final List<Widget>? quickFooter;

  /// Initial set of [Brightness.dark] configKeys to display in the advanced settings
  final List<String> darkStarterSet;

  /// Initial set of [Brightness.light] configKeys to display in the advanced settings
  final List<String> lightStarterSet;

  /// Empathetech color settings
  /// Recommended to use as a [Scaffold.body]
  const EzColorSettings({
    // Shared
    super.key,
    required this.target,
    required this.onUpdate,
    this.resetSpacer = const EzSeparator(),
    required this.appName,
    this.androidPackage,
    this.resetExtraDark,
    this.resetExtraLight,
    this.resetSkip,
    this.saveSkip,

    // Quick
    this.quickHeader,
    this.quickFooter,

    // Advanced
    this.darkStarterSet = const <String>[
      darkPrimaryKey,
      darkSecondaryKey,
      darkTertiaryKey,
      darkSurfaceKey,
      darkOnSurfaceKey,
      darkSurfaceContainerKey,
      darkSurfaceTintKey,
    ],
    this.lightStarterSet = const <String>[
      lightPrimaryKey,
      lightSecondaryKey,
      lightTertiaryKey,
      lightSurfaceKey,
      lightOnSurfaceKey,
      lightSurfaceContainerKey,
      lightSurfaceTintKey,
    ],
  });

  @override
  Widget build(BuildContext context) {
    final String userColorsKey =
        EzConfig.isDark ? userDarkColorsKey : userLightColorsKey;
    final List<String> defaultList =
        EzConfig.isDark ? darkStarterSet : lightStarterSet;

    return (target == EzSubSetting.qckColor)
        ? QuickColorSettings(
            onUpdate: onUpdate,
            quickHeader: quickHeader,
            quickFooter: quickFooter,
            resetSpacer: resetSpacer,
            appName: appName,
            androidPackage: androidPackage,
            resetExtraDark: resetExtraDark,
            resetExtraLight: resetExtraLight,
            resetSkip: resetSkip,
            saveSkip: saveSkip,
          )
        : AdvancedColorSettings(
            onUpdate: onUpdate,
            userColorsKey: userColorsKey,
            defaultList: defaultList,
            currList:
                EzConfig.get(userColorsKey) ?? List<String>.from(defaultList),
            resetSpacer: resetSpacer,
            appName: appName,
            androidPackage: androidPackage,
            resetExtraDark: resetExtraDark,
            resetExtraLight: resetExtraLight,
            resetSkip: resetSkip,
            saveSkip: saveSkip,
          );
  }
}
