/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import './export.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

/// Allows letters (upper and lower case) and underscores
String? validateAppName({
  required String? value,
  Function? onSuccess,
  Function? onFailure,
}) {
  if (value == null || value.isEmpty) {
    onFailure?.call();
    return '${EzConfig.l10n.gRequired}; ${l10n.csInvalidName.toLowerCase()}';
  } else if (!appNamePattern.hasMatch(value)) {
    onFailure?.call();
    return l10n.csInvalidName;
  } else {
    onSuccess?.call();
    return null;
  }
}

/// Validates name.extension domains
String? validateDomain(String? value) {
  if (value == null || value.isEmpty) {
    return '${EzConfig.l10n.gRequired}; ${l10n.csInvalidName}';
  } else if (!domainPattern.hasMatch(value)) {
    return l10n.csInvalidDomain;
  } else {
    return null;
  }
}
