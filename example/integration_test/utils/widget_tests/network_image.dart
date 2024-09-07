/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../export.dart';

import 'dart:math';

String getImageUrl() {
  final int choice = Random().nextInt(imageURLs.length);
  return imageURLs[choice];
}
