/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

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

  bool liveBold(BuildContext context) {
    switch (this) {
      case EzTextSettingType.display:
        return Theme.of(context).textTheme.displayLarge?.fontWeight ==
            FontWeight.bold;
      case EzTextSettingType.headline:
        return Theme.of(context).textTheme.headlineLarge?.fontWeight ==
            FontWeight.bold;
      case EzTextSettingType.title:
        return Theme.of(context).textTheme.titleLarge?.fontWeight ==
            FontWeight.bold;
      case EzTextSettingType.body:
        return Theme.of(context).textTheme.bodyLarge?.fontWeight ==
            FontWeight.bold;
      case EzTextSettingType.label:
        return Theme.of(context).textTheme.labelLarge?.fontWeight ==
            FontWeight.bold;
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

  String? liveFont(BuildContext context) {
    switch (this) {
      case EzTextSettingType.display:
        return Theme.of(context).textTheme.displayLarge?.fontFamily;
      case EzTextSettingType.headline:
        return Theme.of(context).textTheme.headlineLarge?.fontFamily;
      case EzTextSettingType.title:
        return Theme.of(context).textTheme.titleLarge?.fontFamily;
      case EzTextSettingType.body:
        return Theme.of(context).textTheme.bodyLarge?.fontFamily;
      case EzTextSettingType.label:
        return Theme.of(context).textTheme.labelLarge?.fontFamily;
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

  bool liveItalic(BuildContext context) {
    switch (this) {
      case EzTextSettingType.display:
        return Theme.of(context).textTheme.displayLarge?.fontStyle ==
            FontStyle.italic;
      case EzTextSettingType.headline:
        return Theme.of(context).textTheme.headlineLarge?.fontStyle ==
            FontStyle.italic;
      case EzTextSettingType.title:
        return Theme.of(context).textTheme.titleLarge?.fontStyle ==
            FontStyle.italic;
      case EzTextSettingType.body:
        return Theme.of(context).textTheme.bodyLarge?.fontStyle ==
            FontStyle.italic;
      case EzTextSettingType.label:
        return Theme.of(context).textTheme.labelLarge?.fontStyle ==
            FontStyle.italic;
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

  bool liveUnderline(BuildContext context) {
    switch (this) {
      case EzTextSettingType.display:
        return Theme.of(context).textTheme.displayLarge?.decoration ==
            TextDecoration.underline;
      case EzTextSettingType.headline:
        return Theme.of(context).textTheme.headlineLarge?.decoration ==
            TextDecoration.underline;
      case EzTextSettingType.title:
        return Theme.of(context).textTheme.titleLarge?.decoration ==
            TextDecoration.underline;
      case EzTextSettingType.body:
        return Theme.of(context).textTheme.bodyLarge?.decoration ==
            TextDecoration.underline;
      case EzTextSettingType.label:
        return Theme.of(context).textTheme.labelLarge?.decoration ==
            TextDecoration.underline;
    }
  }
}
