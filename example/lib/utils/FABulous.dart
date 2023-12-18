import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class BackFAB extends FloatingActionButton {
  /// [FloatingActionButton] that goes back via [popScreen]
  BackFAB({required BuildContext context, dynamic result})
      : super(
          child: Icon(PlatformIcons(context).back),
          onPressed: () => popScreen(context: context, result: result),
          tooltip: EFUILang.of(context)!.gBack,
        );
}
