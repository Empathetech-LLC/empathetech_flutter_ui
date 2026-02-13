/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Enumerator for selecting which [TextStyle] is being updated
enum EzTextSettingType { display, headline, title, body, label }

extension EzTSTConfig on EzTextSettingType {
  // Bold/weight //

  String get boldKey {
    switch (this) {
      case EzTextSettingType.display:
        return EzConfig.isDark ? darkDisplayBoldedKey : lightDisplayBoldedKey;
      case EzTextSettingType.headline:
        return EzConfig.isDark ? darkHeadlineBoldedKey : lightHeadlineBoldedKey;
      case EzTextSettingType.title:
        return EzConfig.isDark ? darkTitleBoldedKey : lightTitleBoldedKey;
      case EzTextSettingType.body:
        return EzConfig.isDark ? darkBodyBoldedKey : lightBodyBoldedKey;
      case EzTextSettingType.label:
        return EzConfig.isDark ? darkLabelBoldedKey : lightLabelBoldedKey;
    }
  }

  String get boldMirror {
    switch (this) {
      case EzTextSettingType.display:
        return EzConfig.isDark ? lightDisplayBoldedKey : darkDisplayBoldedKey;
      case EzTextSettingType.headline:
        return EzConfig.isDark ? lightHeadlineBoldedKey : darkHeadlineBoldedKey;
      case EzTextSettingType.title:
        return EzConfig.isDark ? lightTitleBoldedKey : darkTitleBoldedKey;
      case EzTextSettingType.body:
        return EzConfig.isDark ? lightBodyBoldedKey : darkBodyBoldedKey;
      case EzTextSettingType.label:
        return EzConfig.isDark ? lightLabelBoldedKey : darkLabelBoldedKey;
    }
  }

  // Font family //

  String get fontKey {
    switch (this) {
      case EzTextSettingType.display:
        return EzConfig.isDark
            ? darkDisplayFontFamilyKey
            : lightDisplayFontFamilyKey;
      case EzTextSettingType.headline:
        return EzConfig.isDark
            ? darkHeadlineFontFamilyKey
            : lightHeadlineFontFamilyKey;
      case EzTextSettingType.title:
        return EzConfig.isDark
            ? darkTitleFontFamilyKey
            : lightTitleFontFamilyKey;
      case EzTextSettingType.body:
        return EzConfig.isDark ? darkBodyFontFamilyKey : lightBodyFontFamilyKey;
      case EzTextSettingType.label:
        return EzConfig.isDark
            ? darkLabelFontFamilyKey
            : lightLabelFontFamilyKey;
    }
  }

  String get fontMirror {
    switch (this) {
      case EzTextSettingType.display:
        return EzConfig.isDark
            ? lightDisplayFontFamilyKey
            : darkDisplayFontFamilyKey;
      case EzTextSettingType.headline:
        return EzConfig.isDark
            ? lightHeadlineFontFamilyKey
            : darkHeadlineFontFamilyKey;
      case EzTextSettingType.title:
        return EzConfig.isDark
            ? lightTitleFontFamilyKey
            : darkTitleFontFamilyKey;
      case EzTextSettingType.body:
        return EzConfig.isDark ? lightBodyFontFamilyKey : darkBodyFontFamilyKey;
      case EzTextSettingType.label:
        return EzConfig.isDark
            ? lightLabelFontFamilyKey
            : darkLabelFontFamilyKey;
    }
  }

  // Italic/style //

  String get italicKey {
    switch (this) {
      case EzTextSettingType.display:
        return EzConfig.isDark
            ? darkDisplayItalicizedKey
            : lightDisplayItalicizedKey;
      case EzTextSettingType.headline:
        return EzConfig.isDark
            ? darkHeadlineItalicizedKey
            : lightHeadlineItalicizedKey;
      case EzTextSettingType.title:
        return EzConfig.isDark
            ? darkTitleItalicizedKey
            : lightTitleItalicizedKey;
      case EzTextSettingType.body:
        return EzConfig.isDark ? darkBodyItalicizedKey : lightBodyItalicizedKey;
      case EzTextSettingType.label:
        return EzConfig.isDark
            ? darkLabelItalicizedKey
            : lightLabelItalicizedKey;
    }
  }

  String get italicMirror {
    switch (this) {
      case EzTextSettingType.display:
        return EzConfig.isDark
            ? lightDisplayItalicizedKey
            : darkDisplayItalicizedKey;
      case EzTextSettingType.headline:
        return EzConfig.isDark
            ? lightHeadlineItalicizedKey
            : darkHeadlineItalicizedKey;
      case EzTextSettingType.title:
        return EzConfig.isDark
            ? lightTitleItalicizedKey
            : darkTitleItalicizedKey;
      case EzTextSettingType.body:
        return EzConfig.isDark ? lightBodyItalicizedKey : darkBodyItalicizedKey;
      case EzTextSettingType.label:
        return EzConfig.isDark
            ? lightLabelItalicizedKey
            : darkLabelItalicizedKey;
    }
  }

  // Underline/decoration //

  String get underlineKey {
    switch (this) {
      case EzTextSettingType.display:
        return EzConfig.isDark
            ? darkDisplayUnderlinedKey
            : lightDisplayUnderlinedKey;
      case EzTextSettingType.headline:
        return EzConfig.isDark
            ? darkHeadlineUnderlinedKey
            : lightHeadlineUnderlinedKey;
      case EzTextSettingType.title:
        return EzConfig.isDark
            ? darkTitleUnderlinedKey
            : lightTitleUnderlinedKey;
      case EzTextSettingType.body:
        return EzConfig.isDark ? darkBodyUnderlinedKey : lightBodyUnderlinedKey;
      case EzTextSettingType.label:
        return EzConfig.isDark
            ? darkLabelUnderlinedKey
            : lightLabelUnderlinedKey;
    }
  }

  String get underlineMirror {
    switch (this) {
      case EzTextSettingType.display:
        return EzConfig.isDark
            ? lightDisplayUnderlinedKey
            : darkDisplayUnderlinedKey;
      case EzTextSettingType.headline:
        return EzConfig.isDark
            ? lightHeadlineUnderlinedKey
            : darkHeadlineUnderlinedKey;
      case EzTextSettingType.title:
        return EzConfig.isDark
            ? lightTitleUnderlinedKey
            : darkTitleUnderlinedKey;
      case EzTextSettingType.body:
        return EzConfig.isDark ? lightBodyUnderlinedKey : darkBodyUnderlinedKey;
      case EzTextSettingType.label:
        return EzConfig.isDark
            ? lightLabelUnderlinedKey
            : darkLabelUnderlinedKey;
    }
  }

  // Shared //

  bool rebuildCheck(BuildContext context) {
    switch (this) {
      case EzTextSettingType.display:
        return EzConfig.styles.displayLarge !=
            Provider.of<EzDisplayStyleProvider>(context, listen: false).value;
      case EzTextSettingType.headline:
        return EzConfig.styles.headlineLarge !=
            Provider.of<EzHeadlineStyleProvider>(context, listen: false).value;
      case EzTextSettingType.title:
        return EzConfig.styles.titleLarge !=
            Provider.of<EzTitleStyleProvider>(context, listen: false).value;
      case EzTextSettingType.body:
        return EzConfig.styles.bodyLarge !=
            Provider.of<EzBodyStyleProvider>(context, listen: false).value;
      case EzTextSettingType.label:
        return EzConfig.styles.labelLarge !=
            Provider.of<EzLabelStyleProvider>(context, listen: false).value;
    }
  }
}
