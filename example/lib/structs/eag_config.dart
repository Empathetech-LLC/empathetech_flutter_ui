/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'dart:convert';
import 'package:flutter/foundation.dart';

class EAGConfig {
  EAGConfig();

  Map<String, dynamic> toJson() {
    return <String, dynamic>{};
  }

  factory EAGConfig.fromJson(dynamic json) {
    return EAGConfig();
  }

  @override
  String toString() {
    return super.toString();
  }
}
