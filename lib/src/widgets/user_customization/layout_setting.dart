/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Enumerator for selecting which piece of the layout is being updated
/// This will determine the preview [Widget]s
enum LayoutSettingType { margin, padding, spacing }

/// Get the proper [String] name for [LayoutSettingType]
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
Icon lstIcon(LayoutSettingType settingType) {
  switch (settingType) {
    case LayoutSettingType.margin:
      return EzIcon(Icons.margin);
    case LayoutSettingType.padding:
      return EzIcon(Icons.padding);
    case LayoutSettingType.spacing:
      return EzIcon(Icons.space_bar);
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

  /// Defaults to [TextTheme.titleLarge]
  final TextStyle? titleStyle;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? bodyStyle;

  /// Standardized [Widget] for updating layout values in [EzConfig]
  /// Supports all [LayoutSettingType]s
  const EzLayoutSetting({
    super.key,
    required this.configKey,
    required this.type,
    required this.min,
    required this.max,
    required this.steps,
    required this.decimals,
    this.titleStyle,
    this.bodyStyle,
  });

  @override
  State<EzLayoutSetting> createState() => _LayoutSettingState();
}

class _LayoutSettingState extends State<EzLayoutSetting> {
  // Gather the theme data //

  late double currValue = EzConfig.get(widget.configKey);
  late final double defaultValue = EzConfig.getDefault(widget.configKey);

  late final String label = lstName(context, widget.type);

  static const EzSpacer spacer = EzSpacer();

  late final ThemeData theme = Theme.of(context);

  late final TextStyle? titleStyle =
      widget.titleStyle ?? theme.textTheme.titleLarge;
  late final TextStyle? bodyStyle =
      widget.bodyStyle ?? theme.textTheme.bodyLarge;

  late final EFUILang l10n = EFUILang.of(context)!;

  // Define build functions //

  /// Return the preview Widget(s) for the passed [LayoutSettingType]
  List<Widget> _buildPreview(BuildContext context) {
    final String valString = currValue.toStringAsFixed(widget.decimals);

    switch (widget.type) {
      // Margin
      case LayoutSettingType.margin:
        late final String? backgroundImagePath = EzConfig.get(
            isDarkTheme(context)
                ? darkBackgroundImageKey
                : lightBackgroundImageKey);

        return <Widget>[
          spacer,
          EzTextBackground(
            Text(
              valString,
              style: bodyStyle?.copyWith(color: theme.colorScheme.surface),
              textAlign: TextAlign.center,
            ),
            margin: EzInsets.wrap(currValue),
            backgroundColor: theme.colorScheme.onSurface,
          ),
          EzSpacer(space: currValue),
          Container(
            color: theme.colorScheme.onSurface,
            height: heightOf(context) * 0.25,
            width: widthOf(context) * 0.25,
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                image: (backgroundImagePath == null ||
                        backgroundImagePath == noImageValue)
                    ? null
                    : DecorationImage(
                        image: provideImage(backgroundImagePath),
                        fit: BoxFit.fill,
                      ),
              ),
              margin: EdgeInsets.all(currValue * 0.25),
            ),
          ),
          spacer,
        ];

      // Padding
      case LayoutSettingType.padding:
        return <Widget>[
          spacer,

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
                text: l10n.gCurrently,
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

          spacer,
        ];

      // Spacing
      case LayoutSettingType.spacing:
        return <Widget>[
          // Preview 1
          EzSpacer(space: currValue),

          // Label
          EzScrollView(
            mainAxisSize: MainAxisSize.min,
            scrollDirection: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              EzElevatedButton(enabled: false, text: l10n.gCurrently),
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

  /// [widget.title] + [_buildPreview] + [PlatformSlider] + reset [EzElevatedIconButton]
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
        constraints: const BoxConstraints(maxWidth: smallBreakpoint),
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
          onChangeEnd: (double value) async {
            await EzConfig.setDouble(widget.configKey, value);
          },

          // Slider semantics
          semanticFormatterCallback: (double value) =>
              value.toStringAsFixed(widget.decimals),
        ),
      ),
      spacer,

      // Reset button
      EzElevatedIconButton(
        onPressed: () async {
          await EzConfig.remove(widget.configKey);
          setModalState(() {
            currValue = defaultValue;
          });
        },
        icon: EzIcon(PlatformIcons(context).refresh),
        label:
            '${l10n.gResetTo} ${defaultValue.toStringAsFixed(widget.decimals)}',
      ),
      spacer,
    ];
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return EzElevatedIconButton(
      onPressed: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => StatefulBuilder(
          builder: (_, StateSetter setModalState) {
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
      icon: lstIcon(widget.type),
      label: label,
    );
  }
}
