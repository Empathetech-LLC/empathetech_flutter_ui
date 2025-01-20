/* open_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

// Exports //

export 'error.dart';
export 'home.dart';

export 'generator/generate.dart';
export 'generator/archive.dart';

export 'settings/settings_home.dart';
export 'settings/text_settings.dart';
export 'settings/image_settings.dart';
export 'settings/color_settings.dart';
export 'settings/layout_settings.dart';

// Route names //

/// 'app-generator'
const String generateScreenPath = 'app-generator';

/// 'config-archiver'
const String archiveScreenPath = 'config-archiver';

/// 'settings-home'
const String settingsHomePath = 'settings-home';

/// 'text-settings'
const String textSettingsPath = 'text-settings';

/// 'image-settings'
const String imageSettingsPath = 'image-settings';

/// 'color-settings'
const String colorSettingsPath = 'color-settings';

/// 'layout-settings'
const String layoutSettingsPath = 'layout-settings';
