/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

// App config //

/// Open UI
const String thisAppName = 'Open UI';

/// net.empathetech.open_ui
const String thisPackageName = 'net.empathetech.open_ui';

// App form //

final RegExp appNamePattern = RegExp(r'^[a-z0-9_]+$');

final RegExp domainPattern = RegExp(r'^[a-z0-9_]+\.[a-z]+$');

/// https://docs.flutter.dev/get-started/install
const String installFlutter = 'https://docs.flutter.dev/get-started/install';

// App generator //

enum GeneratorState { running, successful, failed }
