/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:efui_bios/efui_bios.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class SuccessPage extends StatefulWidget {
  /// Core message to display... under 'Success'
  final String message;

  /// [ThemeData.textTheme] passthrough
  final TextTheme textTheme;

  /// The Flutter project directory
  final String projDir;

  /// Optional readout passthrough
  final StringBuffer? readout;

  const SuccessPage({
    super.key,
    required this.message,
    required this.textTheme,
    required this.projDir,
    this.readout,
  });

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  // Gather the theme data //

  late final TextStyle? focusStyle = widget.textTheme.bodyLarge
      ?.copyWith(fontSize: widget.textTheme.titleLarge?.fontSize);

  // Define the build data //

  bool emulating = false;

  String device() {
    late final TargetPlatform platform = getBasePlatform(context);

    if (platform == TargetPlatform.linux) {
      return 'linux';
    } else if (platform == TargetPlatform.macOS) {
      return 'macos';
    } else if (platform == TargetPlatform.windows) {
      return 'windows';
    } else {
      return 'chrome';
    }
  }

  // Return the build //

  late final Widget successBlock = Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text(
        'Success!',
        style: widget.textTheme.headlineLarge,
        textAlign: TextAlign.center,
      ),

      // Where to go next
      Text(
        widget.message,
        style: focusStyle,
        textAlign: TextAlign.center,
      ),
    ],
  );

  /// Page header
  late Widget header = successBlock;

  @override
  Widget build(BuildContext context) {
    return EzScrollView(
      children: <Widget>[
        // Headline
        header,
        const EzDivider(),

        // Optional start button
        Text(
          'would you like to...',
          style: focusStyle,
          textAlign: TextAlign.center,
        ),
        const EzSpacer(),

        EzElevatedIconButton(
          onPressed: () async {
            if (emulating) return;

            setState(() {
              emulating = true;

              header = EmpathetechLoadingAnimation(
                height: heightOf(context) / 3,
                semantics: 'TODO',
              );
            });
            ezSnackBar(
              context: context,
              message: 'First time usually takes awhile',
            );

            await ezCLI(
              exe: 'flutter',
              args: <String>[
                'run',
                '-d',
                device(),
              ],
              dir: widget.projDir,
              onSuccess: () => setState(() {
                emulating = false;
                header = successBlock;
              }),
              onFailure: (String message) => setState(() {
                emulating = false;
                header = Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Emulator failed',
                      style: widget.textTheme.headlineLarge,
                      textAlign: TextAlign.center,
                    ),

                    // Where to go next
                    Text(
                      widget.message,
                      style: focusStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              }),
              readout: widget.readout,
            );
          },
          icon: Icon(PlatformIcons(context).playArrowSolid),
          label: 'Run it',
        ),
        const EzSeparator(),
      ],
    );
  }
}
