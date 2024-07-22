/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Accessible fonts taken from https://material.io/blog/how-to-make-text-more-accessible
// Plus some ones I thought were cute

const String alexBrush = 'Alex Brush';
const String atkinsonHyperlegible = 'Atkinson Hyperlegible';
const String fingerPaint = 'Finger Paint';
const String lexend = 'Lexend';
const String noto = 'Noto Sans';
const String openSans = 'Open Sans';
const String pressStart2P = 'Press Start 2 Play';
const String readexPro = 'Readex Pro';
const String roboto = 'Roboto';
const String sourceCodePro = 'Source Code Pro';

/// All the [GoogleFonts] currently supported
final Map<String, TextStyle> googleStyles = <String, TextStyle>{
  alexBrush: GoogleFonts.alexBrush(),
  atkinsonHyperlegible: GoogleFonts.atkinsonHyperlegible(),
  fingerPaint: GoogleFonts.fingerPaint(),
  lexend: GoogleFonts.lexend(),
  noto: GoogleFonts.notoSans(),
  openSans: GoogleFonts.openSans(),
  pressStart2P: GoogleFonts.pressStart2p(),
  readexPro: GoogleFonts.readexPro(),
  roboto: GoogleFonts.roboto(),
  sourceCodePro: GoogleFonts.sourceCodePro(),
};

/// Map of actual names to local mirrors of all supported [googleStyles]
final Map<String, String> googleFontFamilyLookup = <String, String>{
  GoogleFonts.alexBrush().fontFamily!: alexBrush,
  GoogleFonts.atkinsonHyperlegible().fontFamily!: atkinsonHyperlegible,
  GoogleFonts.fingerPaint().fontFamily!: fingerPaint,
  GoogleFonts.lexend().fontFamily!: lexend,
  GoogleFonts.notoSans().fontFamily!: noto,
  GoogleFonts.openSans().fontFamily!: openSans,
  GoogleFonts.pressStart2p().fontFamily!: pressStart2P,
  GoogleFonts.readexPro().fontFamily!: readexPro,
  GoogleFonts.roboto().fontFamily!: roboto,
  GoogleFonts.sourceCodePro().fontFamily!: sourceCodePro,
};

/// Pass [starter] to the [gFont]'s [GoogleFonts.textStyle] param
TextStyle fuseWithGFont({required TextStyle starter, required String gFont}) {
  switch (gFont) {
    case alexBrush:
      return GoogleFonts.alexBrush(textStyle: starter);
    case atkinsonHyperlegible:
      return GoogleFonts.atkinsonHyperlegible(textStyle: starter);
    case fingerPaint:
      return GoogleFonts.fingerPaint(textStyle: starter);
    case lexend:
      return GoogleFonts.lexend(textStyle: starter);
    case noto:
      return GoogleFonts.notoSans(textStyle: starter);
    case openSans:
      return GoogleFonts.openSans(textStyle: starter);
    case pressStart2P:
      return GoogleFonts.pressStart2p(textStyle: starter);
    case readexPro:
      return GoogleFonts.readexPro(textStyle: starter);
    case roboto:
      return GoogleFonts.roboto(textStyle: starter);
    case sourceCodePro:
      return GoogleFonts.sourceCodePro(textStyle: starter);
    default:
      return starter;
  }
}
