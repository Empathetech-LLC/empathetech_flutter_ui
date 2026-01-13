/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import './export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

/// Allows letters (upper and lower case) and underscores
String? validateAppName({
  required String? value,
  required BuildContext context,
  Function? onSuccess,
  Function? onFailure,
}) {
  final RegExp pattern = RegExp(r'^[a-z0-9_]+$');

  if (value == null || value.isEmpty) {
    onFailure?.call();
    return '${EzConfig.l10n.gRequired}; ${Lang.of(context)!.csInvalidName.toLowerCase()}';
  } else if (!pattern.hasMatch(value)) {
    onFailure?.call();
    return Lang.of(context)!.csInvalidName;
  } else {
    onSuccess?.call();
    return null;
  }
}

/// Validates name.extension domains
String? validateDomain(String? value, BuildContext context) {
  final RegExp pattern = RegExp(r'^[a-z0-9_]+\.[a-z]+$');

  if (value == null || value.isEmpty) {
    return '${EzConfig.l10n.gRequired}; ${Lang.of(context)!.csInvalidName}';
  } else if (!pattern.hasMatch(value)) {
    return Lang.of(context)!.csInvalidDomain;
  } else {
    return null;
  }
}
