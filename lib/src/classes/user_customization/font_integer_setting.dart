/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzFontIntegerSetting extends StatefulWidget {
  final String styleKey;

  /// Standardized tool for updating the [TextStyle.fontFamily] for the passed [styleKey]
  /// [EzFontIntegerSetting] options are built from [googleStyles]
  const EzFontIntegerSetting({super.key, required this.styleKey});

  @override
  State<EzFontIntegerSetting> createState() => _FontIntegerSettingState();
}

class _FontIntegerSettingState extends State<EzFontIntegerSetting> {
  // Gather the theme data //

  late final EFUILang l10n = EFUILang.of(context)!;

  late int currSize = EzConfig.get(widget.styleKey);

  late final Size sizeLimit = measureText(
    '96',
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
        initialValue: currSize.toString(),
        onChanged: (String value) {
          final int intVal = int.tryParse(value)!;

          setState(() {
            currSize = intVal;
          });
          EzConfig.setInt(widget.styleKey, intVal);
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (String? value) {
          if (value == null) return null;

          final int? intVal = int.tryParse(value);

          if (intVal == null || intVal < 8 || intVal > 96) {
            return '8-96';
          }

          return null;
        },
      ),
    );
  }
}
