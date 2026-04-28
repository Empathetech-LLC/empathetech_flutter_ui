/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzIcon extends Icon {
  /// [Icon] wrapper that responds to [EzConfig.iconSize]
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
  /// Defaults to [EzConfig.iconSize]
  final double? iconSize;

  /// [IconButton.padding] passthrough
  final EdgeInsetsGeometry? padding;

  /// [IconButton.color] passthrough
  final Color? color;

  /// [IconButton.onPressed] passthrough
  final VoidCallback? onPressed;

  /// [IconButton.onLongPress] passthrough
  final VoidCallback? onLongPress;

  /// [IconButton.tooltip] passthrough
  final String? tooltip;

  /// [IconButton.constraints] passthrough
  final BoxConstraints? constraints;

  /// [IconButton.style] passthrough
  final ButtonStyle? style;

  /// Uses disabled styling and sets [onPressed] and [onLongPress] to [doNothing] when false
  /// Overriding [style] makes [enabled] moot
  final bool enabled;

  /// Switches to disabled styling when true
  /// [onPressed] is unchanged
  /// Overriding [style] makes [fauxDisabled] moot
  final bool fauxDisabled;

  /// [IconButton.icon] passthrough
  final Widget icon;

  /// [IconButton] wrapper with custom styling
  const EzIconButton({
    super.key,
    this.iconSize,
    this.padding,
    this.color,
    this.onPressed,
    this.onLongPress,
    this.tooltip,
    this.constraints,
    this.style,
    this.enabled = true,
    this.fauxDisabled = false,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final double iSize = iconSize ?? EzConfig.iconSize;

    late final Color buttonBackground =
        EzConfig.colors.surface.withValues(alpha: EzConfig.buttonOpacity);
    late final Color enabledOutline =
        EzConfig.colors.primaryContainer.withValues(alpha: EzConfig.borderOpacity);
    late final Color disabledOutline =
        EzConfig.colors.outlineVariant.withValues(alpha: EzConfig.borderOpacity);

    late final ButtonStyle buttonStyle = style ??
        ((enabled && !fauxDisabled)
            ? IconButton.styleFrom(
                backgroundColor: buttonBackground,
                side: EzConfig.borderSide(enabledOutline),
                iconSize: iSize,
              )
            : IconButton.styleFrom(
                backgroundColor: buttonBackground,
                foregroundColor: EzConfig.colors.outline,
                overlayColor: EzConfig.colors.outline,
                shadowColor: Colors.transparent,
                side: EzConfig.borderSide(disabledOutline),
                iconSize: iSize,
              ));

    return IconButton(
      iconSize: iSize,
      padding: padding,
      color: color,
      onPressed: enabled ? onPressed : doNothing,
      onLongPress: enabled ? onLongPress : doNothing,
      tooltip: tooltip,
      constraints: constraints,
      style: buttonStyle,
      icon: icon,
    );
  }
}
