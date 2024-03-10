/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzFontIntegerSetting extends StatefulWidget {
  final String configKey;
  final int min;
  final int max;

  /// Standardized tool for updating integer [TextStyle] values for the passed [configKey]
  /// For example: [TextStyle.fontSize]
  const EzFontIntegerSetting({
    super.key,
    required this.configKey,
    required this.min,
    required this.max,
  });

  @override
  State<EzFontIntegerSetting> createState() => _FontIntegerSettingState();
}

class _FontIntegerSettingState extends State<EzFontIntegerSetting> {
  // Gather the theme data //

  late int currValue = EzConfig.get(widget.configKey);

  late final Size sizeLimit = measureText(
    widget.max.toString(),
    style: getBody(context),
    context: context,
  );

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: sizeLimit.width * 3,
        maxHeight: sizeLimit.height * 2,
      ),
      child: PlatformTextFormField(
        keyboardType: TextInputType.number,
        initialValue: currValue.toString(),
        onChanged: (String value) {
          final int? intVal = int.tryParse(value);
          if (intVal == null) return;

          setState(() {
            currValue = intVal;
          });
          EzConfig.setInt(widget.configKey, intVal);
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (String? value) {
          if (value == null) return null;

          final int? intVal = int.tryParse(value);

          if (intVal == null || intVal < widget.min || intVal > widget.max) {
            return '${widget.min}-${widget.max}';
          }

          return null;
        },
      ),
    );
  }
}
