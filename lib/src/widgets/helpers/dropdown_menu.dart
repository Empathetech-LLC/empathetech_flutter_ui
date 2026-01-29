/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EzDropdownMenu<T> extends StatelessWidget {
  /// [DropdownMenu.enabled] passthrough
  final bool enabled;

  /// [DropdownMenu.width] passthrough
  final double? width;

  /// Will set [width] to [ezDropdownWidth] of [widthEntries]
  final List<String>? widthEntries;

  /// Optional [IconButton.iconSize] override
  final double? iconSize;

  /// [DropdownMenu.menuHeight] passthrough
  final double? menuHeight;

  /// [DropdownMenu.leadingIcon] passthrough
  final Widget? leadingIcon;

  /// [DropdownMenu.trailingIcon] passthrough
  final Widget? trailingIcon;

  /// [DropdownMenu.label] passthrough
  final Widget? label;

  /// [DropdownMenu.hintText] passthrough
  final String? hintText;

  /// [DropdownMenu.helperText] passthrough
  final String? helperText;

  /// [DropdownMenu.errorText] passthrough
  final String? errorText;

  /// [DropdownMenu.selectedTrailingIcon] passthrough
  final Widget? selectedTrailingIcon;

  /// [DropdownMenu.enableFilter] passthrough
  final bool enableFilter;

  /// [DropdownMenu.enableSearch] passthrough
  final bool enableSearch;

  /// [DropdownMenu.keyboardType] passthrough
  final TextInputType? keyboardType;

  /// [DropdownMenu.textStyle] passthrough
  final TextStyle? textStyle;

  /// [DropdownMenu.textAlign] passthrough
  final TextAlign textAlign;

  /// [DropdownMenu.inputDecorationTheme] passthrough
  final InputDecorationTheme? inputDecorationTheme;

  /// [DropdownMenu.menuStyle] passthrough
  final MenuStyle? menuStyle;

  /// [DropdownMenu.controller] passthrough
  final TextEditingController? controller;

  /// [DropdownMenu.initialSelection] passthrough
  final T? initialSelection;

  /// [DropdownMenu.onSelected] passthrough
  final ValueChanged<T?>? onSelected;

  /// [DropdownMenu.focusNode] passthrough
  final FocusNode? focusNode;

  /// [DropdownMenu.requestFocusOnTap] passthrough
  final bool? requestFocusOnTap;

  /// [DropdownMenu.expandedInsets] passthrough
  final EdgeInsetsGeometry? expandedInsets;

  /// [DropdownMenu.filterCallback] passthrough
  final FilterCallback<T>? filterCallback;

  /// [DropdownMenu.searchCallback] passthrough
  final SearchCallback<T>? searchCallback;

  /// [DropdownMenu.alignmentOffset] passthrough
  final Offset? alignmentOffset;

  /// [DropdownMenu.dropdownMenuEntries] passthrough
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;

  /// [DropdownMenu.inputFormatters] passthrough
  final List<TextInputFormatter>? inputFormatters;

  /// [DropdownMenu] with custom styling
  const EzDropdownMenu({
    super.key,
    this.focusNode,
    this.enabled = true,
    this.width,
    this.widthEntries,
    this.iconSize,
    this.menuHeight,
    this.leadingIcon,
    this.trailingIcon,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.selectedTrailingIcon,
    this.enableFilter = false,
    this.enableSearch = true,
    this.keyboardType,
    this.textStyle,
    this.textAlign = TextAlign.start,
    this.inputDecorationTheme,
    this.menuStyle,
    this.controller,
    this.initialSelection,
    this.onSelected,
    this.requestFocusOnTap,
    this.expandedInsets,
    this.filterCallback,
    this.searchCallback,
    this.alignmentOffset,
    required this.dropdownMenuEntries,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    final double iSize = iconSize ?? EzConfig.iconSize;

    late final double buttonOpacity = EzConfig.get(
        EzConfig.isDark ? darkButtonOpacityKey : lightButtonOpacityKey);

    late final Color buttonBackground = buttonOpacity < 1.0
        ? (buttonOpacity < 0.01)
            ? Colors.transparent
            : EzConfig.colors.surface.withValues(alpha: buttonOpacity)
        : EzConfig.colors.surface;

    return IconButtonTheme(
      data: IconButtonThemeData(
        style: IconButton.styleFrom(
          backgroundColor: buttonBackground,
          iconSize: iSize,
        ),
      ),
      child: DropdownMenu<T>(
        key: key,
        enabled: enabled,
        width: width ??
            (widthEntries == null
                ? null
                : ezDropdownWidth(context: context, entries: widthEntries!)),
        menuHeight: menuHeight,
        leadingIcon: leadingIcon,
        trailingIcon: trailingIcon ?? Icon(Icons.arrow_drop_down, size: iSize),
        label: label,
        hintText: hintText,
        helperText: helperText,
        errorText: errorText,
        selectedTrailingIcon:
            selectedTrailingIcon ?? Icon(Icons.arrow_drop_up, size: iSize),
        enableFilter: enableFilter,
        enableSearch: enableSearch,
        keyboardType: keyboardType,
        textStyle: textStyle,
        textAlign: textAlign,
        inputDecorationTheme: inputDecorationTheme,
        menuStyle: menuStyle,
        controller: controller,
        initialSelection: initialSelection,
        onSelected: onSelected,
        focusNode: focusNode,
        requestFocusOnTap: requestFocusOnTap,
        expandedInsets: expandedInsets,
        filterCallback: filterCallback,
        searchCallback: searchCallback,
        alignmentOffset: alignmentOffset,
        dropdownMenuEntries: dropdownMenuEntries,
        inputFormatters: inputFormatters,
      ),
    );
  }
}
