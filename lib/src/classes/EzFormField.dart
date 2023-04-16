library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzFormField extends StatelessWidget {
  final Key? key;
  final Key? widgetKey;

  /// Default:
  /// BoxDecoration(
  ///   border: Border.all(color: buttonColor),
  ///   color: themeColor.withOpacity(themeColor.opacity * 0.75),
  /// )
  final Decoration? decoration;

  final TextEditingController? controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;

  /// Default:
  /// [TextCapitalization.none]
  final TextCapitalization? textCapitalization;

  final TextInputAction? textInputAction;
  final TextStyle? style;
  final StrutStyle? strutStyle;

  /// Default:
  /// [TextAlign.center]
  final TextAlign? textAlign;

  final TextAlignVertical? textAlignVertical;
  final bool? autofocus;
  final bool? readOnly;
  final bool? showCursor;
  final String? obscuringCharacter;
  final bool? obscureText;
  final bool? autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool? enableSuggestions;

  /// Default: 1
  final int? maxLines;

  final int? minLines;
  final bool? expands;
  final int? maxLength;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final bool? enabled;
  final double? cursorWidth;
  final double? cursorHeight;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final EdgeInsets? scrollPadding;
  final bool? enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final ScrollPhysics? scrollPhysics;
  final Iterable<String>? autofillHints;
  final AutovalidateMode? autovalidateMode;
  final Widget Function(BuildContext, EditableTextState)? contextMenuBuilder;
  final String? hintText;
  final MaterialTextFormFieldData Function(BuildContext, PlatformTarget)? material;
  final CupertinoTextFormFieldData Function(BuildContext, PlatformTarget)? cupertino;

  /// Wraps a [PlatformTextFormField] in a decorated [Container] to improve readability
  EzFormField({
    this.key,
    this.widgetKey,
    this.decoration,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.center,
    this.textAlignVertical,
    this.autofocus,
    this.readOnly,
    this.showCursor,
    this.obscuringCharacter,
    this.obscureText,
    this.autocorrect,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions,
    this.maxLines = 1,
    this.minLines,
    this.expands,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.enabled,
    this.cursorWidth,
    this.cursorHeight,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding,
    this.enableInteractiveSelection,
    this.selectionControls,
    this.scrollPhysics,
    this.autofillHints,
    this.autovalidateMode,
    this.contextMenuBuilder,
    this.hintText,
    this.material,
    this.cupertino,
  });

  @override
  Widget build(BuildContext context) {
    // Gather theme data
    Color buttonColor = Color(EzConfig.prefs[buttonColorKey]);
    Color themeColor = Color(EzConfig.prefs[themeColorKey]);
    Color themeTextColor = Color(EzConfig.prefs[themeTextColorKey]);

    return Container(
      decoration: decoration ??
          BoxDecoration(
            border: Border.all(color: buttonColor),
            color: themeColor.withOpacity(themeColor.opacity * 0.75),
          ),
      child: PlatformTextFormField(
        key: widgetKey,
        controller: controller,
        initialValue: initialValue,
        focusNode: focusNode,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        textInputAction: textInputAction,
        style: style ?? buildTextStyle(styleKey: dialogContentStyleKey),
        strutStyle: strutStyle,
        textAlign: textAlign,
        textAlignVertical: textAlignVertical,
        autofocus: autofocus,
        readOnly: readOnly,
        showCursor: showCursor,
        obscuringCharacter: obscuringCharacter,
        obscureText: obscureText,
        autocorrect: autocorrect,
        smartDashesType: smartDashesType,
        smartQuotesType: smartQuotesType,
        enableSuggestions: enableSuggestions,
        maxLines: maxLines,
        minLines: minLines,
        expands: expands,
        maxLength: maxLength,
        onChanged: onChanged,
        onTap: onTap,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onFieldSubmitted,
        onSaved: onSaved,
        validator: validator,
        enabled: enabled,
        cursorWidth: cursorWidth,
        cursorHeight: cursorHeight,
        cursorColor: cursorColor ?? themeTextColor,
        keyboardAppearance: keyboardAppearance,
        scrollPadding: scrollPadding,
        enableInteractiveSelection: enableInteractiveSelection,
        selectionControls: selectionControls,
        scrollPhysics: scrollPhysics,
        autofillHints: autofillHints,
        autovalidateMode: autovalidateMode,
        contextMenuBuilder: contextMenuBuilder,
        hintText: hintText,
        material: material,
        cupertino: cupertino,
      ),
    );
  }
}
