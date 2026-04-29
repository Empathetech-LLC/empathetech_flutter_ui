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

  /// Spacer above the [EzResetButton], on both sub-screens
  final Widget resetSpacer;

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

  final String _userColorsKey;

  /// Initial set of [Brightness.dark] configKeys to display in the advanced settings
  final List<String> darkStarterSet;

  /// Initial set of [Brightness.light] configKeys to display in the advanced settings
  final List<String> lightStarterSet;

  final List<String> _defaultList;

  /// Empathetech color settings
  /// Recommended to use as a [Scaffold.body]
  EzColorSettings({
    // Shared
    super.key,
    required this.target,
    this.resetSpacer = const EzSeparator(),
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
  })  : _userColorsKey = EzConfig.isDark ? userDarkColorsKey : userLightColorsKey,
        _defaultList = EzConfig.isDark ? darkStarterSet : lightStarterSet;

  @override
  Widget build(BuildContext context) => EzFauxCarousel(
        position: target.isFirst ? 0 : 1,
        delta: target.isFirst ? -1 : 1,
        animMod: 0.5,
        child: (target == EzSubSetting.qckColor)
            ? QuickColorSettings(
                quickHeader: quickHeader,
                quickFooter: quickFooter,
                resetSpacer: resetSpacer,
                resetExtraDark: resetExtraDark,
                resetExtraLight: resetExtraLight,
                resetSkip: resetSkip,
                saveSkip: saveSkip,
              )
            : AdvancedColorSettings(
                userColorsKey: _userColorsKey,
                defaultList: _defaultList,
                currList: EzConfig.get(_userColorsKey) ?? List<String>.from(_defaultList),
                resetSpacer: resetSpacer,
                resetExtraDark: resetExtraDark,
                resetExtraLight: resetExtraLight,
                resetSkip: resetSkip,
                saveSkip: saveSkip,
              ),
      );
}
