library empathetech_flutter_ui;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// All the [GoogleFonts] currently supported
enum EzFonts {
  sora,
  hahmlet,
  jetbrainsMono,
  andadaPro,
  epilogue,
  inter,
  encodeSans,
  manrope,
  lora,
  bioRhyme,
  playfairDisplay,
  archivo,
  roboto,
  cormorant,
  spectral,
  raleway,
  workSans,
  lato,
  anton,
  oldStandard,
}

/// Returns the [TextStyle] of the [GoogleFonts] matching [fontName]
TextStyle gStyle(EzFonts fontName) {
  switch (fontName) {
    case EzFonts.sora:
      return GoogleFonts.sora();

    case EzFonts.hahmlet:
      return GoogleFonts.hahmlet();

    case EzFonts.jetbrainsMono:
      return GoogleFonts.jetBrainsMono();

    case EzFonts.andadaPro:
      return GoogleFonts.andadaPro();

    case EzFonts.epilogue:
      return GoogleFonts.epilogue();

    case EzFonts.inter:
      return GoogleFonts.inter();

    case EzFonts.encodeSans:
      return GoogleFonts.encodeSans();

    case EzFonts.manrope:
      return GoogleFonts.manrope();

    case EzFonts.lora:
      return GoogleFonts.lora();

    case EzFonts.bioRhyme:
      return GoogleFonts.bioRhyme();

    case EzFonts.playfairDisplay:
      return GoogleFonts.playfairDisplay();

    case EzFonts.archivo:
      return GoogleFonts.archivo();

    case EzFonts.cormorant:
      return GoogleFonts.cormorant();

    case EzFonts.spectral:
      return GoogleFonts.spectral();

    case EzFonts.raleway:
      return GoogleFonts.raleway();

    case EzFonts.workSans:
      return GoogleFonts.workSans();

    case EzFonts.lato:
      return GoogleFonts.lato();

    case EzFonts.anton:
      return GoogleFonts.anton();

    case EzFonts.oldStandard:
      return GoogleFonts.oldStandardTt();

    case EzFonts.roboto:
      return GoogleFonts.roboto();
  }
}

/// Returns the [String]-ified name of the [GoogleFonts] matching [fontName]
String gStyleName(EzFonts fontName) {
  switch (fontName) {
    case EzFonts.sora:
      return 'Sora';
    case EzFonts.hahmlet:
      return 'Hahmlet';
    case EzFonts.jetbrainsMono:
      return 'JetBrains Mono';
    case EzFonts.andadaPro:
      return 'Andada Pro';
    case EzFonts.epilogue:
      return 'Epilogue';
    case EzFonts.inter:
      return 'Inter';
    case EzFonts.encodeSans:
      return 'Encode Sans';
    case EzFonts.manrope:
      return 'Manrope';
    case EzFonts.lora:
      return 'Lora';
    case EzFonts.bioRhyme:
      return 'BioRhyme';
    case EzFonts.playfairDisplay:
      return 'Playfair Display';
    case EzFonts.archivo:
      return 'Archivo';
    case EzFonts.roboto:
      return 'Roboto';
    case EzFonts.cormorant:
      return 'Cormorant';
    case EzFonts.spectral:
      return 'Spectral';
    case EzFonts.raleway:
      return 'Raleway';
    case EzFonts.workSans:
      return 'Work Sans';
    case EzFonts.lato:
      return 'Lato';
    case EzFonts.anton:
      return 'Anton';
    case EzFonts.oldStandard:
      return 'Old Standard TT';
  }
}
