/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
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
  }) : super(size: EzConfig.iconSize);
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

  /// Uses disabled styling and sets [onPressed] and [onLongPress] to [doNothing] when false
  /// Overriding [style] makes [enabled] moot
  final bool enabled;

  /// Switches to disabled styling when false
  /// [onPressed] is unchanged
  /// Overriding [style] makes [enabled] moot
  final bool fauxDisabled;

  /// [IconButton.isSelected] passthrough
  final bool? isSelected;

  /// [IconButton.selectedIcon] passthrough
  final Widget? selectedIcon;

  /// [IconButton.icon] passthrough
  final Widget icon;

  /// [IconButton] wrapper with custom styling
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
    this.fauxDisabled = false,
    this.isSelected,
    this.selectedIcon,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final double iSize = iconSize ?? EzConfig.iconSize;

    late final double buttonOpacity = EzConfig.get(
        EzConfig.isDark ? darkButtonOpacityKey : lightButtonOpacityKey);
    late final double outlineOpacity = EzConfig.get(EzConfig.isDark
        ? darkButtonOutlineOpacityKey
        : lightButtonOutlineOpacityKey);

    late final bool calcButton = buttonOpacity < 1.0;
    late final bool calcOutline = outlineOpacity < 1.0;

    late final bool clearButton = buttonOpacity < 0.01;
    late final bool clearOutline = outlineOpacity < 0.01;

    late final Color buttonBackground = calcButton
        ? clearButton
            ? Colors.transparent
            : EzConfig.colors.surface.withValues(alpha: buttonOpacity)
        : EzConfig.colors.surface;
    late final Color enabledOutline = calcOutline
        ? clearOutline
            ? Colors.transparent
            : EzConfig.colors.primaryContainer.withValues(alpha: outlineOpacity)
        : EzConfig.colors.primaryContainer;
    late final Color disabledOutline = calcOutline
        ? clearOutline
            ? Colors.transparent
            : EzConfig.colors.outlineVariant.withValues(alpha: outlineOpacity)
        : EzConfig.colors.outlineVariant;

    late final ButtonStyle buttonStyle = style ??
        ((enabled && !fauxDisabled)
            ? IconButton.styleFrom(
                backgroundColor: buttonBackground,
                side: BorderSide(color: enabledOutline),
                iconSize: iSize,
              )
            : IconButton.styleFrom(
                backgroundColor: buttonBackground,
                foregroundColor: EzConfig.colors.outline,
                overlayColor: EzConfig.colors.outline,
                shadowColor: Colors.transparent,
                side: BorderSide(color: disabledOutline),
                iconSize: iSize,
              ));

    return IconButton(
      iconSize: iSize,
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
