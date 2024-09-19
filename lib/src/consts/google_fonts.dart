/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Accessible fonts taken from https://material.io/blog/how-to-make-text-more-accessible
// Plus some ones we think are cute

/// 'AlexBrush'
const String alexBrush = 'AlexBrush';

/// 'AtkinsonHyperlegible'
const String atkinsonHyperlegible = 'AtkinsonHyperlegible';

/// 'FingerPaint'
const String fingerPaint = 'FingerPaint';

/// 'Lexend'
const String lexend = 'Lexend';

/// 'NotoSans'
const String noto = 'NotoSans';

/// 'OpenSans'
const String openSans = 'OpenSans';

/// 'PressStart2P'
const String pressStart2P = 'PressStart2P';

/// 'ReadexPro'
const String readexPro = 'ReadexPro';

/// 'Roboto'
const String roboto = 'Roboto';

/// 'SourceCodePro'
const String sourceCodePro = 'SourceCodePro';

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

/// Human readable names for the [GoogleFonts] currently supported
const Map<String, String> googleStyleNames = <String, String>{
  alexBrush: 'Alex Brush',
  atkinsonHyperlegible: 'Atkinson Hyperlegible',
  fingerPaint: 'Finger Paint',
  lexend: 'Lexend',
  noto: 'Noto Sans',
  openSans: 'Open Sans',
  pressStart2P: 'Press Start 2P',
  readexPro: 'Readex Pro',
  roboto: 'Roboto',
  sourceCodePro: 'Source Code Pro',
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
