/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

/// Allows letters (upper and lower case) and underscores
String? validateAppName({
  required String? value,
  Function? onSuccess,
  Function? onFailure,
}) {
  final RegExp pattern = RegExp(r'^[a-z0-9_]+$');

  if (value == null || value.isEmpty) {
    onFailure?.call();
    return 'App name is required. Lowercase letters, numbers, and underscores are allowed.';
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

  return (value != null && !pattern.hasMatch(value))
      ? "'name.extension' only"
      : null;
}
