library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Enumerator for selecting the type of setting that is being updated
/// This will determine the preview [Widget]s
enum SettingType {
  fontScalar,
  margin,
  padding,
  buttonHeight,
  buttonSpacing,
  paragraphSpacing,
}

class EzSliderSetting extends StatefulWidget {
  /// The [EzConfig.prefs] key whose value is being updated
  final String prefsKey;

  /// Custom enum for determining the preview widget's required
  final SettingType type;

  /// [String] that will be displayed above the [Slider]
  final String title;

  /// Smallest value that can be set
  final double min;

  /// Largest value that can be set
  final double max;

  /// Number of divisions between [min] and [max]
  final int steps;

  /// Creates a tool for updating any [prefsKey] value that would pair well with a [PlatformSlider]
  /// Use the [type] enum for generating the appropriate preview [Widget]s
  EzSliderSetting({
    Key? key,
    required this.prefsKey,
    required this.type,
    required this.title,
    required this.min,
    required this.max,
    required this.steps,
  }) : super(key: key);

  @override
  _SliderSettingState createState() => _SliderSettingState();
}

class _SliderSettingState extends State<EzSliderSetting> {
  late double currValue = EzConfig.prefs[widget.prefsKey];
  late double defaultValue = EzConfig.defaults[widget.prefsKey];

  late double padding = EzConfig.prefs[paddingKey];
  late double margin = EzConfig.prefs[marginKey];
  late double buttonSpacer = EzConfig.prefs[buttonSpacingKey];
  late double paragraphSpacer = EzConfig.prefs[paragraphSpacingKey];

  late TextStyle? titleStyle = headlineSmall(context);
  late TextStyle? descriptorStyle = titleMedium(context);

  /// Return the preview [Widget]s for the passed [SettingType]
  List<Widget> _buildPreview() {
    switch (widget.type) {
      // Font size
      case SettingType.fontScalar:
        return [
          // Title padding
          Container(height: padding),

          // Live preview && label
          EzSelectableText(
            'Currently: $currValue',
            style: descriptorStyle?.copyWith(
              fontSize: descriptorStyle!.fontSize! * currValue,
            ),
          ),
          Container(height: buttonSpacer),
        ];

      // Margin
      case SettingType.margin:
        double marginScale = 90.0 / widthOf(context);
        double liveMargin = currValue * marginScale;

        return [
          // Title padding
          Container(height: padding),

          EzScrollView(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            scrollDirection: Axis.horizontal,
            children: [
              // Live label
              EzSelectableText(
                'Currently:\n$currValue\n\n(to scale)',
                style: descriptorStyle,
              ),
              Container(width: paragraphSpacer),

              // Live preview
              Container(
                color: Theme.of(context).appBarTheme.backgroundColor,
                height: 160.0,
                width: 90.0,
                child: Container(
                  color: Theme.of(context).appBarTheme.titleTextStyle?.color,
                  margin: EdgeInsets.all(liveMargin),
                ),
              ),
            ],
          ),
          Container(height: buttonSpacer),
        ];

      // Padding
      case SettingType.padding:
        return [
          // Live preview
          Container(height: currValue),

          // Live label
          ElevatedButton(
            onPressed: doNothing,
            child: Text('Currently: $currValue'),
          ),
          Container(height: buttonSpacer),
        ];

      // Button height
      case SettingType.buttonHeight:
        return [
          // Title padding
          Container(height: padding),

          // Live preview && label
          ElevatedButton(
            onPressed: doNothing,
            child: Text('Currently: $currValue'),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(widthOf(context), currValue),
            ),
          ),
          Container(height: buttonSpacer),
        ];

      // Button spacing
      case SettingType.buttonSpacing:
        return [
          // Title padding
          Container(height: padding),

          // Live preview && label
          EzScrollView(
            children: [
              ElevatedButton(
                onPressed: doNothing,
                child: Text('Currently: $currValue'),
              ),
              SizedBox(height: currValue),
              ElevatedButton(
                onPressed: doNothing,
                child: Text('Currently: $currValue'),
              ),
              SizedBox(height: buttonSpacer),
            ],
          ),
        ];

      // Paragraph spacing
      case SettingType.paragraphSpacing:
        return [
          // Title padding
          Container(height: padding),

          // Live preview && label
          EzScrollView(
            children: [
              EzSelectableText('Currently: $currValue', style: descriptorStyle),
              SizedBox(height: currValue),
              EzSelectableText('Currently: $currValue', style: descriptorStyle),
              SizedBox(height: buttonSpacer),
            ],
          ),
        ];

      default:
        return [Container(height: buttonSpacer)];
    }
  }

  /// Assemble the final list of widgets to build for [_SliderSettingState]
  /// [widget.title] + [_buildPreview] + [PlatformSlider] + reset [ElevatedButton.icon]
  List<Widget> _buildView(StateSetter modalSheetSetState) {
    List<Widget> toReturn = [
      Container(height: margin),
      EzSelectableText(widget.title, style: titleStyle),
    ];

    toReturn.addAll(_buildPreview());

    toReturn.addAll([
      // Value slider
      ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 700, // Chosen via visual inspection
        ),
        child: PlatformSlider(
          // Function
          value: currValue,

          min: widget.min,
          max: widget.max,

          onChanged: (double value) {
            // Just update the on screen value while sliding around
            modalSheetSetState(() {
              currValue = value;
            });
          },
          onChangeEnd: (double value) {
            // When finished, write the result
            if (value == defaultValue) {
              EzConfig.preferences.remove(widget.prefsKey);
            } else {
              EzConfig.preferences.setDouble(widget.prefsKey, value);
            }
          },

          // Form
          divisions: widget.steps,
        ),
      ),
      Container(height: buttonSpacer),

      // Reset button
      ElevatedButton.icon(
        onPressed: () {
          EzConfig.preferences.remove(widget.prefsKey);
          modalSheetSetState(() {
            currValue = EzConfig.defaults[widget.prefsKey];
          });
        },
        icon: Icon(PlatformIcons(context).refresh),
        label: Text('Reset: ' + EzConfig.defaults[widget.prefsKey].toString()),
      ),
      Container(height: margin),
    ]);

    // Build time!
    return toReturn;
  }

  Icon _buildIcon() {
    switch (widget.type) {
      case SettingType.fontScalar:
        return Icon(LineIcons.textHeight);
      case SettingType.margin:
        return Icon(Icons.margin);
      case SettingType.padding:
        return Icon(Icons.padding);
      case SettingType.buttonHeight:
        return Icon(Icons.height);
      case SettingType.buttonSpacing:
      case SettingType.paragraphSpacing:
        return Icon(Icons.space_bar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => showPlatformModalSheet(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter modalSheetSetState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: _buildView(modalSheetSetState),
            );
          },
        ),
      ),
      icon: _buildIcon(),
      label: Text(widget.title),
    );
  }
}
