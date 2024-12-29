/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

// Exports //

export 'error.dart';
export 'home.dart';

export 'settings/settings_home.dart';
export 'settings/text_settings.dart';
export 'settings/image_settings.dart';
export 'settings/color_settings.dart';
export 'settings/layout_settings.dart';

export 'generator/progress.dart';
export 'generator/success.dart';
export 'generator/failure.dart';

// Route names //

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

/// 'generator-progress'
const String progressPath = 'generator-progress';

/// 'generator-success'
const String successPath = 'generator-success';

/// 'generator-failure'
const String failurePath = 'generator-failure';
