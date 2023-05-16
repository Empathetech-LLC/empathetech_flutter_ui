library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Enumerator for selecting the type of setting that is being updated
/// This will determine the preview [Widget]s
enum SettingType {
  buttonHeight,
  buttonSpacing,
  circleSize,
  margin,
  padding,
  paragraphSpacing,
}

class EzSliderSetting extends StatefulWidget {
  /// The [EzConfig] key whose value is being updated
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
  const EzSliderSetting({
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
  late double currValue = EzConfig.instance.prefs[widget.prefsKey];
  late double defaultValue = EzConfig.instance.defaults[widget.prefsKey];

  late double margin = EzConfig.instance.prefs[marginKey];
  late double padding = EzConfig.instance.prefs[paddingKey];
  late double buttonSpacer = EzConfig.instance.prefs[buttonSpacingKey];
  late double paragraphSpacer = EzConfig.instance.prefs[paragraphSpacingKey];

  late TextStyle? style = Theme.of(context).appBarTheme.titleTextStyle;

  /// Return the preview [Widget]s for the passed [SettingType]
  List<Widget> _buildPreview() {
    switch (widget.type) {
      // Button height
      case SettingType.buttonHeight:
        return [
          // Title padding
          EzSpacer(padding),

          // Live preview && label
          ElevatedButton(
            onPressed: doNothing,
            child: Text('Currently: ${currValue.truncate()}'),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(double.infinity, currValue),
            ),
          ),
          EzSpacer(buttonSpacer),
        ];

      // Button spacing
      case SettingType.buttonSpacing:
        return [
          // Title padding
          EzSpacer(padding),

          // Live preview && label
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: doNothing,
                child: Text('Currently: ${currValue.truncate()}'),
              ),
              EzSpacer(currValue),
              ElevatedButton(
                onPressed: doNothing,
                child: Text('Currently: ${currValue.truncate()}'),
              ),
              EzSpacer(buttonSpacer),
            ],
          ),
        ];

      // Circle size
      case SettingType.circleSize:
        return [
          // Title padding
          EzSpacer(padding),

          // Live preview && label
          ElevatedButton(
            onPressed: doNothing,
            child: Text(
              currValue.truncate().toString(),
            ),
            style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                  shape: MaterialStatePropertyAll(const CircleBorder()),
                  padding: MaterialStatePropertyAll(EdgeInsets.zero),
                  fixedSize:
                      MaterialStatePropertyAll(Size(currValue, currValue)),
                ),
          ),
          EzSpacer(buttonSpacer),
        ];

      // Margin
      case SettingType.margin:
        double marginScale = 90.0 / widthOf(context);
        double liveMargin = currValue * marginScale;

        return [
          // Title padding
          EzSpacer(padding),

          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Live label
              EzSelectableText(
                'Currently: ${currValue.truncate()}\n(to scale)',
                style: style,
                textScaleFactor: MediaQuery.of(context).textScaleFactor * 0.8,
              ),
              EzSpacer.row(paragraphSpacer),

              // Live preview
              Container(
                color: Theme.of(context).appBarTheme.titleTextStyle?.color,
                height: 160.0,
                width: 90.0,
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  margin: EdgeInsets.all(liveMargin),
                ),
              ),
            ],
          ),
          EzSpacer(buttonSpacer),
        ];

      // Padding
      case SettingType.padding:
        return [
          // Live preview
          EzSpacer(currValue),

          // Live label
          ElevatedButton(
            onPressed: doNothing,
            child: Text('Currently: ${currValue.truncate()}'),
          ),
          EzSpacer(buttonSpacer),
        ];

      // Paragraph spacing
      case SettingType.paragraphSpacing:
        return [
          // Title padding
          EzSpacer(padding),

          // Live preview && label
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Thing 1
              EzSelectableText(
                'Currently: ${currValue.truncate()}',
                style: style,
                textScaleFactor: MediaQuery.of(context).textScaleFactor * 0.8,
              ),
              SizedBox(height: currValue),

              // Thing 2
              EzSelectableText(
                'Currently: ${currValue.truncate()}',
                style: style,
                textScaleFactor: MediaQuery.of(context).textScaleFactor * 0.8,
              ),
              SizedBox(height: buttonSpacer),
            ],
          ),
        ];
    }
  }

  /// Assemble the final list of widgets to build for [_SliderSettingState]
  /// [widget.title] + [_buildPreview] + [PlatformSlider] + reset [ElevatedButton.icon]
  List<Widget> _buildView(StateSetter modalSheetSetState) {
    List<Widget> toReturn = [
      EzSpacer(margin),
      EzSelectableText(widget.title, style: style),
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
              EzConfig.instance.preferences.remove(widget.prefsKey);
            } else {
              EzConfig.instance.preferences.setDouble(widget.prefsKey, value);
            }
          },

          // Form
          divisions: widget.steps,
        ),
      ),
      EzSpacer(buttonSpacer),

      // Reset button
      ElevatedButton.icon(
        onPressed: () {
          EzConfig.instance.preferences.remove(widget.prefsKey);
          modalSheetSetState(() {
            currValue = EzConfig.instance.defaults[widget.prefsKey];
          });
        },
        icon: Icon(PlatformIcons(context).refresh),
        label: Text(
            'Reset: ' + EzConfig.instance.defaults[widget.prefsKey].toString()),
      ),
      EzSpacer(margin),
    ]);

    // Build time!
    return toReturn;
  }

  Icon _buildIcon() {
    switch (widget.type) {
      case SettingType.buttonHeight:
        return const Icon(Icons.height);

      case SettingType.buttonSpacing:
        return const Icon(Icons.space_bar);

      case SettingType.circleSize:
        return const Icon(Icons.circle);

      case SettingType.margin:
        return const Icon(Icons.margin);

      case SettingType.padding:
        return const Icon(Icons.padding);

      case SettingType.paragraphSpacing:
        return const Icon(Icons.space_bar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => showPlatformModalSheet(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter modalSheetSetState) {
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _buildView(modalSheetSetState),
                ),
                Positioned(
                  top: margin,
                  right: margin,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => popScreen(context: context),
                      child: Text('X', style: style),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        material: MaterialModalSheetData(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        ),
        cupertino: CupertinoModalSheetData(),
      ),
      icon: _buildIcon(),
      label: Text(widget.title),
    );
  }
}
