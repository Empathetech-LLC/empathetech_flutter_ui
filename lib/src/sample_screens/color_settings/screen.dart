/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import './advanced_settings.dart';
import './quick_settings.dart';
import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzColorSettings extends StatefulWidget {
  /// Optional starting target
  final bool? advanced;

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
    this.advanced,
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
  State<EzColorSettings> createState() => _EzColorSettingsState();
}

class _EzColorSettingsState extends State<EzColorSettings> {
  // Define the build data //

  late EzSubSetting currentTab = (widget.advanced == null)
      ? (EzConfig.get(advancedColorsKey) == true
          ? EzSubSetting.advColor
          : EzSubSetting.qckColor)
      : (widget.advanced! ? EzSubSetting.advColor : EzSubSetting.qckColor);

  // Set the page title //

  @override
  void initState() {
    super.initState();
    ezWindowNamer(EzConfig.l10n.csPageTitle);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    final String userColorsKey =
        EzConfig.isDark ? userDarkColorsKey : userLightColorsKey;
    final List<String> defaultList =
        EzConfig.isDark ? widget.darkStarterSet : widget.lightStarterSet;

    return EzScrollView(mainAxisSize: MainAxisSize.min, children: <Widget>[
      EzConfig.margin,

      // Mode selector(s)
      EzScrollView(
        scrollDirection: Axis.horizontal,
        mainAxisSize: MainAxisSize.min,
        reverseHands: true,
        showScrollHint: true,
        children: <Widget>[
          // Quick/Advanced selector
          SegmentedButton<EzSubSetting>(
            segments: <ButtonSegment<EzSubSetting>>[
              ButtonSegment<EzSubSetting>(
                value: EzSubSetting.qckColor,
                label: Text(EzConfig.l10n.gQuick),
              ),
              ButtonSegment<EzSubSetting>(
                value: EzSubSetting.advColor,
                label: Text(EzConfig.l10n.gAdvanced),
              ),
            ],
            selected: <EzSubSetting>{currentTab},
            showSelectedIcon: false,
            onSelectionChanged: (Set<EzSubSetting> selected) async {
              switch (selected.first) {
                case EzSubSetting.qckColor:
                  currentTab = EzSubSetting.qckColor;
                  await EzConfig.setBool(advancedColorsKey, false);
                  break;
                case EzSubSetting.advColor:
                  currentTab = EzSubSetting.advColor;
                  await EzConfig.setBool(advancedColorsKey, true);
                  break;
                default:
                  // Inconceivable! But required for linter
                  doNothing();
              }
              setState(() {});
            },
          ),

          // Update both toggle
          EzConfig.rowMargin,
          EzThemeCoin(widget.onUpdate,
              enabled: currentTab == EzSubSetting.qckColor),
        ],
      ),
      EzDivider(height: EzConfig.spacing),
      EzConfig.spacer,

      // Core settings
      (currentTab == EzSubSetting.qckColor)
          ? QuickColorSettings(
              onUpdate: widget.onUpdate,
              quickHeader: widget.quickHeader,
              quickFooter: widget.quickFooter,
              resetSpacer: widget.resetSpacer,
              appName: widget.appName,
              androidPackage: widget.androidPackage,
              resetExtraDark: widget.resetExtraDark,
              resetExtraLight: widget.resetExtraLight,
              resetSkip: widget.resetSkip,
              saveSkip: widget.saveSkip,
            )
          : AdvancedColorSettings(
              onUpdate: widget.onUpdate,
              userColorsKey: userColorsKey,
              defaultList: defaultList,
              currList:
                  EzConfig.get(userColorsKey) ?? List<String>.from(defaultList),
              resetSpacer: widget.resetSpacer,
              appName: widget.appName,
              androidPackage: widget.androidPackage,
              resetExtraDark: widget.resetExtraDark,
              resetExtraLight: widget.resetExtraLight,
              resetSkip: widget.resetSkip,
              saveSkip: widget.saveSkip,
            ),
    ]);
  }
}
