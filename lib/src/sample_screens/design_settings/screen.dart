/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'button_settings.dart';
import 'page_settings.dart';
import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class EzDesignSettings extends StatelessWidget {
  /// Current sub-page
  final EzSubSetting target;

  /// [EzConfig.redrawUI]/[EzConfig.rebuildUI] passthrough
  final void Function() onUpdate;

  /// Optional additional settings at the top of the button design tab
  /// BYO tailing spacer(s)
  final List<Widget>? prependButton;

  /// Optional additional settings at the top of the page design tab
  /// BYO tailing spacer(s)
  final List<Widget>? prependPage;

  /// Whether to include the page transition setting
  /// null (default) will become a [kIsWeb] check
  final bool? includePageTransitions;

  /// Whether to include the background image setting
  /// When true, pairs well with [EzScreen], specifically [EzScreen.useImageDecoration]
  final bool includeBackgroundImage;

  /// Optional credits for the dark background image
  /// Moot if [includeBackgroundImage] is false
  final String? darkBackgroundCredits;

  /// Optional credits for the light background image
  /// Moot if [includeBackgroundImage] is false
  final String? lightBackgroundCredits;

  /// Optional additional settings at the bottom of the button design tab (above the reset button)
  /// BYO leading spacer, trailing is [resetSpacerButton]
  final List<Widget>? appendButton;

  /// Optional additional settings at the bottom of the page design tab (above the reset button)
  /// BYO leading spacer, trailing is [resetSpacerPage]
  final List<Widget>? appendPage;

  /// Spacer before the [EzResetButton]
  final Widget resetSpacerButton;

  /// Spacer before the [EzResetButton]
  final Widget resetSpacerPage;

  /// Additional [EzConfig] keys for the local [EzResetButton]
  /// [darkButtonDesignKeys] by default
  final Set<String>? resetExtraDarkButton;

  /// Additional [EzConfig] keys for the local [EzResetButton]
  /// [lightButtonDesignKeys] by default
  final Set<String>? resetExtraLightButton;

  /// Additional [EzConfig] keys for the local [EzResetButton]
  /// [darkPageDesignKeys] by default
  final Set<String>? resetExtraDarkPage;

  /// Additional [EzConfig] keys for the local [EzResetButton]
  /// [lightPageDesignKeys] by default
  final Set<String>? resetExtraLightPage;

  /// [EzResetButton.appName] passthrough
  final String appName;

  /// [EzResetButton.androidPackage] passthrough
  final String? androidPackage;

  /// [EzResetButton.resetSkip] passthrough
  final Set<String>? resetSkipButton;

  /// [EzResetButton.saveSkip] passthrough
  final Set<String>? saveSkipButton;

  /// [EzResetButton.resetSkip] passthrough
  final Set<String>? resetSkipPage;

  /// [EzResetButton.saveSkip] passthrough
  final Set<String>? saveSkipPage;

  /// Empathetech image settings
  /// Recommended to use as a [Scaffold.body]
  const EzDesignSettings({
    super.key,
    required this.target,
    required this.onUpdate,
    this.prependButton,
    this.prependPage,
    this.includePageTransitions,
    this.includeBackgroundImage = true,
    this.darkBackgroundCredits,
    this.lightBackgroundCredits,
    this.appendButton,
    this.appendPage,
    this.resetSpacerButton = const EzSeparator(),
    this.resetSpacerPage = const EzSeparator(),
    this.resetExtraDarkButton,
    this.resetExtraLightButton,
    this.resetExtraDarkPage,
    this.resetExtraLightPage,
    required this.appName,
    this.androidPackage,
    this.resetSkipButton,
    this.saveSkipButton,
    this.resetSkipPage,
    this.saveSkipPage,
  });

  @override
  Widget build(BuildContext context) => EzFauxCarousel(
        position: target.isFirst ? 0 : 1,
        delta: target.isFirst ? -1 : 1,
        animMod: 0.5,
        child: (target == EzSubSetting.butDesign)
            ? ButtonDesign(
                onUpdate: onUpdate,
                prepend: prependButton,
                append: appendButton,
                resetSpacer: resetSpacerButton,
                resetExtraDark: resetExtraDarkButton,
                resetExtraLight: resetExtraLightButton,
                appName: appName,
                androidPackage: androidPackage,
                resetSkip: resetSkipButton,
                saveSkip: saveSkipButton,
              )
            : PageDesign(
                onUpdate: onUpdate,
                prepend: prependPage,
                includePageTransitions: includePageTransitions,
                includeBackgroundImage: includeBackgroundImage,
                darkBackgroundCredits: darkBackgroundCredits,
                lightBackgroundCredits: lightBackgroundCredits,
                append: appendPage,
                resetSpacer: resetSpacerPage,
                resetExtraDark: resetExtraDarkPage,
                resetExtraLight: resetExtraLightPage,
                appName: appName,
                androidPackage: androidPackage,
                resetSkip: resetSkipPage,
                saveSkip: saveSkipPage,
              ),
      );
}
