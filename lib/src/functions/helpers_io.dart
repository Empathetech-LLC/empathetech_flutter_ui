/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';

/// Get the current [TargetPlatform]
TargetPlatform getHostPlatform(BuildContext context) =>
    Theme.of(context).platform;
