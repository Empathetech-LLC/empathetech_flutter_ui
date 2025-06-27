/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzIcon extends Icon {
  /// [Icon] wrapper that responds to [EzConfig]s [iconSizeKey]
  /// [ThemeData.iconTheme] does not seem to be consumed properly at time of writing
  /// Jan 2025
  EzIcon(
    super.icon, {
    super.key,
    super.fill,
    super.weight,
    super.grade,
    super.opticalSize,
    super.color,
    super.shadows,
    super.semanticLabel,
    super.textDirection,
    super.applyTextScaling,
    super.blendMode,
  }) : super(size: EzConfig.get(iconSizeKey));
}

class EzIconButton extends StatelessWidget {
  /// [IconButton.iconSize] passthrough
  /// Defaults to [EzConfig.get]s [iconSizeKey]
  final double? iconSize;

  /// [IconButton.visualDensity] passthrough
  final VisualDensity? visualDensity;

  /// [IconButton.padding] passthrough
  final EdgeInsetsGeometry? padding;

  /// [IconButton.alignment] passthrough
  final AlignmentGeometry? alignment;

  /// [IconButton.splashRadius] passthrough
  final double? splashRadius;

  /// [IconButton.color] passthrough
  final Color? color;

  /// [IconButton.focusColor] passthrough
  final Color? focusColor;

  /// [IconButton.hoverColor] passthrough
  final Color? hoverColor;

  /// [IconButton.highlightColor] passthrough
  final Color? highlightColor;

  /// [IconButton.splashColor] passthrough
  final Color? splashColor;

  /// [IconButton.disabledColor] passthrough
  final Color? disabledColor;

  /// [IconButton.onPressed] passthrough
  final VoidCallback? onPressed;

  /// [IconButton.onLongPress] passthrough
  final VoidCallback? onLongPress;

  /// [IconButton.mouseCursor] passthrough
  final MouseCursor? mouseCursor;

  /// [IconButton.focusNode] passthrough
  final FocusNode? focusNode;

  /// [IconButton.autofocus] passthrough
  final bool autofocus;

  /// [IconButton.tooltip] passthrough
  final String? tooltip;

  /// [IconButton.enableFeedback] passthrough
  final bool? enableFeedback;

  /// [IconButton.constraints] passthrough
  final BoxConstraints? constraints;

  /// [IconButton.style] passthrough
  final ButtonStyle? style;

  /// Updates [style] to be grey when false
  /// Overriding [style] makes [enabled] moot
  final bool enabled;

  /// [IconButton.isSelected] passthrough
  final bool? isSelected;

  /// [IconButton.selectedIcon] passthrough
  final Widget? selectedIcon;

  /// [IconButton.icon] passthrough
  final Widget icon;

  /// [IconButton] wrapper with custom styling
  /// All [AppBar] IconButtons use [ThemeData.iconButtonTheme] for styling... and are super annoying to overwrite
  /// But, IMO [AppBar] IconButtons and "regular" ones shouldn't behave the same
  /// So, it's recommended to use regular [IconButton]s in the [AppBar] and [EzIconButton]s everywhere else
  const EzIconButton({
    super.key,
    this.iconSize,
    this.visualDensity,
    this.padding,
    this.alignment,
    this.splashRadius,
    this.color,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.disabledColor,
    this.onPressed,
    this.onLongPress,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
    this.tooltip,
    this.enableFeedback,
    this.constraints,
    this.style,
    this.enabled = true,
    this.isSelected,
    this.selectedIcon,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    late final double savedIconSized = EzConfig.get(iconSizeKey);

    late final ButtonStyle buttonStyle = style ??
        (enabled
            ? IconButton.styleFrom(
                backgroundColor: colorScheme.surface,
                foregroundColor: colorScheme.primary,
                overlayColor: colorScheme.primary,
                side: BorderSide(color: colorScheme.primaryContainer),
                iconSize: iconSize ?? savedIconSized,
                alignment: Alignment.center,
                padding: EzInsets.wrap(EzConfig.get(paddingKey)),
              )
            : IconButton.styleFrom(
                backgroundColor: colorScheme.surface,
                foregroundColor: colorScheme.outline,
                overlayColor: colorScheme.outline,
                shadowColor: Colors.transparent,
                side: BorderSide(color: colorScheme.outlineVariant),
                iconSize: iconSize ?? savedIconSized,
                alignment: Alignment.center,
                padding: EzInsets.wrap(EzConfig.get(paddingKey)),
              ));

    return IconButton(
      iconSize: iconSize ?? savedIconSized,
      visualDensity: visualDensity,
      padding: padding,
      alignment: alignment,
      splashRadius: splashRadius,
      color: color,
      focusColor: focusColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      splashColor: splashColor,
      disabledColor: disabledColor,
      onPressed: enabled ? onPressed : doNothing,
      onLongPress: enabled ? onLongPress : doNothing,
      mouseCursor: mouseCursor,
      focusNode: focusNode,
      autofocus: autofocus,
      tooltip: tooltip,
      enableFeedback: enableFeedback,
      constraints: constraints,
      style: buttonStyle,
      isSelected: isSelected,
      selectedIcon: selectedIcon,
      icon: icon,
    );
  }
}
