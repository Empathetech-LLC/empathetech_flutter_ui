library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Returns the [TextStyle] of the [GoogleFonts] matching [fontName]
TextStyle gStyle(String fontName) {
  switch (fontName) {
    case soraKey:
      return GoogleFonts.sora();

    case hahmletKey:
      return GoogleFonts.hahmlet();

    case jetbrainsMonoKey:
      return GoogleFonts.jetBrainsMono();

    case andadaProKey:
      return GoogleFonts.andadaPro();

    case epilogueKey:
      return GoogleFonts.epilogue();

    case interKey:
      return GoogleFonts.inter();

    case encodeSansKey:
      return GoogleFonts.encodeSans();

    case manropeKey:
      return GoogleFonts.manrope();

    case loraKey:
      return GoogleFonts.lora();

    case bioRhymeKey:
      return GoogleFonts.bioRhyme();

    case playfairDisplayKey:
      return GoogleFonts.playfairDisplay();

    case archivoKey:
      return GoogleFonts.archivo();

    case robotoKey:
      return GoogleFonts.roboto();

    case cormorantKey:
      return GoogleFonts.cormorant();

    case spectralKey:
      return GoogleFonts.spectral();

    case ralewayKey:
      return GoogleFonts.raleway();

    case workSansKey:
      return GoogleFonts.workSans();

    case latoKey:
      return GoogleFonts.lato();

    case antonKey:
      return GoogleFonts.anton();

    case oldStandardKey:
      return GoogleFonts.oldStandardTt();

    case errorStyleKey:
    default:
      return TextStyle(
        fontSize: 48,
        color: Colors.red,
      );
  }
}

const String soraKey = 'Sora';
const String hahmletKey = 'Hahmlet';
const String jetbrainsMonoKey = 'JetBrains Mono';
const String andadaProKey = 'Andada Pro';
const String epilogueKey = 'Epilogue';
const String interKey = 'Inter';
const String encodeSansKey = 'Encode Sans';
const String manropeKey = 'Manrope';
const String loraKey = 'Lora';
const String bioRhymeKey = 'BioRhyme';
const String playfairDisplayKey = 'Playfair Display';
const String archivoKey = 'Archivo';
const String robotoKey = 'Roboto';
const String cormorantKey = 'Cormorant';
const String spectralKey = 'Spectral';
const String ralewayKey = 'Raleway';
const String workSansKey = 'Work Sans';
const String latoKey = 'Lato';
const String antonKey = 'Anton';
const String oldStandardKey = 'Old Standard TT';

/// List of [GoogleFonts] (https://fonts.google.com/) EFUI has saved
/// Used in [EzFontSetting] to build each [EzButton]
const List<String> myGoogleFonts = [
  soraKey,
  hahmletKey,
  jetbrainsMonoKey,
  andadaProKey,
  epilogueKey,
  interKey,
  encodeSansKey,
  manropeKey,
  loraKey,
  bioRhymeKey,
  playfairDisplayKey,
  archivoKey,
  robotoKey,
  cormorantKey,
  spectralKey,
  ralewayKey,
  workSansKey,
  latoKey,
  antonKey,
  oldStandardKey,
];
