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

  /// Whether to show the play button for emulation
  /// Should only be true on desktop platforms
  final bool showPlay;

  /// The Flutter project directory, required iff [showPlay] is true
  final String? projDir;

  /// Optional readout passthrough, only for when [showPlay] is true
  final StringBuffer? readout;

  const SuccessPage({
    super.key,
    required this.message,
    required this.textTheme,
    this.showPlay = false,
    this.projDir,
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

        // Optional start button
        if (widget.showPlay && widget.projDir != null) ...<Widget>[
          const EzDivider(),
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

                header = SizedBox(
                  height: heightOf(context) / 3,
                  child: const EmpathetechLoadingAnimation(
                    height: double.infinity,
                    semantics: 'TODO',
                  ),
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
                dir: widget.projDir!,
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
        ],

        const EzSeparator(),
      ],
    );
  }
}
