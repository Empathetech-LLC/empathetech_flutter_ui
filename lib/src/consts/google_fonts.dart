/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Top 5 Google Fonts according to https://fonts.google.com/analytics
// Last updated: 02/19/2024

const String roboto = 'Roboto';
const String openSans = 'Open Sans';
const String lato = 'Lato';
const String montserrat = 'Montserrat';
const String oswald = 'Oswald';

/// All the [GoogleFonts] currently supported
final Map<String, TextStyle> googleStyles = <String, TextStyle>{
  roboto: GoogleFonts.roboto(),
  openSans: GoogleFonts.openSans(),
  lato: GoogleFonts.lato(),
  montserrat: GoogleFonts.montserrat(),
  oswald: GoogleFonts.oswald(),
};

/// Pass [starter] to the [textStyle] parameter of [gFont]s [GoogleFonts] match
TextStyle fuseWithGFont({required TextStyle starter, required String gFont}) {
  switch (gFont) {
    case roboto:
      return GoogleFonts.roboto(textStyle: starter);
    case openSans:
      return GoogleFonts.openSans(textStyle: starter);
    case lato:
      return GoogleFonts.lato(textStyle: starter);
    case montserrat:
      return GoogleFonts.montserrat(textStyle: starter);
    case oswald:
      return GoogleFonts.oswald(textStyle: starter);
    default:
      return starter;
  }
}
