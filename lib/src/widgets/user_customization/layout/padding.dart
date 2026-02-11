/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzPaddingSetting extends StatefulWidget {
  /// [EzConfig.rebuildUI]/[EzConfig.redrawUI] passthrough
  final void Function() onUpdate;

  /// Whether to update both themes
  final bool setBoth;

  /// Smallest value that can be set
  final double min;

  /// Largest value that can be set
  final double max;

  /// Number of divisions between [min] and [max]
  final int steps;

  /// Number of significant figures to display after the decimal point
  final int decimals;

  /// Defaults to [TextTheme.titleLarge]
  final TextStyle? titleStyle;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? bodyStyle;

  /// An ez to use padding setting
  const EzPaddingSetting({
    super.key,
    required this.onUpdate,
    required this.setBoth,
    required this.min,
    required this.max,
    required this.steps,
    required this.decimals,
    this.titleStyle,
    this.bodyStyle,
  });

  @override
  State<EzPaddingSetting> createState() => _LayoutSettingState();
}

class _LayoutSettingState extends State<EzPaddingSetting> {
  // Define the build data //

  late double currValue = EzConfig.get(widget.configKey);
  late final double defaultValue = EzConfig.getDefault(widget.configKey);

  // Define build functions //

  /// Return the preview Widget(s) for the passed [EzPaddingSettingType]
  List<Widget> buildPreview(BuildContext context) {
    final String valString = currValue.toStringAsFixed(widget.decimals);

    switch (widget.type) {
      // Margin
      case EzPaddingSettingType.margin:
        late final String? backgroundImagePath = EzConfig.get(
            EzConfig.isDark ? darkBackgroundImageKey : lightBackgroundImageKey);

        late final BoxFit? backgroundImageFit = boxFitLib[EzConfig.get(
            EzConfig.isDark
                ? '$darkBackgroundImageKey$boxFitSuffix'
                : '$lightBackgroundImageKey$boxFitSuffix')];

        return <Widget>[
          EzConfig.spacer,
          EzTextBackground(
            Text(
              valString,
              style: widget.bodyStyle ??
                  EzConfig.styles.bodyLarge
                      ?.copyWith(color: EzConfig.colors.surface),
              textAlign: TextAlign.center,
            ),
            margin: EzInsets.wrap(currValue),
            backgroundColor: EzConfig.colors.onSurface,
          ),
          EzSpacer(space: currValue),
          Container(
            color: EzConfig.colors.onSurface,
            height: heightOf(context) * 0.25,
            width: widthOf(context) * 0.25,
            child: Container(
              decoration: BoxDecoration(
                color: EzConfig.colors.surface,
                image: (backgroundImagePath == null ||
                        backgroundImagePath == noImageValue)
                    ? null
                    : DecorationImage(
                        image: ezImageProvider(backgroundImagePath),
                        fit: backgroundImageFit,
                      ),
              ),
              margin: EdgeInsets.all(currValue * 0.25),
            ),
          ),
          EzConfig.spacer,
        ];

      // Padding
      case EzPaddingSettingType.padding:
        return <Widget>[
          EzConfig.spacer,

          // Live label && preview
          EzScrollView(
            mainAxisSize: MainAxisSize.min,
            scrollDirection: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              EzElevatedButton(
                enabled: false,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(currValue),
                ),
                text: EzConfig.l10n.gCurrently,
              ),
              const EzSpacer(vertical: false),
              EzElevatedButton(
                enabled: false,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(currValue),
                  shape: const CircleBorder(),
                ),
                text: valString,
              ),
            ],
          ),

          EzConfig.spacer,
        ];

      // Spacing
      case EzPaddingSettingType.spacing:
        return <Widget>[
          // Preview 1
          EzSpacer(space: currValue),

          // Label
          EzScrollView(
            mainAxisSize: MainAxisSize.min,
            scrollDirection: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              EzElevatedButton(enabled: false, text: EzConfig.l10n.gCurrently),
              EzSpacer(space: currValue, vertical: false),
              EzElevatedButton(
                enabled: false,
                style: ElevatedButton.styleFrom(shape: const CircleBorder()),
                text: valString,
              ),
            ],
          ),

          // Preview 2
          EzSpacer(space: currValue),
        ];
    }
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    final String label = ezLstName(context, widget.type);

    return EzElevatedIconButton(
      onPressed: () => ezModal(
        context: context,
        builder: (_) => StatefulBuilder(
          builder: (_, StateSetter setModal) {
            return EzScrollView(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Preview
                Semantics(
                  button: false,
                  readOnly: true,
                  label: EzConfig.l10n.gSetToValue(
                    label,
                    currValue.toStringAsFixed(widget.decimals),
                  ),
                  child: ExcludeSemantics(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Title
                        Text(
                          label,
                          style:
                              widget.titleStyle ?? EzConfig.styles.titleLarge,
                          textAlign: TextAlign.center,
                        ),

                        // Preview
                        ...buildPreview(context),
                      ],
                    ),
                  ),
                ),

                // Slider
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: ScreenSize.small.size),
                  child: Slider(
                    // Slider values
                    value: currValue,
                    min: widget.min,
                    max: widget.max,
                    divisions: widget.steps,

                    // Slider functions
                    onChanged: (double value) =>
                        setModal(() => currValue = value),
                    onChangeEnd: (double value) =>
                        EzConfig.setDouble(widget.configKey, value),

                    // Slider semantics
                    semanticFormatterCallback: (double value) =>
                        value.toStringAsFixed(widget.decimals),
                  ),
                ),
                EzConfig.spacer,

                // Reset button
                EzElevatedIconButton(
                  onPressed: () async {
                    await EzConfig.remove(widget.configKey);
                    setModal(() => currValue = defaultValue);
                  },
                  icon: const Icon(Icons.refresh),
                  label:
                      '${EzConfig.l10n.gResetTo} ${defaultValue.toStringAsFixed(widget.decimals)}',
                ),
                EzSpacer(space: EzConfig.spacing * 1.5),
              ],
            );
          },
        ),
      ),
      icon: ezLstIcon(widget.type),
      label: label,
    );
  }
}
