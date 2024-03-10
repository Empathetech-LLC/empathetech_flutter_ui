/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Enumerator for selecting which piece of the layout is being updated
/// This will determine the preview [Widget]s
enum LayoutSettingType {
  margin,
  padding,
  spacing,
}

/// Get the proper [String] name for [EzLayoutSetting.type]
String lstName(BuildContext context, LayoutSettingType settingType) {
  switch (settingType) {
    case LayoutSettingType.margin:
      return EFUILang.of(context)!.lsMargin;
    case LayoutSettingType.padding:
      return EFUILang.of(context)!.lsPadding;
    case LayoutSettingType.spacing:
      return EFUILang.of(context)!.lsSpacing;
  }
}

/// Enumerator extension for getting the proper button [Icon] for [EzLayoutSetting.type]
extension SettingIcon on LayoutSettingType {
  Icon get icon {
    switch (this) {
      case LayoutSettingType.margin:
        return const Icon(Icons.margin);
      case LayoutSettingType.padding:
        return const Icon(Icons.padding);
      case LayoutSettingType.spacing:
        return const Icon(Icons.space_bar);
    }
  }
}

class EzLayoutSetting extends StatefulWidget {
  /// The [EzConfig] key whose value is being updated
  final String configKey;

  /// enum for determining the preview Widget(s) required
  final LayoutSettingType type;

  /// Smallest value that can be set
  final double min;

  /// Largest value that can be set
  final double max;

  /// Number of divisions between [min] and [max]
  final int steps;

  /// Number of significant figures to display AFTER the decimal point
  final int decimals;

  /// Creates a tool for updating any [configKey] value that would pair well with a [PlatformSlider]
  /// Use the [type] enum for generating the appropriate preview [Widget]s
  const EzLayoutSetting({
    super.key,
    required this.configKey,
    required this.type,
    required this.min,
    required this.max,
    required this.steps,
    required this.decimals,
  });

  @override
  State<EzLayoutSetting> createState() => _LayoutSettingState();
}

class _LayoutSettingState extends State<EzLayoutSetting> {
  // Gather the theme data //

  late final double _defaultValue = EzConfig.getDefault(widget.configKey);
  late double currValue = EzConfig.get(widget.configKey);

  final double space = EzConfig.get(spacingKey);
  late final EzSpacer spacer = EzSpacer(space);
  late final EzSpacer rowSpacer = EzSpacer.row(space);
  late final EzSpacer rowSeparator = EzSpacer.row(2 * space);

  late final String label = lstName(context, widget.type);

  late final EFUILang l10n = EFUILang.of(context)!;

  late final TextStyle? titleStyle = getTitle(context);
  late final TextStyle? bodyStyle = getBody(context);

  // Define build functions //

  /// Return the preview Widget(s) for the passed [LayoutSettingType]
  List<Widget> _buildPreview(BuildContext context) {
    final String currLabel =
        '${l10n.gCurrently} ${currValue.toStringAsFixed(widget.decimals)}';

    switch (widget.type) {
      // Margin
      case LayoutSettingType.margin:
        const double previewHeight = 160.0;
        const double previewWidth = 90.0;

        final double marginScale = previewWidth / widthOf(context);
        final double liveMargin = currValue * marginScale;

        return <Widget>[
          spacer,

          // Live preview && label
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Label
              Text(
                currLabel,
                style: bodyStyle,
                textAlign: TextAlign.center,
              ),
              rowSeparator,

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
          spacer,
        ];

      // Padding
      case LayoutSettingType.padding:
        return <Widget>[
          spacer,

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
                child: Text(l10n.gCurrently),
              ),
              rowSpacer,
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

          spacer,
        ];

      // Spacing
      case LayoutSettingType.spacing:
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
  }) {
    return <Widget>[
      // Preview
      Semantics(
        button: false,
        readOnly: true,
        label: l10n.gSetToValue(
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
                style: titleStyle,
                textAlign: TextAlign.center,
              ),

              // Preview
              ..._buildPreview(context),
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
              EzConfig.remove(widget.configKey);
            } else {
              EzConfig.setDouble(widget.configKey, value);
            }
          },

          // Slider semantics
          semanticFormatterCallback: (double value) =>
              value.toStringAsFixed(widget.decimals),
        ),
      ),
      spacer,

      // Reset button
      ElevatedButton.icon(
        onPressed: () {
          EzConfig.remove(widget.configKey);
          setModalState(() {
            currValue = _defaultValue;
          });
        },
        icon: Icon(PlatformIcons(context).refresh),
        label: Text(
          '${l10n.gReset} ${_defaultValue.toStringAsFixed(widget.decimals)}',
        ),
      ),
      spacer,
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
              ),
            );
          },
        ),
      ),
      icon: widget.type.icon,
      label: Text(label),
    );
  }
}
