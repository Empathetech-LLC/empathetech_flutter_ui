/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzFontDoubleSetting extends StatefulWidget {
  final String configKey;
  final double min;
  final double max;

  /// Standardized tool for updating double [TextStyle] values for the passed [configKey]
  /// For example: [TextStyle.letterSpacing]
  const EzFontDoubleSetting({
    super.key,
    required this.configKey,
    required this.min,
    required this.max,
  });

  @override
  State<EzFontDoubleSetting> createState() => _FontDoubleSettingState();
}

class _FontDoubleSettingState extends State<EzFontDoubleSetting> {
  // Gather the theme data //

  late double currValue = EzConfig.get(widget.configKey);

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
          final double? doubleVal = double.tryParse(value);
          if (doubleVal == null) return;

          setState(() {
            currValue = doubleVal;
          });
          EzConfig.setDouble(widget.configKey, doubleVal);
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (String? value) {
          if (value == null) return null;

          final double? doubleVale = double.tryParse(value);

          if (doubleVale == null ||
              doubleVale < widget.min ||
              doubleVale > widget.max) {
            return '${widget.min}-${widget.max}';
          }

          return null;
        },
      ),
    );
  }
}
