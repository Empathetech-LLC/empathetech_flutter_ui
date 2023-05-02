library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// [Card] designed to grab attention for warnings...
/// [Icon] 'WARNING' [Icon]
///        [content]
Card warningCard({
  required BuildContext context,
  required String warning,
  TextStyle? style,
}) {
  Color iconColor = Color(EzConfig.prefs[alertColorKey]);

  double padding = EzConfig.prefs[paddingKey];

  return Card(
    child: Container(
      padding: EdgeInsets.all(padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Title
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Thing1
              Icon(
                Icons.warning,
                color: iconColor,
                size: style?.fontSize,
              ),
              Container(width: padding),

              EzSelectableText(
                'WARNING',
                style: style,
              ),
              Container(width: padding),

              // Thing 2
              Icon(
                Icons.warning,
                color: iconColor,
                size: style?.fontSize,
              ),
            ],
          ),
          Container(height: padding),

          // Label
          EzSelectableText(warning, style: style),
        ],
      ),
    ),
  );
}
