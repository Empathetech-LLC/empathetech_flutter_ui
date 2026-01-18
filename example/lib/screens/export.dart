/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

// Exports //

export 'error.dart';
export 'home.dart';

export 'generator/generate.dart';
export 'generator/archive.dart';

export 'settings/home.dart';

export 'settings/color.dart';
export 'settings/design.dart';
export 'settings/layout.dart';
export 'settings/text.dart';

// Route names //

/// app-generator
const String generateScreenPath = 'app-generator';

/// config-archiver
const String archiveScreenPath = 'config-archiver';

/// settings-home
const String settingsHomePath = 'settings-home';

/// color-settings
const String colorSettingsPath = 'color-settings';

/// design-settings
const String designSettingsPath = 'design-settings';

/// layout-settings
const String layoutSettingsPath = 'layout-settings';

/// text-settings
const String textSettingsPath = 'text-settings';
