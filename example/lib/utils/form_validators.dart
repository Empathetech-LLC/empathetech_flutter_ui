/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

const String longestError =
    'Required; lowercase letters, numbers, and underscores are allowed.';

/// Allows letters (upper and lower case) and underscores
String? validateAppName({
  required String? value,
  Function? onSuccess,
  Function? onFailure,
}) {
  final RegExp pattern = RegExp(r'^[a-z0-9_]+$');

  if (value == null || value.isEmpty) {
    onFailure?.call();
    return 'Required; lowercase letters, numbers, and underscores are allowed.';
  } else if (!pattern.hasMatch(value)) {
    onFailure?.call();
    return 'Only lowercase letters, numbers, and underscores are allowed.';
  } else {
    onSuccess?.call();
    return null;
  }
}

/// Validates name.extension domains
String? validateDomain(String? value) {
  final RegExp pattern = RegExp(r'^[a-z0-9_]+\.[a-z]+$');

  if (value == null || value.isEmpty) {
    return "Required; 'dom.name'";
  } else if (!pattern.hasMatch(value)) {
    return "'dom.name' only; r'^[a-z0-9_]+\\.[a-z]+\$'";
  } else {
    return null;
  }
}
