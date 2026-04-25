/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';

import '../../empathetech_flutter_ui.dart';

class EzSettingsSection {
  /// Ordered position amongst the tabs ([ButtonSegment]s)
  final int position;

  /// What to display above the [SegmentedButton] in [EzSettingsHub]
  final String title;

  /// What to display on the [SegmentedButton] in [EzSettingsHub]
  final Widget icon;

  /// Quick/Advanced and the like
  final List<EzSubSetting> subSettings;

  final EzSubSetting Function() fromStorage;

  /// Page content for [EzSettingsHub]
  final Widget Function(EzSubSetting) build;

  /// Custom class for building [EzSettingsHub]
  const EzSettingsSection({
    required this.position,
    required this.title,
    required this.icon,
    required this.subSettings,
    required this.fromStorage,
    required this.build,
  }) : assert(subSettings.length == 0 || subSettings.length == 2,
            '0 or 2 sub settings.');
}

const String _quick = 'quick';
const String _advanced = 'advanced';

const String _button = 'button';
const String _page = 'page';

enum EzSubSetting {
  // null
  blank(
    path: '',
    isFirst: true,
    bothable: false,
    write: ('nullTab!Key', false),
  ),

  // Color
  qckColor(
    path: _quick,
    isFirst: true,
    bothable: true,
    write: (advancedColorsKey, false),
  ),
  advColor(
    path: _advanced,
    isFirst: false,
    bothable: false,
    write: (advancedColorsKey, true),
  ),

  // Design
  butDesign(
    path: _button,
    isFirst: true,
    bothable: true,
    write: (pageTabKey, false),
  ),
  pagDesign(
    path: _page,
    isFirst: false,
    bothable: true,
    write: (pageTabKey, true),
  ),

  // Text
  qckText(
    path: _quick,
    isFirst: true,
    bothable: true,
    write: (advancedTextKey, false),
  ),
  advText(
    path: _advanced,
    isFirst: false,
    bothable: false,
    write: (advancedTextKey, true),
  );

  final String path;
  final bool isFirst;
  final bool bothable;
  final (String, bool) write;

  /// Custom enum for populating [EzSettingsSection]
  const EzSubSetting({
    required this.path,
    required this.isFirst,
    required this.bothable,
    required this.write,
  });
}

extension ESSLookup on EzSubSetting {
  String get label {
    switch (this) {
      case EzSubSetting.blank:
        return 'null';

      case EzSubSetting.qckText:
      case EzSubSetting.qckColor:
        return EzConfig.l10n.gQuick;
      case EzSubSetting.advText:
      case EzSubSetting.advColor:
        return EzConfig.l10n.gAdvanced;

      case EzSubSetting.butDesign:
        return EzConfig.l10n.dsButton;
      case EzSubSetting.pagDesign:
        return EzConfig.l10n.dsPage;
    }
  }
}
