/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'button_settings.dart';
import 'page_settings.dart';
import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class EzDesignSettings extends StatefulWidget {
  /// Optionally start on the page design tab
  final bool? pageTab;

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
  /// BYO leading spacer, trailing is [resetSpacer]
  final List<Widget>? appendButton;

  /// Optional additional settings at the bottom of the page design tab (above the reset button)
  /// BYO leading spacer, trailing is [resetSpacer]
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

  /// Defaults to [EzSeparator]
  final Widget trail;

  /// Empathetech image settings
  /// Recommended to use as a [Scaffold.body]
  const EzDesignSettings({
    super.key,
    this.pageTab,
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
    this.trail = const EzSeparator(),
  });

  @override
  State<EzDesignSettings> createState() => _EzDesignSettingsState();
}

class _EzDesignSettingsState extends State<EzDesignSettings> {
  // Define the build data //

  late EzSubSetting currentTab = (widget.pageTab == null)
      ? (EzConfig.get(pageTabKey) == true
          ? EzSubSetting.pagDesign
          : EzSubSetting.butDesign)
      : (widget.pageTab! ? EzSubSetting.pagDesign : EzSubSetting.butDesign);

  // Set the page title //

  @override
  void initState() {
    super.initState();
    ezWindowNamer(EzConfig.l10n.dsPageTitle);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) => (currentTab == EzSubSetting.butDesign)
      ? ButtonDesign(
          onUpdate: widget.onUpdate,
          prepend: widget.prependButton,
          append: widget.appendButton,
          resetSpacer: widget.resetSpacerButton,
          resetExtraDark: widget.resetExtraDarkButton,
          resetExtraLight: widget.resetExtraLightButton,
          appName: widget.appName,
          androidPackage: widget.androidPackage,
          resetSkip: widget.resetSkipButton,
          saveSkip: widget.saveSkipButton,
        )
      : PageDesign(
          onUpdate: widget.onUpdate,
          prepend: widget.prependPage,
          includePageTransitions: widget.includePageTransitions,
          includeBackgroundImage: widget.includeBackgroundImage,
          darkBackgroundCredits: widget.darkBackgroundCredits,
          lightBackgroundCredits: widget.lightBackgroundCredits,
          append: widget.appendPage,
          resetSpacer: widget.resetSpacerPage,
          resetExtraDark: widget.resetExtraDarkPage,
          resetExtraLight: widget.resetExtraLightPage,
          appName: widget.appName,
          androidPackage: widget.androidPackage,
          resetSkip: widget.resetSkipPage,
          saveSkip: widget.saveSkipPage,
        );
}
