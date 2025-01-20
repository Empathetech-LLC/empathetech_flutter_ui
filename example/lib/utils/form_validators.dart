/* open_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import './export.dart';

/// Allows letters (upper and lower case) and underscores
String? validateAppName({
  required String? value,
  required Lang l10n,
  Function? onSuccess,
  Function? onFailure,
}) {
  final RegExp pattern = RegExp(r'^[a-z0-9_]+$');

  if (value == null || value.isEmpty) {
    onFailure?.call();
    return '${l10n.gRequired}; ${l10n.csInvalidName.toLowerCase()}';
  } else if (!pattern.hasMatch(value)) {
    onFailure?.call();
    return l10n.csInvalidName;
  } else {
    onSuccess?.call();
    return null;
  }
}

/// Validates name.extension domains
String? validateDomain(String? value, Lang l10n) {
  final RegExp pattern = RegExp(r'^[a-z0-9_]+\.[a-z]+$');

  if (value == null || value.isEmpty) {
    return '${l10n.gRequired}; ${l10n.csInvalidName}';
  } else if (!pattern.hasMatch(value)) {
    return l10n.csInvalidDomain;
  } else {
    return null;
  }
}
