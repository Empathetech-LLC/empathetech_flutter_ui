/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

/// Allows letters (upper and lower case) and underscores
String? validateAppName(String? value) {
  final RegExp pattern = RegExp(r'^[a-z0-9_]+$');

  return (value != null && !pattern.hasMatch(value))
      ? 'Only lowercase letters, numbers, and underscores are allowed'
      : null;
}

/// Validates name.extension domains
String? validateDomain(String? value) {
  final RegExp pattern = RegExp(r'^[a-z0-9_]+\.[a-z]+$');

  return (value != null && !pattern.hasMatch(value))
      ? "'name.extension' only"
      : null;
}
