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
  });
}

const String _quick = 'quick';
const String _advanced = 'advanced';

const String _button = 'button';
const String _page = 'page';

enum EzSubSetting {
  // null
  blank(
    path: '',
    bothable: false,
    write: ('nullTab!Key', false),
  ),

  // Color
  qckColor(
    path: _quick,
    bothable: true,
    write: (advancedColorsKey, false),
  ),
  advColor(
    path: _advanced,
    bothable: true,
    write: (advancedColorsKey, true),
  ),

  // Design
  butDesign(
    path: _button,
    bothable: true,
    write: (pageTabKey, false),
  ),
  pagDesign(
    path: _page,
    bothable: true,
    write: (pageTabKey, true),
  ),

  // Text
  qckText(
    path: _quick,
    bothable: true,
    write: (advancedTextKey, false),
  ),
  advText(
    path: _advanced,
    bothable: true,
    write: (advancedTextKey, true),
  );

  final String path;
  final bool bothable;
  final (String, bool) write;

  /// Custom enum for populating [EzSettingsSection]
  const EzSubSetting({
    required this.path,
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
