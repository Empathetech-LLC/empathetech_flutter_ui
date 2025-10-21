/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Enumerator for selecting which piece of the layout is being updated
/// This will determine the preview [Widget]s
enum EzLayoutSettingType { margin, padding, spacing }

/// Get human readable name for [settingType]
String ezLstName(BuildContext context, EzLayoutSettingType settingType) {
  switch (settingType) {
    case EzLayoutSettingType.margin:
      return ezL10n(context).lsMargin;
    case EzLayoutSettingType.padding:
      return ezL10n(context).lsPadding;
    case EzLayoutSettingType.spacing:
      return ezL10n(context).lsSpacing;
  }
}

/// Get the [Icon] for [settingType]
Icon ezLstIcon(EzLayoutSettingType settingType) {
  switch (settingType) {
    case EzLayoutSettingType.margin:
      return EzIcon(Icons.margin);
    case EzLayoutSettingType.padding:
      return EzIcon(Icons.padding);
    case EzLayoutSettingType.spacing:
      return EzIcon(Icons.space_bar);
  }
}

class EzLayoutSetting extends StatefulWidget {
  /// The [EzConfig] key whose value is being updated
  final String configKey;

  /// enum for determining the preview Widget(s)
  final EzLayoutSettingType type;

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

  /// Standardized [EzElevatedIconButton] for updating layout values in [EzConfig]
  /// Supports all [EzLayoutSettingType]s
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
  // Gather the fixed theme data //

  late double currValue = EzConfig.get(widget.configKey);
  late final double defaultValue = EzConfig.getDefault(widget.configKey);

  late final String label = ezLstName(context, widget.type);

  late final EFUILang l10n = ezL10n(context);

  // Define build functions //

  /// Return the preview Widget(s) for the passed [EzLayoutSettingType]
  List<Widget> buildPreview(BuildContext context, ThemeData theme) {
    final String valString = currValue.toStringAsFixed(widget.decimals);

    switch (widget.type) {
      // Margin
      case EzLayoutSettingType.margin:
        late final bool isDark = isDarkTheme(context);

        late final String? backgroundImagePath = EzConfig.get(
            isDark ? darkBackgroundImageKey : lightBackgroundImageKey);

        late final BoxFit? backgroundImageFit = ezFitFromName(isDark
            ? EzConfig.get('$darkBackgroundImageKey$boxFitSuffix')
            : EzConfig.get('$lightBackgroundImageKey$boxFitSuffix'));

        return <Widget>[
          ezSpacer,
          EzTextBackground(
            Text(
              valString,
              style: widget.bodyStyle ??
                  theme.textTheme.bodyLarge
                      ?.copyWith(color: theme.colorScheme.surface),
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
                        image: ezImageProvider(backgroundImagePath),
                        fit: backgroundImageFit,
                      ),
              ),
              margin: EdgeInsets.all(currValue * 0.25),
            ),
          ),
          ezSpacer,
        ];

      // Padding
      case EzLayoutSettingType.padding:
        return <Widget>[
          ezSpacer,

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
              ezRowSpacer,
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

          ezSpacer,
        ];

      // Spacing
      case EzLayoutSettingType.spacing:
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

  // Return the build //

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

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
                          style:
                              widget.titleStyle ?? theme.textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),

                        // Preview
                        ...buildPreview(context, theme),
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
                ezSpacer,

                // Reset button
                EzElevatedIconButton(
                  onPressed: () async {
                    await EzConfig.remove(widget.configKey);
                    setModal(() => currValue = defaultValue);
                  },
                  icon: EzIcon(PlatformIcons(context).refresh),
                  label:
                      '${l10n.gResetTo} ${defaultValue.toStringAsFixed(widget.decimals)}',
                ),
                EzSpacer(space: EzConfig.get(spacingKey) * 1.5),
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
