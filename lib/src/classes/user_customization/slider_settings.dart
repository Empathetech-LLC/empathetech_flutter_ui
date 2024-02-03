/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzSliderSetting extends StatefulWidget {
  /// The [EzConfig] key whose value is being updated
  final String prefsKey;

  /// enum for determining the preview Widget(s) required
  final SliderSettingType type;

  /// Smallest value that can be set
  final double min;

  /// Largest value that can be set
  final double max;

  /// Number of divisions between [min] and [max]
  final int steps;

  /// Number of significant figures to display AFTER the decimal point
  final int decimals;

  /// Creates a tool for updating any [prefsKey] value that would pair well with a [PlatformSlider]
  /// Use the [type] enum for generating the appropriate preview [Widget]s
  const EzSliderSetting({
    super.key,
    required this.prefsKey,
    required this.type,
    required this.min,
    required this.max,
    required this.steps,
    required this.decimals,
  });

  @override
  State<EzSliderSetting> createState() => _SliderSettingState();
}

class _SliderSettingState extends State<EzSliderSetting> {
  // Gather the theme data //

  late final double _defaultValue = EzConfig.getDefault(widget.prefsKey);
  late double currValue = EzConfig.get(widget.prefsKey);

  final double space = EzConfig.get(spacingKey);
  late final EzSpacer _spacer = EzSpacer(space);

  late final String _label = sstName(context, widget.type);

  // Define build functions //

  /// Return the preview Widget(s) for the passed [SliderSettingType]
  List<Widget> _buildPreview(BuildContext context, TextStyle? style) {
    final String currLabel =
        '${EFUILang.of(context)!.gCurrently} ${currValue.toStringAsFixed(widget.decimals)}';

    switch (widget.type) {
      // Text settings //

      // Font size
      case SliderSettingType.fontSize:
        return <Widget>[Container()];

      // Font weight
      case SliderSettingType.fontWeight:
        return <Widget>[Container()];

      // Font style
      case SliderSettingType.fontStyle:
        return <Widget>[Container()];

      // Letter spacing
      case SliderSettingType.letterSpacing:
        return <Widget>[Container()];

      // Word spacing
      case SliderSettingType.wordSpacing:
        return <Widget>[Container()];

      // Font height
      case SliderSettingType.fontHeight:
        return <Widget>[Container()];

      // Font decoration
      case SliderSettingType.fontDecoration:
        return <Widget>[Container()];

      // Layout settings //

      // Margin
      case SliderSettingType.margin:
        const double previewHeight = 160.0;
        const double previewWidth = 90.0;

        final double marginScale = previewWidth / widthOf(context);
        final double liveMargin = currValue * marginScale;

        return <Widget>[
          _spacer,

          // Live preview && label
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Label
              Text(
                currLabel,
                style: style,
                textAlign: TextAlign.center,
              ),
              EzSpacer.row(space * 2),

              // Preview
              Container(
                color: Theme.of(context).colorScheme.onBackground,
                height: previewHeight,
                width: previewWidth,
                child: Container(
                  color: Theme.of(context).colorScheme.background,
                  margin: EdgeInsets.all(liveMargin),
                ),
              ),
            ],
          ),
          _spacer,
        ];

      // Padding
      case SliderSettingType.padding:
        return <Widget>[
          _spacer,

          // Live label && preview
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.all(currValue),
                      ),
                    ),
                onPressed: doNothing,
                child: Text(EFUILang.of(context)!.gCurrently),
              ),
              EzSpacer.row(space),
              ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.all(currValue),
                      ),
                      shape: const MaterialStatePropertyAll<OutlinedBorder>(
                        CircleBorder(),
                      ),
                    ),
                onPressed: doNothing,
                child: Text(currValue.toStringAsFixed(widget.decimals)),
              ),
            ],
          ),

          _spacer,
        ];

      // Spacing
      case SliderSettingType.spacing:
        return <Widget>[
          // Preview 1
          EzSpacer(currValue),

          // Label
          ElevatedButton(
            onPressed: doNothing,
            child: Text(currLabel),
          ),

          // Preview 2
          EzSpacer(currValue),
        ];
    }
  }

  /// Assemble the final list of widgets to build for [_SliderSettingState]
  /// [widget.title] + [_buildPreview] + [PlatformSlider] + reset [ElevatedButton.icon]
  List<Widget> buildModal({
    required BuildContext context,
    required StateSetter setModalState,
    required TextStyle? style,
  }) {
    return <Widget>[
      // Preview
      Semantics(
        button: false,
        readOnly: true,
        label: EFUILang.of(context)!.gSetToValue(
          _label,
          currValue.toStringAsFixed(widget.decimals),
        ),
        child: ExcludeSemantics(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _label,
                style: style,
                textAlign: TextAlign.center,
              ),
              ..._buildPreview(context, style),
            ],
          ),
        ),
      ),

      // Slider
      ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 700, // Chosen via visual inspection
        ),
        child: Slider(
          // Slider values
          value: currValue,
          min: widget.min,
          max: widget.max,
          divisions: widget.steps,

          // Slider functions
          onChanged: (double value) {
            // Just update the on screen value while sliding around
            setModalState(() {
              currValue = value;
            });
          },
          onChangeEnd: (double value) {
            // When finished, write the result
            if (value == _defaultValue) {
              EzConfig.remove(widget.prefsKey);
            } else {
              EzConfig.setDouble(widget.prefsKey, value);
            }
          },

          // Slider semantics
          semanticFormatterCallback: (double value) =>
              value.toStringAsFixed(widget.decimals),
        ),
      ),
      _spacer,

      // Reset button
      ElevatedButton.icon(
        onPressed: () {
          EzConfig.remove(widget.prefsKey);
          setModalState(() {
            currValue = _defaultValue;
          });
        },
        icon: Icon(PlatformIcons(context).refresh),
        label: Text(
          '${EFUILang.of(context)!.gReset} ${_defaultValue.toStringAsFixed(widget.decimals)}',
        ),
      ),
      _spacer,
    ];
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (BuildContext context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return EzScrollView(
              mainAxisSize: MainAxisSize.min,
              children: buildModal(
                context: context,
                setModalState: setModalState,
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
            );
          },
        ),
      ),
      icon: widget.type.icon,
      label: Text(_label),
    );
  }
}
