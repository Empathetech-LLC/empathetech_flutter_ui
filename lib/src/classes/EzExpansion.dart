library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzExpansion extends ExpansionTile {
  /// Styles an [ExpansionTile] with [EzConfig]
  EzExpansion({
    Key? key,
    Widget? leading,
    required Widget title,
    Widget? subtitle,
    void Function(bool)? onExpansionChanged,
    required List<Widget> children,
    Widget? trailing,
    bool initiallyExpanded = false,
    bool maintainState = false,
    EdgeInsetsGeometry? tilePadding,
    CrossAxisAlignment? expandedCrossAxisAlignment,
    Alignment? expandedAlignment,
    EdgeInsetsGeometry? childrenPadding,
    Color? backgroundColor,
    Color? collapsedBackgroundColor,
    Color? textColor,
    Color? collapsedTextColor,
    Color? iconColor,
    Color? collapsedIconColor,
    ShapeBorder? shape,
    ShapeBorder? collapsedShape,
    Clip? clipBehavior,
    ListTileControlAffinity? controlAffinity,
  }) : super(
          key: key,
          leading: leading,
          title: title,
          subtitle: subtitle,
          onExpansionChanged: onExpansionChanged ?? (_) => closeFocus(),
          children: children,
          trailing: trailing,
          initiallyExpanded: initiallyExpanded,
          maintainState: maintainState,
          tilePadding: tilePadding ?? EdgeInsets.all(EzConfig.prefs[paddingKey]),
          expandedCrossAxisAlignment: expandedCrossAxisAlignment,
          expandedAlignment: expandedAlignment,
          childrenPadding: childrenPadding ??
              EdgeInsets.only(
                  left: EzConfig.prefs[paddingKey], right: EzConfig.prefs[paddingKey]),
          backgroundColor: backgroundColor ?? Color(EzConfig.prefs[themeColorKey]),
          collapsedBackgroundColor:
              collapsedBackgroundColor ?? Color(EzConfig.prefs[themeColorKey]),
          textColor: textColor ?? Color(EzConfig.prefs[themeTextColorKey]),
          collapsedTextColor:
              collapsedTextColor ?? Color(EzConfig.prefs[themeTextColorKey]),
          iconColor: iconColor ?? Color(EzConfig.prefs[themeTextColorKey]),
          collapsedIconColor:
              collapsedIconColor ?? Color(EzConfig.prefs[themeTextColorKey]),
          shape: shape,
          collapsedShape: collapsedShape,
          clipBehavior: clipBehavior,
          controlAffinity: controlAffinity,
        );
}
