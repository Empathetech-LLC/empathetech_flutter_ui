/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// [showModalBottomSheet] wrapper with custom defaults and uses [EzConfig] based animations
Future<T?> ezModal<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Color? backgroundColor,
  BoxConstraints constraints = const BoxConstraints(minWidth: double.infinity),
  bool isScrollControlled = true,
  bool isDismissible = true,
  bool enableDrag = true,
  bool? showDragHandle,
  bool useSafeArea = true,
  double animMod = 0.75,
  Offset? anchorPoint,
}) =>
    showModalBottomSheet(
      context: context,
      builder: builder,
      backgroundColor: backgroundColor,
      constraints: constraints,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      showDragHandle: showDragHandle,
      useSafeArea: useSafeArea,
      anchorPoint: anchorPoint,
      sheetAnimationStyle: AnimationStyle(
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeInOut,
        duration: ezAnimDuration(mod: animMod),
        reverseDuration: ezAnimDuration(mod: animMod),
      ),
    );
